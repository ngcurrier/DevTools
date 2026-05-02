;; PACKAGES

;; add MELPA packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; THEME AND VISUAL SETTINGS

;; show matching parens
(show-paren-mode t)

;; no start up message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; removes *messages* from the buffer
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; no audible or visual bell when emacs is mad
(setq ring-bell-function 'ignore)

;; font size
(set-face-attribute 'default nil :height 90)

;; turn on line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; default frame size
(add-to-list 'default-frame-alist '(width . 180))
(add-to-list 'default-frame-alist '(height . 800))

;; GENERAL SETTINGS

;; use the tab key to make 4 spaces
(setq tab-width 4)
(setq indent-tabs-mode nil)

;; no backup~ files
(setq make-backup-files nil)

;; no #autosave# files
(setq auto-save-default nil)

;; allow upcase (C-x C-u) and downcase (C-x C-l) region
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; KEY BINDINGS/MODIFICATIONS

;; jump to other frame (split screen)
(global-set-key [C-tab] 'other-frame)

;; MODES
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tcc\\'" . c++-mode))

;; set default TeX command
(setq TeX-command-default "pdflatex")
;; only change sectioning colour
(setq font-latex-fontify-sectioning 'color)

;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))

;; do not change super-/sub-script font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil))))

;; exclude bold/italic from keywords
(setq font-latex-deactivated-keyword-classes
    '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))


(setq-default indent-tabs-mode nil)
(show-paren-mode 1)
(setq-default truncate-lines 1)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "/backups"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.                                                                                                                                                                       
 ;; If you edit it by hand, you could mess it up, so be careful.                                                                                                                                                    
 ;; Your init file should contain only one such instance.                                                                                                                                                           
 ;; If there is more than one, they won't work right.                                                                                                                                                               
 '(minimap-mode f)
 '(package-selected-packages '(fzf ## minimap)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.                                                                                                                                                                           
 ;; If you edit it by hand, you could mess it up, so be careful.                                                                                                                                                    
 ;; Your init file should contain only one such instance.                                                                                                                                                           
 ;; If there is more than one, they won't work right.                                                                                                                                                               
 '(minimap-font-face ((t (:height 6 :family "DejaVu Sans Mono")))))

(add-to-list 'default-frame-alist
                          '(font . "DejaVu Sans Mono-8"))

(setq path-to-ctags "~/reliable/software/TAGS")

 (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f ctags -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently."
  (interactive)
  (shell-command (format "ctags -e *.%s" (or extension "el")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently                                                                                                                                              
    (visit-tags-table default-directory nil)))

(global-set-key (kbd "C-x g") `xref-find-references)
(global-set-key (kbd "C-x s") `fzf)

(setq-default c-basic-offset 4)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`                                                                                                                 
;; and `package-pinned-packages`. Most users will not need or want to do this.                                                                                                                                      
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)                                                                                                                        
(package-initialize)
