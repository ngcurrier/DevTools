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
