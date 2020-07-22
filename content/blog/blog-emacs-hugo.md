+++
title = "Making a blog with Emacs, Hugo, and builds.sr.ht"
date = 2020-05-16
tags = ["emacs", "meta"]
draft = false
+++

Today I decided to setup a blog where I can publically voice my opinions, whether they be tech-related or not. I wrote this short first blog post to share some of the code behind this blog, in case anyone else out there wants to setup a blog like this one.

There are many static site generators used for creating blogs, and I ultimately ended up choosing [Hugo](https://gohugo.io). I picked it over Jekyll mainly because Hugo is faster. Like, [_a lot_ faster](https://forestry.io/blog/hugo-vs-jekyll-benchmark/). Not only that, but there's a powerful plugin for Emacs called [ox-hugo](https://ox-hugo.scripter.co), which allows me to write **all** of my blog posts in a [single Org file](https://github.com/erebid/blog.erebid.dev/blob/master/blog.org), and then export it to Markdown for Hugo.

After installing Hugo and setting up a basic theme, I had to get a way to programatically export the blog from Org to Markdown. Although I _can_ do it myself from Emacs, committing the generated Markdown _and_ handwritten Org would make for messy diffs.

I wrote a little script in elisp that would just install ox-hugo:

```emacs-lisp
(require 'package)

(setq package-archives '(("org" . "https://orgmode.org/elpa/")))
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url)))
(setq package-user-dir "/tmp/emacs-blog-stuff")
(package-initialize)
(package-refresh-contents)
(defvar packages '(ox-hugo))
(dolist (p packages)
  (unless (package-installed-p p)
    (package-install p)))
(defun org-hugo-export-all-wim-to-md ()
  (org-hugo-export-wim-to-md :all-subtrees nil nil :noerror))
```

and then I wrote a simple Makefile runs that elisp script, and then generates the Markdown with ox-hugo site with Hugo:

```emacs-lisp
all: md
	hugo

md:
	@echo "Generating blog MD"
	@emacs --kill --batch --eval "(progn\
	(load-file \"./setup.el\")\
	)" ./blog.org \
	-f org-hugo-export-all-wim-to-md \
	@echo "Done"
```

and now, to top it all off, I setup a build manifest for [builds.sr.ht](https://builds.sr.ht), so that as soon as I push any changes to Git, the blog will be automatically updated on the live site.

```yml
image: alpine/edge
packages:
  - emacs-nox
  - hugo
  - rsync
sources:
  - https://github.com/erebid/erebid.dev
environment:
  deploy: sam@144.172.83.108
secrets:
  - 721fdf17-b06d-4168-8bc2-c81a6680abae
tasks:
  - md: |
      cd erebid.dev
      make md
  - hugo: |
      cd erebid.dev
      hugo
  - deploy: |
      cd erebid.dev
      sshopts="ssh -o StrictHostKeyChecking=no"
      rsync --rsh="$sshopts" -avz --delete public/ $deploy:/var/www/erebid.dev
```

And that's pretty much all there is to my blog. If you'd like to see some of the templates and stylesheets, check out the Git repo [here](https://github.com/erebid/blog.erebid.dev).