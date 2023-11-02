; extends

((tag
  (name) @text.debug @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.debug "N4" "N4_DEBUG" "DEBUG"))

("text" @text.debug @nospell
 (#any-of? @text.debug "N4:" "N4_DEBUG" "DEBUG:"))
