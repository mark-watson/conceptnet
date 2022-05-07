(in-package #:conceptnet)


(defun conceptnet (query)
  (let* ((response
         (myutils:replace-all
          (myutils:replace-all
           (uiop:run-program 
            (list
             "curl" 
             (concatenate 'string
                          "https://api.conceptnet.io/c/en/example"
                          ;;(drakma:url-encode query :utf-8)
                          ;;"&format=json"
			  ))
            :output :string)
           "\\u2013" " ")
          "\\u" " "))
	(jld-hash (cl-json-ld:jsd-read response)))
    (pprint jld-hash )
    (loop for key being the hash-keys of jld-hash
        do (print (list key ":" (gethash key jld-hash))))
    (with-input-from-string (s response)
      (pprint s)
      (let ((json-as-list (cl-json-ld:jsd-read s)))
        (pprint json-as-list)  ; uncomment this to see how following expression works:
        (mapcar #'(lambda (x)
                    (mapcar #'(lambda (y)
                                (list (car y) (cdaddr y))) x))  (cdr (cadadr json-as-list)))))))

#|
(setf dd (conceptnet:conceptnet "Arizona"))
(pprint dd)
|#
