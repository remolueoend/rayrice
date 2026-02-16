;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.


(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."

  ;; add package source URLs
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  ;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-foq-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   ;; ----------------------------------------------------------------
   ;; Example of useful layers you may want to use right away.
   ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
   ;; <M-m f e R> (Emacs style) to install them.
   ;; ----------------------------------------------------------------
   ;; themes-megapack ;; additional themes, see: https://themegallery.robdor.com/
   '(multiple-cursors
     toml
     git
     csv
     javascript
     python
     systemd
     helm
     (auto-completion :variables
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t)
     better-defaults
     emacs-lisp
     markdown
     (org :variables
          org-enable-bootstrap-support t
          org-enable-roam-protocol t)
     (shell :variables
            shell-default-shell 'vterm
            shell-default-height 60
            shell-default-position 'bottom)
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     version-control
     yaml
     vimscript
     lsp
     dap
     xclipboard
     pass
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     keychain-environment
     exec-path-from-shell
     catppuccin-theme
     auto-dark
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         catppuccin
                         spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers 'relative
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ;; adds support for mode-line themes.
   ;; Supported themes are spacemacs, all-the-icons, vim-powerline, custom, and vanilla.
   ;; The first three are spaceline themes, custom is user defined, and vanilla is the default Emacs mode-line
   dotspacemacs-mode-line-themes 'spacemacs
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq evil-respect-visual-line-mode t)
  (add-hook 'org-mode-hook' (lambda()
                              (turn-on-visual-line-mode)
                              (flyspell-mode)
                              (flyspell-prog-mode)
                              ;; register new export menu entry which is defined in '~/.spacemacs.d/custom-functions.el':
                              (org-export-define-derived-backend 'html-inline-images 'html
                                :menu-entry '(?h "Export to HTML" ((?m "As MHTML file an open" org-html-export-to-mhtml))))))
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq catppuccin-flavor 'mocha)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
                                        ; always follow symlinks to files managed by vcs/git:
  (setq vc-follow-symlinks t)
                                        ; load env vars on startup, required to get ssh-agent/keychain integration working:
  (keychain-refresh-environment)
                                        ; same fontsize for emacs and emacsclient
  (setq default-frame-alist '((font . "Source Code Pro-12")))
                                        ; set terminal command for opening a new terminal
  (defun my/server-auto-dark (frame)
    (with-selected-frame frame
      (when (display-graphic-p)
        (auto-dark-mode 1)
        ;; Remove hook so it only runs once
        (remove-hook 'after-make-frame-functions #'my/server-auto-dark))))

  ;; (use-package auto-dark
  ;;   :config
  ;;   (setq auto-dark-themes '((spacemacs-dark) (spacemacs-light)))
  ;;   (add-hook 'after-make-frame-functions #'my/server-auto-dark))

                                        ; include external functions files:
  (load-file "~/.spacemacs.d/custom-functions.el")
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   '(org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download htmlize gnuplot yasnippet-snippets utop tuareg caml ocp-indent merlin zenburn-theme zen-and-art-theme white-sand-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme rebecca-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme spinner organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme parent-mode heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flycheck-rust flycheck-pos-tip pkg-info epl flx flatui-theme flatland-theme farmhouse-theme exotica-theme highlight goto-chg undo-tree espresso-theme f dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme s color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme bind-map bind-key badwolf-theme packed apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme popup toml-mode racer pos-tip cargo rust-mode web-mode tagedit slim-mode scss-mode sass-mode pug-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data helm-company helm-c-yasnippet fuzzy company-tern dash-functional tern company-statistics company auto-yasnippet ac-ispell auto-complete tide typescript-mode flycheck web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode yaml-mode mmm-mode markdown-toc markdown-mode gh-md hydra lv projectile avy anzu iedit smartparens evil helm helm-core async powerline dash smeargle orgit magit-gitflow magit-popup helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient git-commit with-editor ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(ansi-color-faces-vector
     [default bold shadow italic underline bold bold-italic bold])
   '(auth-source-debug nil)
   '(auth-sources '(password-store))
   '(beacon-color "#d54e53")
   '(custom-safe-themes
     '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
   '(evil-want-Y-yank-to-eol nil)
   '(exwm-floating-border-color "#2e2f37")
   '(fci-rule-color "#383838")
   '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
   '(frame-background-mode 'dark)
   '(helm-completion-style 'emacs)
   '(highlight-tail-colors ((("#2d3e3e" "#2d3e3e") . 0) (("#333d49" "#333d49") . 20)))
   '(hl-todo-keyword-faces
     '(("TODO" . "#dc752f") ("NEXT" . "#dc752f") ("THEM" . "#2d9574")
       ("PROG" . "#4f97d7") ("OKAY" . "#4f97d7") ("DONT" . "#f2241f")
       ("FAIL" . "#f2241f") ("DONE" . "#86dc2f") ("NOTE" . "#b1951d")
       ("KLUDGE" . "#b1951d") ("HACK" . "#b1951d") ("TEMP" . "#b1951d")
       ("FIXME" . "#dc752f") ("XXX+" . "#dc752f") ("\\?\\?\\?+" . "#dc752f")))
   '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
   '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
   '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
   '(magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
   '(objed-cursor-color "#ff6c6b")
   '(org-agenda-files
     '("~/agenda/captures.org" "/Users/remo/agenda/agenda_main.org"
       "/Users/remo/org/notes.org"))
   '(org-capture-default-notes-file "~/agenda/capture")
   '(package-selected-packages
     '(ac-ispell ace-jump-helm-line ace-link ace-window adaptive-wrap afternoon-theme
                 aggressive-indent alect-themes alert ample-theme ample-zen-theme
                 anti-zenburn-theme anzu apropospriate-theme async auto-compile
                 auto-complete auto-highlight-symbol auto-yasnippet autothemer avy
                 badwolf-theme bind-key bind-map birds-of-paradise-plus-theme
                 bubbleberry-theme busybee-theme caml cargo catppuccin-theme
                 cherry-blossom-theme clean-aindent-mode clues-theme coffee-mode
                 color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow
                 column-enforce-mode company company-statistics company-tern
                 company-web cyberpunk-theme dakrone-theme darkburn-theme
                 darkmine-theme darkokai-theme darktooth-theme dash
                 dash-functional define-word diminish django-theme dracula-theme
                 dumb-jump elisp-slime-nav emmet-mode epl espresso-theme
                 eval-sexp-fu evil evil-anzu evil-args evil-ediff evil-escape
                 evil-exchange evil-iedit-state evil-indent-plus evil-lisp-state
                 evil-magit evil-matchit evil-mc evil-nerd-commenter evil-numbers
                 evil-search-highlight-persist evil-surround evil-tutor
                 evil-unimpaired evil-visual-mark-mode evil-visualstar
                 exec-path-from-shell exotica-theme expand-region eyebrowse f
                 fancy-battery farmhouse-theme fill-column-indicator
                 flatland-theme flatui-theme flx flx-ido flycheck flycheck-pos-tip
                 flycheck-rust fuzzy gandalf-theme gh-md git-commit git-link
                 git-messenger git-timemachine gitattributes-mode gitconfig-mode
                 gitignore-mode gntp gnuplot golden-ratio google-translate
                 gotham-theme goto-chg grandshell-theme gruber-darker-theme
                 gruvbox-theme haml-mode hc-zenburn-theme helm helm-ag
                 helm-c-yasnippet helm-company helm-core helm-css-scss
                 helm-descbinds helm-flx helm-gitignore helm-make
                 helm-mode-manager helm-projectile helm-swoop helm-themes
                 hemisu-theme heroku-theme highlight highlight-indentation
                 highlight-numbers highlight-parentheses hl-todo htmlize
                 hungry-delete hydra iedit indent-guide inkpot-theme
                 ir-black-theme jazz-theme jbeans-theme js-doc js2-mode
                 js2-refactor json-mode json-reformat json-snatcher
                 light-soap-theme link-hint linum-relative livid-mode log4e
                 lorem-ipsum lush-theme lv macrostep madhat2r-theme magit
                 magit-gitflow magit-popup majapahit-theme markdown-mode
                 markdown-toc material-theme merlin minimal-theme mmm-mode
                 moe-theme molokai-theme monochrome-theme monokai-theme move-text
                 multiple-cursors mustang-theme naquadah-theme neotree
                 noctilux-theme obsidian-theme occidental-theme ocp-indent
                 oldlace-theme omtose-phellack-theme open-junk-file org-bullets
                 org-category-capture org-download org-mime org-plus-contrib
                 org-pomodoro org-present org-projectile organic-green-theme orgit
                 packed paradox parent-mode pcre2el persp-mode
                 phoenix-dark-mono-theme phoenix-dark-pink-theme pkg-info
                 planet-theme popup popwin pos-tip powerline professional-theme
                 projectile pug-mode purple-haze-theme racer railscasts-theme
                 rainbow-delimiters rebecca-theme request restart-emacs
                 reverse-theme rust-mode s sass-mode scss-mode seti-theme
                 simple-httpd skewer-mode slim-mode smartparens smeargle
                 smyx-theme soft-charcoal-theme soft-morning-theme
                 soft-stone-theme solarized-theme soothe-theme spacegray-theme
                 spaceline spinner subatomic-theme subatomic256-theme
                 sunny-day-theme tagedit tango-2-theme tango-plus-theme
                 tangotango-theme tao-theme tern tide toc-org toml-mode toxi-theme
                 transient tuareg twilight-anti-bright-theme twilight-bright-theme
                 twilight-theme typescript-mode ujelly-theme underwater-theme
                 undo-tree use-package utop uuidgen vi-tilde-fringe
                 volatile-highlights web-beautify web-completion-data web-mode
                 which-key white-sand-theme winum with-editor ws-butler yaml-mode
                 yasnippet yasnippet-snippets zen-and-art-theme zenburn-theme))
   '(pdf-view-midnight-colors '("#655370" . "#fbf8ef"))
   '(rustic-ansi-faces
     ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
   '(safe-local-variable-values
     '((eval setq flycheck-clang-include-path
             (list (expand-file-name "~/dev/eth/embedded-systems/lab2/libraries/")))
       (eval setq flycheck-clang-include-path
             (list (expand-file-name "~/remo/dev/eth/embedded-systems/lab2/")))
       (org-latex-pdf-process "pdflatex --shell-escape %f")
       (org-latex-pdf-process . "pdflatex --shell-escape %f")
       (c-c++lsp-enable-semantic-highlight . rainbow)
       (eval setq flycheck-clang-include-path
             (list (expand-file-name "~/dev/libs/eigen-3.3.7")))
       (org-confirm-babel-evaluate) (typescript-backend . tide)
       (typescript-backend . lsp) (javascript-backend . tern)
       (javascript-backend . lsp) (go-backend . go-mode) (go-backend . lsp)))
   '(vc-annotate-background "#282c34")
   '(vc-annotate-color-map
     (list (cons 20 "#98be65") (cons 40 "#b4be6c") (cons 60 "#d0be73")
           (cons 80 "#ECBE7B") (cons 100 "#e6ab6a") (cons 120 "#e09859")
           (cons 140 "#da8548") (cons 160 "#d38079") (cons 180 "#cc7cab")
           (cons 200 "#c678dd") (cons 220 "#d974b7") (cons 240 "#ec7091")
           (cons 260 "#ff6c6b") (cons 280 "#cf6162") (cons 300 "#9f585a")
           (cons 320 "#6f4e52") (cons 340 "#5B6268") (cons 360 "#5B6268")))
   '(vc-annotate-very-old-color nil)
   '(window-divider-mode nil))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:background nil))))
   '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t))
  )
