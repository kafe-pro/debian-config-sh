;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;(setq doom-theme 'doom-shades-of-purple)
(setq doom-theme 'leuven-dark)

(setq display-line-numbers-type t)

(setq org-directory "~/notes/")

;; https://emacs.stackexchange.com/questions/14758/in-org-mode-how-to-always-display-inline-images-at-emacs-startup
(setq org-startup-with-inline-images t)

;; https://stackoverflow.com/questions/20882935/how-to-move-between-visual-lines-and-move-past-newline-in-evil-mode
;; Selection enable horizontal movement cross lines
(setq-default evil-cross-lines t)

;; https://stackoverflow.com/questions/65335591/how-to-override-the-keybindings-for-emacs-org-mode-org-property-next-allowed-val#65363140
;; Selection enable SHIFT select
(setq org-support-shift-select 'always)

;; EMACS-SQLITE
;;Disable: (setq emacsql-sqlite-default-connection 'sqlite3)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; https://www.reddit.com/r/DoomEmacs/comments/nkjoo8/ways_to_copy_to_system_clipboard_from_doom/
;; Copy, Cut and Paste
(defun copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard.")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard.")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  "Pastes from x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )

(map! :leader
      :desc "copy-to-clipboard"
      "o y" #'copy-to-clipboard)
(map! :leader
      :desc "paste-from-clipboard"
      "o p" #'paste-from-clipboard)

;; https://www.reddit.com/r/DoomEmacs/comments/nkjoo8/ways_to_copy_to_system_clipboard_from_doom/
;; Copy/Cut/Paste keybinds
(map! "C-x y" #'copy-to-clipboard)
(map! "C-x c" #'evil-delete)
(map! "C-x p" #'paste-from-clipboard)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; https://www.youtube.com/watch?v=8BOiRmjw5aU
;; https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/doom/config.org#neotree
;; ORG-AGENDA better view
(setq org-agenda-block-separator 45)
(setq org-agenda-custom-commands
      '(("v" "org-agenda better view mode"
         ((agenda "" ((org-agenda-span 'week)))
;;Disable:         (tags-todo "PRIORITY=\"A\""
;;Disable:                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;Disable:                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
;;Disable:          (tags-todo "PRIORITY=\"B\""
;;Disable:                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;Disable:                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
;;Disable:          (tags-todo "PRIORITY=\"C\""
;;Disable:                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;Disable:                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (alltodo "")
          (agenda "" ((org-agenda-span 'year)))))))

;; https://emacs.stackexchange.com/questions/10012/a-search-interface-for-org-mode-files
;; https://stackoverflow.com/questions/71901973/append-org-agenda-files-with-files-of-another-directory
;; ORG-AGENDA search in all files
(setq org-agenda-files '("~/notes/"
                         "~/notes/todo/"
                         "~/notes/sync-android/"
                         "~/notes/sync-android/todo/"
                         "~/notes/sync-laptop/"
                         "~/notes/sync-laptop/todo/"
                         ))

;; ORG-AGENDA keybinds
(map! :leader
      :desc "org-agenda"
      "e a a" #'org-agenda)
(map! :leader
      :desc "org-priority"
      "e a p" #'org-priority)
(map! :leader
      :desc "org-schedule"
      "e a s" #'org-schedule)
(map! :leader
      :desc "org-todo"
      "e a t" #'org-todo)

;; https://www.youtube.com/watch?v=Ea_-TaEGa7Y
;; ORG-AGENDA set as DONE with note
(setq org-log-done 'note)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; https://github.com/org-roam/org-roam
;; https://www.youtube.com/watch?v=AyhPmypHDEw
;; https://github.com/doomemacs/doomemacs/issues/7319
;; ORG-ROAM setup
;;Disable: (use-package org-roam
;;Disable:   :ensure t
;;Disable:   :custom
;;Disable:   (org-roam-directory (file-truename "~/notes"))
;;Disable:   :config
;;Disable:   (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;Disable:   (org-roam-db-autosync-mode)
;;Disable: (require 'org-roam-protocol))

(after! org
(setq org-roam-directory "~/notes/")
(org-roam-db-autosync-mode)
;;Disable: (org-roam-completion-everywhere t)
)

;; https://www.youtube.com/watch?v=AyhPmypHDEw
;; ORG-ROAM keybinds
(map! :leader
      :desc "org-roam-alias-add"
      "e r a" #'org-roam-alias-add)
(map! :leader
      :desc "org-roam-buffer-toggle"
      "e r b" #'org-roam-buffer-toggle)
(map! :leader
      :desc "org-roam-node-create"
      "e r c" #'org-id-get-create)
(map! :leader
      :desc "org-roam-node-find"
      "e r f" #'org-roam-node-find)
(map! :leader
      :desc "org-roam-node-insert"
      "e r i" #'org-roam-node-insert)
(map! :leader
      :desc "auto-complete-node-insert"
      "e r I" #'completion-at-point)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; https://github.com/org-roam/org-roam-ui
;; ORG-ROAM-UI setup
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; ORG-ROAM-UI keybinds
(map! :leader
      :desc "org-roam-ui"
      "e r u" #'org-roam-ui-open)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; ORG-TABLE-COLUMN
(map! :leader
      :desc "insert column"
      "e t c i" #'org-table-insert-column)

(map! :leader
      :desc "delete column"
      "e t c d" #'org-table-delete-column)

(map! :leader
      :desc "move column right"
      "e t c e" #'org-table-move-column-right)

(map! :leader
      :desc "move column left"
      "e t c q" #'org-table-move-column-left)

;; ORG-TABLE-ROW
(map! :leader
      :desc "insert row"
      "e t r i" #'org-table-insert-row)

(map! :leader
      :desc "delete row"
      "e t r d" #'org-table-kill-row)

(map! :leader
      :desc "move row up"
      "e t r e" #'org-table-move-row-up)

(map! :leader
      :desc "move row down"
      "e t r q" #'org-table-move-row-down)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; TREEMACS keybinds
(map! :leader
      :desc "select treemacs window"
      "e w t" #'treemacs-select-window)
(map! :leader
      :desc "toggle treemacs"
      "e w T" #'+treemacs/toggle)
(map! :leader
      :desc "select treemacs directory"
      "e w d" #'treemacs-select-directory)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; EMACS INLINE IMAGE TOGGLE
(map! :leader
      :desc "toggle inline images"
      "e w i" #'org-toggle-inline-images)

;; EMACS LINE WRAPPING TOGGLE
(map! :leader
      :desc "toggle truncate lines"
      "e t l" #'toggle-truncate-lines)

;; EMACS STARTUP
(add-hook 'emacs-startup-hook 'treemacs)

;; --------------------------------------------------------------------------------------------------------------------------------------------

;; ORG LATEX PREVIEW
(setq org-preview-latex-default-process 'dvipng)

(setq org-preview-latex-process-alist
      '((dvipng :programs ("latex" "dvipng")
                :description "dvi -> png"
                :message "You need to install latex and dvipng."
                :image-input-type "dvi"
                :image-output-type "png"
                :latex-compiler ("latex -interaction nonstopmode -output-directory %o %f")
                :image-converter ("dvipng -bg 'Transparent' -D %D -T tight -o %O %f"))))

(setq org-preview-latex-image-directory "arquivos/ltximg/")

(map! :leader
      :desc "org latex preview"
      "e w l" #'org-latex-preview)

;; --------------------------------------------------------------------------------------------------------------------------------------------

(map! :leader
      :desc "org noter attach file"
      "e n n" #'org-noter)

(map! :leader
      :desc "org noter insert note"
      "e n i" #'org-noter-insert-precise-note)

;; --------------------------------------------------------------------------------------------------------------------------------------------
