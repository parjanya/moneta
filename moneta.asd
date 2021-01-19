#|
  This file is a part of carteiro project.
  Copyright (c) 2019 Edgard Bikelis (bikelis@gmail.com)

  Author: Edgard Bikelis (bikelis@gmail.com)

  Moneta is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or (at
  your option) any later version.

  Moneta is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Moneta.  If not, see <https://www.gnu.org/licenses/>.
|#

(defsystem "moneta"
  :version "1"
  :author "Edgard Bikelis <bikelis@gmail.com>"
  :license "GPLv3"
  :depends-on ("drakma"
               "yason")
  :components ((:file "api-key")
               (:file "moneta"))
  :description "A package for querying exchange rates from
  openexchangerates.org and converting between currencies. You should
  set your api key on api-key.lisp with something like
(defparameter *exchange-api-id* \"\") in it.")
