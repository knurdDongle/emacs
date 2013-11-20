;;; rc-markup.el ---


;; Markdown

(when (require 'markdown-mode nil t)
  (autoload 'markdown-mode "markdown-mode.el"
    "Major mode for editing Markdown files" t)
  (add-to-list 'auto-mode-alist '("\\.md\\|\\.markdown" . markdown-mode)))

;; HTML, CSS

(add-hook 'sgml-mode-hook (lambda () (setq tab-width 2)))

(when (require 'rainbow-mode nil t)
  (add-hook 'html-mode-hook 'rainbow-turn-on)
  (add-hook 'css-mode-hook 'rainbow-turn-on))

(sp-with-modes '(html-mode sgml-mode)
  (sp-local-pair "<" ">"))

;; gettext

(when (require 'po-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.po\\'\\|\\.po\\." . po-mode))
  (autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t))

;; LaTeX via AucTeX

(when (require 'tex-site nil t)
  (setq TeX-view-program-list
        '(("DVI Viewer" "open %o")
          ("PDF Viewer" "open %o")
          ("HTML Viewer" "open %o"))
        TeX-auto-save t
        TeX-parse-self t
        TeX-DVI-via-PDFTeX t)

  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook '(lambda ()
                                (TeX-fold-mode 1)
                                (TeX-PDF-mode 1)
                                (outline-minor-mode 1))))

(eval-after-load "tex"
  '(setcdr (assoc "LaTeX" TeX-command-list)
          '("%`%l%(mode) -shell-escape%' %t"
          TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))

;;; rc-markup.el ends here