all: infra.svg

%.svg: %.dot
	dot -T svg -o $@ $<
