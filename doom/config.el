

(use-package dashboard
  :init      ;; tweak dashboard config before loading it
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
  ;;(setq dashboard-banner-logo-title "Emacs")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq fancy-splash-image "~/.doom.d/nima.png")
  (setq dashboard-startup-banner (concat doom-private-dir "banners/nima.png"))  ;; use custom image as banner
(setq dashboard-center-content t) ;; set to 't' for centered content
(setq dashboard-items '((recents . 5)
                              (agenda . 5 )
                              (bookmarks . 5)
                              (projects . 5)
                              (registers . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
			      (bookmarks . "book"))))







(set-frame-parameter (selected-frame) 'alpha '(95 50))


(setq user-full-name "svejk")

;;(setq doom-font (font-spec :family "JuliaMono" :size 23)
;;      doom-variable-pitch-font (font-spec :family "JuliaMono")
;;      doom-serif-font (font-spec :family "JuliaMono"))
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 24)
      ;;doom-variable-pitch-font (font-spec :family "ETBembo" :size 18)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 20))
(setq doom-unicode-font (font-spec :family "Fira Mono"))


(setq display-line-numbers-type nil)

;; Thin grey line separating windows
(set-face-background 'vertical-border "grey")
(set-face-foreground 'vertical-border (face-background 'vertical-border))


