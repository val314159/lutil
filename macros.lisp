;;;; macros.lisp

(in-package #:lutil)

(defmacro     fmt (&rest rest) `(format             t  ,@rest))
(defmacro    sfmt (&rest rest) `(format           nil  ,@rest))
(defmacro    efmt (&rest rest) `(format *error-output* ,@rest))
(defmacro concats (&rest rest) `(concatenate  'string  ,@rest))
