;; Compyright 2021-2022 Mark Watson All Rights Reserved.
;; License: Apache 2

(in-package #:conceptnet)

(defun hash-keys-and-values (hash-table)
  (loop for key being the hash-keys of hash-table collect (list key (gethash key hash-table))))


(defun conceptnet (query)
  (print query)
  (let* ((response
         (myutils:replace-all
          (myutils:replace-all
           (uiop:run-program 
            (list
             "curl" 
             (concatenate 'string
                          "https://api.conceptnet.io/c/en/"
			  query))
            :output :string)
           "\\u2013" " ")
          "\\u" " "))
	 (results
	  (with-input-from-string
	      (s response)
	    (json:decode-json s))))
  results))

#|
(setf dd (conceptnet:conceptnet "arizona"))
(pprint dd)
|#