(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t      ; if nil, bold is universally disabled
        doom-themes-enable-italic t)   ; if nil, italics is universally disabled
  ;;(load-theme 'doom-outrun-electric t)
  ;;(load-theme 'doom-ir-black t)
  (load-theme 'ujelly t)
  ;;(load-theme 'badwolf t)
  ;; Enable flashing mode-line on errors
  ;;(doom-themes-visual-bell-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;(load-theme 'tron-legacy t)

(use-package emojify
  :hook (after-init . global-emojify-mode))




;; data is stored in ~/.elfeed
(setq elfeed-feeds
      '("http://krebsonsecurity.com/feed/"
        "https://www.darkreading.com/rss/all.xml"
        "https://threatpost.com/feed/"
        "https://www.schneier.com/blog/atom.xml"
        "https://nakedsecurity.sophos.com/feed/"
        "https://www.hackingarticles.in/feed/"
        "https://www.sentinelone.com/feed/"
        "https://www.blackhillsinfosec.com/blog/feed/"
        "https://feeds.feedburner.com/TheHackersNews"
        "https://www.zdnet.com/news/rss.xml"))

(setq-default elfeed-search-filter "@20-days-ago +unread")
(setq-default elfeed-search-title-max-width 100)
(setq-default elfeed-search-title-min-width 100)


;;---------------------------------------
;; OCAML MODE CONFIGURATION
;; --------------------------------------
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu) (setq
auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist)) (autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t) (add-hook 'tuareg-mode-hook
'utop-minor-mode) (add-hook 'tuareg-mode-hook 'merlin-mode) (setq
merlin-use-auto-complete-mode t) (setq merlin-error-after-save nil)
;; see Julia manual for the detailed description of this var

(use-package vterm
  :ensure t)

(use-package jupyter
             :ensure t)


(use-package org
  :config
  (setq org-latex-pdf-process '("latexmk -pdf -outdir=%o %f"))
  (setq org-export-with-smart-quotes t)

  ;; export citations
  (require 'ox-bibtex)

  ;; manage citations
  (require 'org-bibtex-extras)

  ;; ignore headline but include content when exporting
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines))

  :custom (org-startup-indented t)
  :bind (:map org-mode-map
              ("<f12>" . org-bibtex-yank)))

(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture)
  (setq org-roam-directory (file-truename "~/Documents/github/org-roam/")
        org-roam-db-gc-threshold most-positive-fixnum
        org-id-link-to-org-use-id t)
  :config
  (org-roam-setup)
  (set-popup-rules!
    `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
      ("^\\*org-roam: " ; node dedicated org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2)))

  (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)
  (setq org-roam-capture-templates  
    '(("d" "default" plain "%?"
    :target (file+head "${slug}.org"
                       "#+title: ${title}\n")
  :unnarrowed t)))
  ;;(setq org-roam-capture-templates
  ;;      '(("d" "default" plain
  ;;         "%?"
  ;;         :target (file+head "${slug}.org"
  ;;                            "#+title: ${title}\n")
  ;;         :immediate-finish t
  ;;         :unnarrowed t)))
          
  (require 'org-roam-protocol))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-roam-directory "~/Documents/github/org-roam/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(with-eval-after-load 'ox
  (require 'ox-hugo))


(add-hook 'after-init-hook 'org-roam-mode)


;; this seems to add syntax-highlighting to jupyter-python and jupyter-typescript blocks
(after! org-src
 (dolist (lang '(python julia jupyter))
 (cl-pushnew (cons (format "jupyter-%s" lang) lang)
                org-src-lang-modes :key #'car))
  ;; (org-babel-jupyter-override-src-block "python") ;; alias all python to jupyter-python
  ;; (org-babel-jupyter-override-src-block "typescript") ;; alias all python to jupyter-python
 )


(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :commands (org-roam-ui-mode)
    :config
    (setq org-roam-ui-port 35900))

(use-package! org-roam-protocol
  :after org-protocol)







(require 'calibredb)
(require 'org-tempo)
(require 'org-make-toc)
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode))
      ;; enable in markdown, too
  (warn "toc-org not found"))

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))


;; Nice bullets
  (use-package org-superstar
      :config
      (setq org-superstar-special-todo-items t)
      (add-hook 'org-mode-hook (lambda ()
                                 (org-superstar-mode 1))))

(use-package! calibredb
  :defer t
  :init
  (autoload 'calibredb "calibredb")
  (map! :leader (:desc "calibredb" :n "ac" #'calibredb))

  :config
  ;; (setq sql-sqlite-program "/usr/bin/sqlite3")
  (setq calibredb-root-dir "~/calibre")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist `((,calibredb-root-dir)
                                  ("~/calibre")))
  

  ;; (use-package! org-ref
  ;;   :after-call calibredb
  ;;   :config
  ;;   (setq calibredb-ref-default-bibliography "~/Desktop/catalog.bib")
  ;;   (add-to-list 'org-ref-default-bibliography calibredb-ref-default-bibliography)
  ;;   (setq org-ref-pdf-directory "~/OneDrive/Doc/Calibre/")
  ;;   (setq org-ref-bibliography-notes "~/OneDrive/Org/Writing/references.org")
  ;;   (setq org-ref-get-pdf-filename-function 'org-ref-get-mendeley-filename))
  (map! :map calibredb-search-mode-map
        :n "q"   'calibredb-search-quit
        :n "n"   'calibredb-virtual-library-next
        :n "N"   'calibredb-library-next
        :n "p"   'calibredb-virtual-library-previous
        :n "P"   'calibredb-library-previous
        :n "l"   'calibredb-virtual-library-list
        :n "o"   'calibredb-find-file
        :n "O"   'calibredb-find-file-other-frame
        :n "V"   'calibredb-open-file-with-default-tool
        :n "v"   'calibredb-view
        :n "d"   'calibredb-remove
        :n "D"   'calibredb-remove-marked-items
        :n "m"   'calibredb-mark-and-forward
        :n "s"   'calibredb-set-metadata-dispatch
        :n "e"   'calibredb-export-dispatch
        ;; :n "b"   'calibredb-catalog-bib-dispatch
        :n "a"   'calibredb-add
        :n "."   'calibredb-open-dired
        :n ","   'calibredb-quick-look
        :n "y"   'calibredb-yank-dispatch
        :n "u"   'calibredb-unmark-and-forward
        :n "DEL" 'calibredb-unmark-and-backward
        :n "s"   'calibredb-set-metadata-dispatch
        :n "?"   'calibredb-dispatch
        :n "/"   'calibredb-search-live-filter
        :n "j" 'calibredb-next-entry
        :n "k" 'calibredb-previous-entry
        :n "M-f"   'calibredb-toggle-favorite-at-point
        :n "M-x"   'calibredb-toggle-archive-at-point
        :n "M-h"   'calibredb-toggle-highlight-at-point
        :n "M-n"   'calibredb-show-next-entry
        :n "M-p"   'calibredb-show-previous-entry
        :n "R"   'calibredb-search-clear-filter
        :n "r"   'calibredb-search-refresh-and-clear-filter
        :n "<backtab>"   'calibredb-toggle-view
        :n "<tab>"   'calibredb-toggle-view-at-point
        :n "TAB"   'calibredb-toggle-view-at-point
        :n "RET" 'calibredb-find-file)

  (map! :map calibredb-show-mode-map
        :nie "q" 'calibredb-entry-quit
        :nie "?" 'calibredb-entry-dispatch
        :nie "RET" 'calibredb-search-ret)


  (add-hook 'calibredb-search-mode-hook #'doom-mark-buffer-as-real-h)
  (add-hook 'calibredb-show-mode-hook #'doom-mark-buffer-as-real-h)
  (use-package! org-ref
  :config
  (setq org-ref-default-bibliography '("/home/kdb/calibre/catalog.bib"))
  (setq bibtex-completion-bibliography "/home/kdb/calibre/catalog.bib")
  )


(plist-put! +ligatures-extra-symbols
  :and           nil
  :or            nil
  :for           nil
  :not           nil
  :true          nil
  :false         nil
  :int           nil
  :float         nil
  :str           nil
  :bool          nil
  :list          nil
  :return        nil
)
(require 'pretty-mode)
(global-pretty-mode t)

(setq org-format-latex-options
      '(:foreground default
        :background default
        :scale 2.0
        :html-foreground "Black"
        :html-background "Transparent"
        :html-scale 1.0
        :matchers ("begin" "$1" "$$" "\\(" "\\[")))

(setq org-preview-latex-default-process 'dvisvgm)
 '(org-preview-latex-process-alist
       (quote
       ((dvipng :programs
         ("lualatex" "dvipng")
         :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
         (1.0 . 1.0)
         :latex-compiler
         ("lualatex -output-format dvi -interaction nonstopmode -output-directory %o %f")
         :image-converter
         ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
 (dvisvgm :programs
          ("latex" "dvisvgm")
          :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "xdv" :image-output-type "svg" :image-size-adjust
          (1.7 . 1.5)
          :latex-compiler
          ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
          :image-converter
          ("dvisvgm %f -n -b min -c %S -o %O"))
 (imagemagick :programs
              ("latex" "convert")
              :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
              (1.0 . 1.0)
              :latex-compiler
              ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
              :image-converter
              ("convert -density %D -trim -antialias %f -quality 100 %O")))))

(pretty-deactivate-groups
 '(:equality :ordering :ordering-double :ordering-triple
             :arrows :arrows-twoheaded :punctuation
             :logic :sets))

(pretty-activate-groups
 '(:sub-and-superscripts :greek :arithmetic-nary))

  )
