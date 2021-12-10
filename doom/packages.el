;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.
(package! org-babel-eval-in-repl)
(package! org-ref)
(package! ox-hugo)
(package! julia-mode)
(package! haskell-mode)
(package! lsp-haskell)
(package! flycheck-aspell)
(package! async)
(package! dashboard)
(package! dired-open)
(package! dmenu)
(package! elfeed-goodies)
(package! elpher)
(package! emojify)
(package! evil-tutor)
(package! exwm)
(package! hyperbole)
(package! ivy-posframe)
(package! mastodon)
(package! org-bullets)
(package! ox-gemini)
(package! peep-dired)
(package! pianobar)
(package! rainbow-mode)
(package! resize-window)
(package! tldr)
(package! org-superstar)
(package! org-make-toc)
(package! org-roam-ui)
(package! wc-mode)
(package! pretty-mode)
;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
(package! jupyter)
(package! calibredb :recipe (:host github :repo "chenyanming/calibredb.el"))

