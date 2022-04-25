all: infra.svg

%.svg: %.dot unifont.css
	dot -T svg -o $@ $<

unifont.css:
	curl -Lo unifont.css https://fonts.chrissx.de/unifont
