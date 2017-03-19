;;; helm-sql-connect.el --- Choose a database to connect to via Helm.
;; Copyright 2017 Eric Hansen
;;
;; Author: Eric Hansen <hansen.c.eric@gmail.com>
;; Maintainer: Eric Hansen <hansen.c.eric@gmail.com>
;; Keywords: tools convenience comm
;; URL: https://github.com/eric-hansen/helm-sql-connect
;; Created: 1st March 2017
;; Version: 0.0.1
;; Package-Requires: ((helm "0.0.0"))

;;; Commentary:
;;
;; Pretty cool, huh?!

;;; Code:

(require 'sql)
(require 'helm)

(defun helm-sql-connect-to ()
  "Populate helm buffer with connection string names from a populated ‘sql-connection-alist’."
  (with-helm-current-buffer
    (let (connection-names '())
      (setq connection-names (mapcar 'car sql-connection-alist))
      connection-names)))

(defvar helm-sql-connect-pool
  '((name . "SQL Connections")
    (candidates . helm-sql-connect-to)
    (action . (lambda (connection)
                (sql-connect connection)))))

;;;###autoload
(defun helm-sql-connect ()
  "Helm directive to call when wanting to list SQL connections to connect to."
  (interactive)
  (helm :sources '(helm-sql-connection-pool)
        :buffer "*helm-sql-connect*"))

(provide 'helm-sql-connect)

;;; helm-sql-connect.el ends here
