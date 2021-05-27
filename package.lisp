;;;; package.lisp

(defpackage #:lutil
  (:use #:cl)
  (:export #:split-string #:join-string
	   #:split-file-string #:join-file-string
	   #:concats #:fmt #:sfmt #:efmt
	   ))
