R_OPTS=--no-save --no-restore --no-init-file --no-site-file # vanilla, but with --environ

postneo.pdf: postneo.Rmd
	R ${R_OPTS} -e "rmarkdown::render('postneo.Rmd')"
	pdflatex postneo.tex
	bibtex postneo
	pdflatex postneo

