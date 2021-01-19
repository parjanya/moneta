# moneta
A CL package for querying exchange rates from openexchangerates.org and converting between currencies.

## how to make it work

1. clone it on `~/quicklisp/local-projects` or wherever your packages live.
2. edit `moneta/api-key.lisp` adding your api key.
3. load it with `(ql:quickload :moneta)`
4. test it with `(moneta:exchange 1 "BTC" "BRL")` or something.

The currency names live inside `moneta::+currency-names+`. They prolly should be keywords instead of strings.
