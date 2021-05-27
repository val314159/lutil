;;;; lutil.lisp

(in-package #:lutil)

(defun split-string (s &optional (sep #\Space) (start 0)
		       (pos (position sep s :start start )))
  (if (not pos) (list (subseq s start ))
    (cons (subseq s start pos)
	  (split-string s sep (1+ pos) ))))

(defun join-string (a &optional (sep #\Space) (final ""))
  (if (not a) (string final)
    (if (not (cdr a)) (concats (car a) (string final))
      (concats (car a) (string sep)
	       (join-string (cdr a) sep final)))))

(defun split-file-string (s) (split-string s #\/))

(defun  join-file-string (a)  (join-string a #\/ #\/))
