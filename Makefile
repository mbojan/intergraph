include Makevars

.PHONY: check
check: 
	$(RCALL) check -o $(CHECKDIR) $(CURDIR)

.PHONY: build
build: 
	svnversion > inst/SVNREV
	$(RCALL) build $(SRCDIR)
	rename 's/([0-9])\.tar\.gz/$$1-r$(SVNREV).tar.gz/' $(PKGNAME)*tar.gz

.PHONY: install
install: 
	mkdir -p $(INSTALLDIR)
	$(RCALL) INSTALL -l $(INSTALLDIR) $(SRCDIR)

.PHONY: commit
commit:
	@svn diff > svndiff
	@svn commit --editor-cmd 'vim -c "sp svndiff"'
	@rm svndiff

.PHONY: editr
editr:
	vim -p R/*.R

.PHONY: editman
editman:
	vim -p man/*.Rd


.PHONY: checkcode
checkcode:
	$(RCALL) check  --no-codoc --no-vignettes --no-latex -o $(CHECKDIR) $(SRCDIR)

.PHONY: checkdoc
checkdoc:
	$(RCALL) check --no-tests --no-install -o $(CHECKDIR) $(SRCDIR)

.PHONY: cleanall
cleanall:
	- rm -f $(CHECKDIR) $(PKGPDF) $(PKGDVI)

.PHONY: clean
clean:
	- rm -f *.tar.gz

.PHONY: uninstall
uninstall:
	- rm -R --force $(INSTALLDIR)

# package manuals

.PHONY: pdf
pdf: $(PKGPDF)

$(PKGPDF): $(SRCDIR:=/man/*.Rd)
	$(RCALL) Rd2pdf --no-preview -o $(shell dirname $(SRCDIR))/$(PKGPDF) $(SRCDIR)

.PHONY: dvi
dvi: $(PKGDVI)

$(PKGDVI): $(SRCDIR:=/man/*.Rd)
	$(RCALL) Rd2dvi --no-preview -o $(shell dirname $(SRCDIR))/$(PKGDVI) $(SRCDIR)
