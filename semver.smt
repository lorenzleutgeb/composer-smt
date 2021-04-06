; Maybe
(declare-datatypes ((Maybe 1)) ((par (X) ((none) (some (val X))))))

(declare-datatypes ((Version 0)) (((version (major Int) (minor Int) (patch Int) (prerelease (Maybe String)) (metadata (Maybe String))))))

(declare-datatypes ((Package 0)) (((package (name String) (xversion Version)))))

; https://getcomposer.org/doc/articles/versions.md#stabilities
(declare-datatype Stability ((dev) (alpha) (beta) (rc) (stable)))

(define-fun stability2int ((stability Stability)) Int
  (match stability (
    (dev 1)
    (alpha 2)
    (beta 3)
    (rc 4)
    (stable 5)
  ))
)

; TODO: This is input.
; https://getcomposer.org/doc/04-schema.md#minimum-stability
(define-const minimumStability Stability stable)

; TODO: This is input.
; https://getcomposer.org/doc/04-schema.md#prefer-stable
(define-const preferStable Bool true)

; "Lower than" primitive for SemVer.
(define-fun svlt ((left Version) (right Version)) Bool
  (ite
    (< (major left) (major right))
    true
    (ite
      (< (minor left) (minor right))
      true
      (< (patch left) (patch right))
    )
  )
)

; TODO: Stability constraints.

; TODO: Actions 

(declare-const x Int)
(declare-const y Int)

(assert (svlt (version x 0 0 none none) (version 2 0 0 none none)))
(assert (svlt (version 1 0 0 none none) (version y 0 0 none none)))

(check-sat)
(get-model)
