#!/usr/bin/make -f
#
#
SHELL=/bin/bash -o pipefail

LOGFILES = aggregate.error aggregate.log aggregate.ignore
PYFILES = *.py
JSONFILES = *.json


#
#
#
all:
	@echo "make [clean|test|prepare|jsonlint|pylint]"



#
#
#
.PHONY: clean

clean:
	rm -f $(LOGFILES)
	rm -rf build



#
#
#
test: prepare jsonlint pylint



#
#
#
.PHONY: prepare

prepare:
	install -d build



#
#
#
.PHONY: jsonlint $(JSONFILES)

jsonlint: $(JSONFILES)

$(JSONFILES):
	jsonlint --quiet $@ 2>&1 | tee build/jsonlint-$@



#
#
#
.PHONY: pylint

pylint:
	pylint --rcfile=.pylintrc $(PYFILES) | tee build/pylint
