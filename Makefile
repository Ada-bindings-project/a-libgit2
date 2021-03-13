
#package=
#CINCLUDE:=$(shell /usr/bin/pkg-config --cflags package)
#CLIBS=$(shell /usr/bin/pkg-config --libs package)

CFLAGS+=-fdump-ada-spec -C
CFLAGS+=-fada-spec-parent=Git.Low_Level


all:gen


gen:.generate

.generate:Makefile $(wildcard sed/*.sed) src/input.cpp
	rm -rf  .gen src/gen
	mkdir -p .gen src/gen

	
	cd .gen; gcc -c ${CFLAGS} -C  ${CURDIR}/src/input.cpp
	cp .gen/git-low_level-git2*_h.ads src/gen
	cd src/gen; rm -f git-low_level-git2_deprecated_h.ads

	python bin/patch_generated

	@gprbuild  -j0 -k -p -P libgit2.gpr c src/gen/* -u  2>&1 | tee .messages.txt

# evaluate the build and generate empty .sed files for failed specs.
	find sed -size 0 -name "*.sed" -delete
	@if (grep "compilation of" .messages.txt) ; then\
		echo "FAIL#";\
		touch `cat .messages.txt  | grep "compilation of" | grep "failed" | sed "s-  - -g" | cut -f 5 -d " " | \
			sed -e "s-^-sed/-"  -e "s/\.ads$$/.sed/"` sed/all.sed ;\
		rm -f .messages.txt;\
		exit 1;\
	fi
	gnatpp -P libgit2.gpr src/gen/*.ads

	chmod -w src/gen/*.ads
	touch $@

