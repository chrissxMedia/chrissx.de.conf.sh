from email import policy
from email.errors import HeaderParseError
import subprocess

import Milter


class SenderCheck(Milter.Base):
    def envfrom(self, sender, *params):
        self.login = self.getsymval("{auth_authen}")
        self.from_header = None
        return Milter.CONTINUE if self.login else Milter.ACCEPT

    def reject(self, message):
        self.setreply("550", "5.7.1", message)
        return Milter.REJECT

    def header(self, name, value):
        if name.lower() == "from":
            if self.from_header is not None:
                return self.reject("Exactly one From header is required")
            self.from_header = value
        return Milter.CONTINUE

    def eoh(self):
        if self.from_header is None:
            return self.reject("A From header is required")
        try:
            header = policy.default.header_fetch_parse("From", self.from_header)
        except (ValueError, HeaderParseError):
            return self.reject("Invalid From address")
        if (
            header.defects
            or len(header.addresses) != 1
            or any(group.display_name is not None for group in header.groups)
        ):
            return self.reject("Exactly one valid From address is required")

        # Use the same ownership map as Postfix's envelope sender check.
        result = subprocess.run(
            ["postmap", "-q", header.addresses[0].addr_spec, self.sender_logins],
            capture_output=True,
            text=True,
            timeout=10,
        )
        if result.stderr or result.returncode not in (0, 1):
            self.setreply("451", "4.3.0", "Sender ownership lookup failed")
            return Milter.TEMPFAIL
        owners = result.stdout.replace(",", " ").lower().split()
        if self.login.lower() not in owners:
            return self.reject("From address is not owned by the authenticated user")
        return Milter.ACCEPT


if __name__ == "__main__":
    SenderCheck.sender_logins = subprocess.check_output(
        ["postconf", "-xh", "smtpd_sender_login_maps"], text=True
    ).strip()
    Milter.factory = SenderCheck
    Milter.set_flags(0)
    Milter.set_exception_policy(Milter.TEMPFAIL)
    Milter.runmilter("sender-check", "inet:12302@127.0.0.1")
