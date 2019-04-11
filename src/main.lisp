(in-package :sha1-util)

(defgeneric sha1 (x))

(defmethod sha1 ((x string))
  (ironclad:digest-sequence :sha1 (babel:string-to-octets x)))

(defmethod sha1 ((x pathname))
  (ironclad:digest-file :sha1 x))

(defmethod sha1 ((x stream))
  (ironclad:digest-stream :sha1 x))

(defun sha1-as-uint64-array (x)
  (sha1-to-uint64-array (sha1 x)))

(defun sha1-as-hex (x)
  (sha1-to-hex (sha1 x)))


(defun uint64-array-to-hex (x)
  (sha1-to-hex (uint64-array-to-sha1 x)))

(defun hex-to-uint64-array (x)
  (sha1-to-uint64-array (hex-to-sha1 x)))

(defun sha1-to-hex (x)
  (ironclad:byte-array-to-hex-string x))

(defun hex-to-sha1 (x)
  (ironclad:hex-string-to-byte-array x))

(defun sha1-to-uint64-array (x)
  (let* ((xlen 20)
         (ylen 3)
         (y (make-array ylen :initial-element 0 :element-type '(unsigned-byte 64)))
         )
    (loop
      for i from 0 below xlen
      do (multiple-value-bind (q d) (floor i 8)
           (setf (ldb (byte 8 (* 8 d)) (aref y q)) (aref x i))
           ))
    y
    ))

(defun uint64-array-to-sha1 (y)
  (let* ((xlen 20)
         ;;(ylen 3)
         (x (make-array xlen :initial-element 0))
         )
    (loop
      for i from 0 below xlen
      do (multiple-value-bind (q d) (floor i 8)
           (setf (aref x i) (ldb (byte 8 (* 8 d)) (aref y q)))
           ))
    x
    ))

