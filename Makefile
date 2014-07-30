files:=howto

.PHONY: all
all: $(files:=.html)

%.html: %.Rmd
	echo "rmarkdown::render('$<')" | R --no-save --no-restore --quiet

