(in-package :sha1-util)

(defgeneric sha1 (x))

(defmethod sha1 ((x string))
  (ironclad:digest-sequence :sha1 (babel:string-to-octets x)))

(defmethod sha1 ((x pathname))
  (ironclad:digest-file :sha1 x))

(defmethod sha1 ((x stream))
  (ironclad:digest-stream :sha1 x))

(defun sha1-as-int64-array (x)
  (sha1-to-int64-array (sha1 x)))

(defun sha1-as-hex (x)
  (sha1-to-hex (sha1 x)))


(defun int64-array-to-hex (x)
  (sha1-to-hex (int64-array-to-sha1 x)))

(defun hex-to-int64-array (x)
  (sha1-to-int64-array (hex-to-sha1 x)))

(defun sha1-to-hex (x)
  (ironclad:byte-array-to-hex-string x))

(defun hex-to-sha1 (x)
  (ironclad:hex-string-to-byte-array x))

(defun sha1-to-int64-array (x)
  (let* ((yu (make-array 3 :initial-element 0 :element-type '(unsigned-byte 64)))
         (y  (make-array 3 :initial-element 0 :element-type '(signed-byte 64)))
         )
    (loop
      for i from 0 below 20
      do (multiple-value-bind (q d) (floor i 8)
           (setf (ldb (byte 8 (* 8 d)) (aref yu q)) (aref x i))
           ))
    (loop for i from 0 below 3
          do (setf (aref y i) (uint64-to-int64 (aref yu i))))
    y
    ))

(defun int64-array-to-sha1 (y)
  (let* ((x (make-array 20 :initial-element 0))
         (yu (make-array 3 :element-type '(unsigned-byte 64)))
         )
    (loop for i from 0 below 3
          do (setf (aref yu i) (int64-to-uint64 (aref y i))))
    (loop
      for i from 0 below 20
      do (multiple-value-bind (q d) (floor i 8)
           (setf (aref x i) (ldb (byte 8 (* 8 d)) (aref yu q)))
           ))
    x
    ))


(let ((base (ash 1 64)))
  (defun uint64-to-int64 (x)
    (if (= 1 (ldb (byte 2 63) x))
        (- x base)
      x))

  (defun int64-to-uint64 (x)
    (if (minusp x)
        (+ base x)
      x)))

;;(defun sha1-to-int64-array (x)
;;  (let ((tmp (sha1-to-uint64-array x))
;;        (y (make-array 3 :element-type '(signed-byte 64))))
;;    (loop for i from 0 below 3
;;          do (setf (svref y i)
;;                   (uint64-to-int64 (svref x i))))))
;;
;;(defun int64-array-to-sha1 (y)
;;  (let ((y1 (make-array 3 :element-type '(unsigned-byte 64))))
;;    (loop for i from 0 below 3
;;          do (setf (svref y1 i)
;;                   (int64-to-uint64 (svref y i))))
;;

