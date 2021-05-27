(asdf:load-system :cffi)
   
(defpackage :ed25519 (:use :common-lisp :cffi))
(in-package :ed25519)

(define-foreign-library ed25519
    (:darwin (:or "ed25519/ed25519.1.dylib" "ed25519/ed25519.dylib"))
  (:unix (:or "ed25519.so.1" "ed25519.so")))

(use-foreign-library ed25519)

(define-foreign-library libcurl
    (:darwin (:or "libcurl.3.dylib" "libcurl.dylib"))
  (:unix (:or "libcurl.so.3" "libcurl.so"))
  (t (:default "libcurl")))

(use-foreign-library libcurl)

(defcfun "encode" :pointer (q :pointer) (x :int))
(defcfun "decode" :pointer (q :pointer) (x :int))

(defcfun "malloc" :pointer (x :int))
(defcfun "free" :void (x :pointer))
(defcfun "memcmp" :int (public :pointer) (private :pointer) (out :int))
(defcfun "memcpy" :pointer (dst :pointer) (src :pointer) (size :int))

(defun malloc-seed () (malloc 32))
(defun malloc-public () (malloc 32))
(defun malloc-private () (malloc 64))
(defun malloc-scalar () (malloc 32))
(defun malloc-secret () (malloc 32))
(defun malloc-signature () (malloc 64))

(defcfun "create_seed" :pointer)
(defcfun "create_public" :pointer (seed :pointer))
(defcfun "create_private" :pointer (seed :pointer))

(defcfun "sha512" :int (message :pointer) (len :int) (out :pointer))
(defcfun "create_sha512" :pointer (message :pointer) (len :int))

(defcfun "ed25519_create_seed" :void (seed :pointer))
(defcfun "ed25519_create_keypair" :void (public :pointer) (private :pointer) (seed :pointer))

(defcfun "ed25519_sign" :void (message :pointer) (len :int) (out :pointer))
(defcfun "ed25519_verify" :pointer (message :pointer) (len :int) (out :pointer))
(defcfun "ed25519_add_scalar" :void (public :pointer) (private :pointer) (out :pointer))

(defcfun "ed25519_key_exchange" :void (public :pointer) (private :pointer) (out :pointer))

(defun read-file (f)
  (if (stringp f) (read-file (open f))
      (let ((line (read-line f nil nil)))
	(if (not line) ""
	    (concatenate 'string line
			 (string #\Newline)
			 (read-file f))))))

(defun encode-chunk (chunk size)
  (copy-seq (foreign-string-to-lisp (encode chunk size))))

(defun sha512-string (s)
  (with-foreign-string (fs s)
    (let*((fsha (create-sha512 fs (length s))))
      (encode-chunk fsha 64))))

(defun sha512-file (f)
  (sha512-string (read-file f)))

#|
(defun process (stuff)
  (when stuff
    (let ((fn (car stuff)))
      
      (format t "[~s][[[~s]]]~%" fn
	      (sha512-string (read-file fn)))

      (process (cdr stuff)))))

(defun main (&rest argv)

  (process argv)
  
  (let ((seed1 (malloc-seed)))
    (ed25519-create-seed seed1))

;  (print (create-seed 12))
;  (print (create-private (create-seed 12)))
;  (print (create-public (create-private (create-seed 12))))
;  (format t "[[[~s]]]~%" (sha512-string (read-file "html/index.html")))
;  (format t "[[[~s]]]~%" (alloc-seed))
;  (format t "[[[~s]]]~%" argv)

  t)
|#
