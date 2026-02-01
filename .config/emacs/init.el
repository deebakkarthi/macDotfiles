;; Variables are locally scoped
;; -*- lexical-binding: t; -*-
(require 'package)

(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")) ;; ELPA and NonGNU ELPA are default in Emacs28

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") ;; w/o this Emacs freezes when refreshing ELPA

(package-initialize)
(setq package-enable-at-startup nil)

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose nil)
(setq use-package-compute-statistics t)

(use-package gcmh
  :diminish gcmh-mode
  :config
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 16 1024 1024))  ; 16mb
  (gcmh-mode 1))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-percentage 0.1))) ;; Default value for `gc-cons-percentage'

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(use-package no-littering)

(no-littering-theme-backups)


(setq visible-bell nil)
(column-number-mode)
(global-display-line-numbers-mode t)

;; A frame is OS window. What you would call a "pane" is what emacs
;; considers a window.
(set-frame-font "IosevkaTerm Nerd Font Mono:size=18" nil t)

;; Disable the damn thing by making it disposable.
(setq custom-file (make-temp-file "emacs-custom-"))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package org
  :config
  (setq org-M-RET-may-split-line '((default . nil)))
  (setq org-insert-heading-respect-content t)
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files (list org-directory))
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  )


(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "CANCEL(c!)" "DONE(d!)")))


(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/Documents/org/"))

  ;; Automatically rename Denote buffers when opening them so that
  ;; instead of their long file name they have, for example, a literal
  ;; "[D]" followed by the file's title.  Read the doc string of
  ;; `denote-rename-buffer-format' for how to modify this.
  (denote-rename-buffer-mode 1))

(use-package ef-themes)
(ef-themes-select 'ef-dark)

(use-package nerd-icons
  :ensure t)
(use-package nerd-icons-dired
  :ensure t
  :if (display-graphic-p)
  :hook
  (dired-mode . nerd-icons-dired-mode))


;; Completion
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

; Minibuffer completion
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(setq insert-directory-program "gls")
(use-package dired
  :ensure nil
  :custom ((dired-listing-switches "-al --group-directories-first")
	   (dired-use-ls-dired t)
	   )
  )

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
