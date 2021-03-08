(provide 'custom-functions)

(defun org-html-export-to-mhtml (async subtree visible body)
  "Org html export handler which inlines images using data-urls.
  Is automatically registered via org-mode-hook.
  Available using , e e -> h m"

  (cl-letf (((symbol-function 'org-html--format-image) 'format-image-inline))
    (org-html-export-to-html nil subtree visible body)))

(defun format-image-inline (source attributes info)
  (let* ((ext (file-name-extension source))
         (prefix (if (string= "svg" ext) "data:image/svg+xml;base64," "data:;base64,"))
         ;; (data (with-temp-buffer (url-insert-file-contents source) (buffer-string)))
         (data (with-temp-buffer (insert-file-contents source) (buffer-string)))
         (data-url (concat prefix (base64-encode-string data)))
         (attributes (org-combine-plists `(:src ,data-url) attributes)))
    (org-html-close-tag "img" (org-html--make-attribute-string attributes) info)))

(defun org-insert-clipboard-image ()
  "inserts an image from clipboard by writing it to a folder named images in the same directory
  and adding a reference to the current cursor position."
  (interactive)
  (let* ((file (concat "./images/" (number-to-string (float-time)) ".png")))
       (shell-command (concat "xclip -selection clipboard -t image/png -o > " file))
       (insert (concat "[[" file "]]"))
       (org-display-inline-images)))
