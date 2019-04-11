#|
  This file is a part of sha1-util project.
  Copyright (c) 2019 fgatherlet (fgatherlet@gmaill.com)
|#

#|
  collection of util to handle sha1 data.

  Author: fgatherlet (fgatherlet@gmaill.com)
|#

(defsystem "sha1-util"
  :version "0.1.0"
  :author "fgatherlet"
  :license "MIT"
  :depends-on ("series"
               "babel"
               "ironclad")
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "main" :depends-on ("package"))
                 )))
  :description "collection of util to handle sha1 data."
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "sha1-util-test"))))
