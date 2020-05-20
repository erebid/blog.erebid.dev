all: md
	hugo

md:
	@echo "Generating blog MD"
	@emacs --kill --batch --eval "(progn\
	(load-file \"./setup.el\")\
	)" ./blog.org \
	-f org-hugo-export-all-wim-to-md \
	@echo "Done"
