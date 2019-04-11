#|
  This file is a part of sha1-util project.
  Copyright (c) 2019 fgatherlet (fgatherlet@gmaill.com)
|#

(defsystem "sha1-util-test"
  :defsystem-depends-on ("prove-asdf")
  :author "fgatherlet"
  :license "MIT"
  :depends-on ("sha1-util"
               "prove")
  :components ((:module "t"
                :components
                ((:test-file "test"))))
  :description "Test system for sha1-util"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
