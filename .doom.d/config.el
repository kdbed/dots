

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







(set-frame-parameter (selected-frame) 'alpha '(100 70))


(setq user-full-name "svejk")

;;(setq doom-font (font-spec :family "JuliaMono" :size 23)
;;      doom-variable-pitch-font (font-spec :family "JuliaMono")
;;      doom-serif-font (font-spec :family "JuliaMono"))
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 26)
      ;;doom-variable-pitch-font (font-spec :family "ETBembo" :size 18)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 24))
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
  (load-theme 'doom-outrun-electric t)
  ;;(load-theme 'deep-thought t)
  ;;(load-theme 'boron t)
  ;;(load-theme 'badwolf t)
  ;; Enable flashing mode-line on errors
  ;;(doom-themes-visual-bell-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

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
  (add-hook 'tuareg-mode-hook
            (lambda()
              (when (functionp 'prettify-symbols-mode)
                (prettify-symbols-mode))))
  (setq tuareg-prettify-symbols-full t)


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
  (setq org-roam-directory (file-truename "/home/kdb/Documents/github/kdbed.github.io/org")
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
(setq org-roam-directory "/home/kdb/Documents/github/kdbed.github.io/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(with-eval-after-load 'ox
  (require 'ox-hugo))


(add-hook 'after-init-hook 'org-roam-mode)

;; accept completion from copilot and fallback to company
(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map company-active-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)
         :map company-mode-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)))
;; this seems to add syntax-highlighting to jupyter-python and jupyter-typescript blocks
(after! org-src
 (dolist (lang '(python julia jupyter haskell))
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




(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(setq ob-mermaid-cli-path "/usr/bin/mmdc")
(add-hook 'org-mode-hook 'org-fragtog-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (mermaid . t)))

(require 'lean-mode)


(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

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



(add-hook 'org-mode-hook #'+org-pretty-mode)
(with-eval-after-load "org"
      ;; load extra configs to org mode
      (org-babel-lob-ingest "~/.doom.d/org-mode-extra-configs.org"))

(setq doom-modeline-env-python-executable "/usr/bin/python")
(setq python-shell-interpreter "/usr/bin/python"
      flycheck-python-pycompile-executable "/usr/bin/python")

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.25)
  '(outline-2 :weight bold :height 1.15)
  '(outline-3 :weight bold :height 1.12)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.06)
  '(outline-6 :weight semi-bold :height 1.03)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))


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
  (setq calibredb-root-dir "~/Seagate/calibre")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist `((,calibredb-root-dir)
                                  ("~/Seagate/calibre")))
  

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
  (setq org-ref-default-bibliography '("/home/kdb/Seagate/calibre/catalog.bib"))
  (setq bibtex-completion-bibliography "/home/kdb/Seagate/calibre/catalog.bib")
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





(setq org-format-latex-header "\\documentclass{article}
\\usepackage[usenames]{xcolor}

\\usepackage[T1]{fontenc}

\\usepackage{booktabs}

\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}
% my custom stuff
\\usepackage[nofont,plaindd]{bmc-maths}
\\usepackage{arev}
")





(setq org-format-latex-options
      (plist-put org-format-latex-options :background "Transparent"))


  
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




(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-superstar-prettify-item-bullets t ))

(setq org-ellipsis " ▾ "
      org-hide-leading-stars t
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue)))


(appendq! +ligatures-extra-symbols
          `(:checkbox      "☐"
            :pending       "◼"
            :checkedbox    "☑"
            :list_property "∷"
            :em_dash       "—"
            :ellipses      "…"
            :filetags      "🎫"
            :arrow_right   "→"
            :arrow_left    "←"
            :startup       "⏻"
            :title         "🅃"
            :subtitle      "𝙩"
            :author        "𝘼"
            :date          "𝘿"
            :property      "☸"
            :options       "⌥"
            :macro         "𝓜"
            :html_head     "🅷"
            :html          "🅗"
            :latex_class   "🄻"
            :latex_header  "🅻"
            :beamer_header "🅑"
            :latex         "🅛"
            :attr_latex    "🄛"
            :attr_html     "🄗"
            :attr_org      "⒪"
            :begin_quote   "❝"
            :end_quote     "❞"
            :caption       "☰"
            :header        "›"
            :results       "➟"
            :begin_export  "⏩"
            :end_export    "⏪"
            :properties    "⚙"
            :end           "∎"
            :priority_a   ,(propertize "⚑" 'face 'all-the-icons-red)
            :priority_b   ,(propertize "⬆" 'face 'all-the-icons-orange)
            :priority_c   ,(propertize "■" 'face 'all-the-icons-yellow)
            :priority_d   ,(propertize "⬇" 'face 'all-the-icons-green)
            :priority_e   ,(propertize "❓" 'face 'all-the-icons-blue)))
(set-ligatures! 'org-mode
  :merge t
  :checkbox      "[ ]"
  :pending       "[-]"
  :checkedbox    "[X]"
  :list_property "::"
  :em_dash       "---"
  :ellipsis      "..."
  :arrow_right   "->"
  :arrow_left    "<-"
  :title         "#+title:"
  :subtitle      "#+subtitle:"
  :author        "#+author:"
  :date          "#+date:"
  :filetags      "#+filetags"
  :property      "#+property:"
  :options       "#+options:"
  :startup       "#+startup:"
  :macro         "#+macro:"
  :html_head     "#+html_head:"
  :html          "#+html:"
  :latex_class   "#+latex_class:"
  :latex_header  "#+latex_header:"
  :beamer_header "#+beamer_header:"
  :latex         "#+latex:"
  :attr_latex    "#+attr_latex:"
  :attr_html     "#+attr_html:"
  :attr_org      "#+attr_org:"
  :begin_quote   "#+begin_quote"
  :end_quote     "#+end_quote"
  :caption       "#+caption:"
  :header        "#+header:"
  :begin_export  "#+begin_export"
  :end_export    "#+end_export"
  :results       "#+RESULTS:"
  :property      ":PROPERTIES:"
  :end           ":END:"
  :priority_a    "[#A]"
  :priority_b    "[#B]"
  :priority_c    "[#C]"
  :priority_d    "[#D]"
  :priority_e    "[#E]")
(plist-put +ligatures-extra-symbols :name "⁍")
)




(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))


(setq lsp-rust-server 'rust-analyzer)


(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(setq lsp-ui-doc-enable nil)
(setq lsp-ui-doc-show-with-cursor nil)
(setq lsp-ui-doc-show-with-mouse nil)

