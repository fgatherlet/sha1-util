(defpackage sha1-util-test
  (:use
   :cl
   :sha1-util
   :prove))
(in-package :sha1-util-test)

(plan nil)

(defvar *string* "abcdef
")
(defvar *sha1* #(189 195 124 7 78 196 238 96 80 214 139 193 51 198 185 18 243 100 116 223))

(ok (equalp (sha1 *string*) *sha1*))
(ok (equalp (sha1 (make-pathname :defaults (or *compile-file-pathname* *load-pathname*) :name "data0" :type "txt")) *sha1*))



(finalize)
