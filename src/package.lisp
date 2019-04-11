;; (ql:quickload :sha1-util)
(defpackage sha1-util
  (:use :cl)
  (:export
   :sha1
   :sha1-as-uint64-array
   :sha1-as-hex

   :uint64-array-to-hex
   :hex-to-uint64-array
   :sha1-to-hex
   :hex-to-sha1
   :sha1-to-uint64-array
   :uint64-array-to-sha1
  ))

