;; (ql:quickload :sha1-util)
(defpackage sha1-util
  (:use :cl)
  (:export
   :sha1
   :sha1-as-int64-array
   :sha1-as-hex

   :int64-array-to-hex
   :hex-to-int64-array
   :sha1-to-hex
   :hex-to-sha1
   :sha1-to-int64-array
   :int64-array-to-sha1
  ))

