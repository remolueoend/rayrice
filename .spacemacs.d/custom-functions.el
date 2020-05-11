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

