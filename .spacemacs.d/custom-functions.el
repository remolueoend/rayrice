(defun er-sudo-edit (&optional arg)
  "Edit currently visited file as root

  With a prefix ARG promp for a fiile to visit.
  Will also promop for a file to visit if current
  buffer is not visiting a file."

  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file (as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun reverse-region (beg end)
  "Reverse characters between BEG and END."
  (interactive "r")
  (let ((region (buffer-substring beg end)))
    (delete-region beg end)
    (insert (nreverse region))))

(provide 'custom-functions)


(defun org-html-export-to-mhtml (async subtree visible body)
  (interactive "foobar")
  (cl-letf (((symbol-function 'org-html--format-image) 'format-image-inline))
    (org-html-export-to-html nil subtree visible body)))

(defun format-image-inline (source attributes info)
  (let* ((ext (file-name-extension source))
         (prefix (if (string= "svg" ext) "data:image/svg+xml;base64," "data:;base64,"))
         (data (with-temp-buffer (url-insert-file-contents source) (buffer-string)))
         (data-url (concat prefix (base64-encode-string data)))
         (attributes (org-combine-plists `(:src ,data-url) attributes)))
    (org-html-close-tag "img" (org-html--make-attribute-string attributes) info)))

;; (org-export-define-derived-backend 'html-inline-images 'html
;;   :menu-entry '(?h "Export to HTML" ((?m "As MHTML file an open" org-html-export-to-mhtml))))
