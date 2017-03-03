;;; helm-sql-mode.el --- Choose a database to connect to via Helm.
;; Copyright 2017 Eric Hansen
;;
;; Author: Eric Hansen <hansen.c.eric@gmail.com>
;; Maintainer: Eric Hansen <hansen.c.eric@gmail.com>
;; Keywords: tools convenience comm
;; URL: https://github.com/eric-hansen/helm-sql-mode
;; Created: 1st March 2017
;; Version: 0.0.1
;; Package-Requires: ((helm "0.0.0"))

;;; Commentary:
;;
;; Only Postgres is supported right now, but fixing that is definitely on the TODO.

;;; Code:

(require 'sql)
(require 'helm)

(defun helm-sql-connect ()
  "Populate helm buffer with connection string names from a populated sql-connection-alist."
  (with-helm-current-buffer
    (mapcar (lambda (element)
          (let ((key (car element))
                (value (cdr element)))
            (message "%s" key))) sql-connection-alist)))

(defvar helm-sql-connection-pool
  '((name . "PGSQL Connections")
    (candidates . helm-sql-connect)
    (action . (lambda (connection)
                (sql-connect connection)))))

;;;###autoload
(defun helm-sql-connect-to ()
  "Helm directive to call when wanting to list SQL connections to connect to."
  (interactive)
  (helm :sources '(helm-sql-connection-pool)
        :buffer "*helm-sql-connection*"))

(provide 'helm-sql-mode)

;;; helm-sql-mode.el ends here
