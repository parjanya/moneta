(in-package :cl-user)

(defpackage moneta
  (:use :cl)
  (:export convert))

(in-package :moneta)

(defparameter *exchange-api-id* "") ;; tmp value before loading api-key.lisp
(defconstant +posix-epoch+ (encode-universal-time 0 0 0 1 1 1970 0))
(defconstant +currency-names+ '(("AED" . "United Arab Emirates Dirham")
				("AFN" . "Afghan Afghani")
				("ALL" . "Albanian Lek")
				("AMD" . "Armenian Dram")
				("ANG" . "Netherlands Antillean Guilder")
				("AOA" . "Angolan Kwanza")
				("ARS" . "Argentine Peso")
				("AUD" . "Australian Dollar")
				("AWG" . "Aruban Florin")
				("AZN" . "Azerbaijani Manat")
				("BAM" . "Bosnia-Herzegovina Convertible Mark")
				("BBD" . "Barbadian Dollar")
				("BDT" . "Bangladeshi Taka")
				("BGN" . "Bulgarian Lev")
				("BHD" . "Bahraini Dinar")
				("BIF" . "Burundian Franc")
				("BMD" . "Bermudan Dollar")
				("BND" . "Brunei Dollar")
				("BOB" . "Bolivian Boliviano")
				("BRL" . "Brazilian Real")
				("BSD" . "Bahamian Dollar")
				("BTC" . "Bitcoin")
				("BTN" . "Bhutanese Ngultrum")
				("BWP" . "Botswanan Pula")
				("BYN" . "Belarusian Ruble")
				("BYR" . "Belarusian Ruble (pre-2016)")
				("BZD" . "Belize Dollar")
				("CAD" . "Canadian Dollar")
				("CDF" . "Congolese Franc")
				("CHF" . "Swiss Franc")
				("CLF" . "Chilean Unit of Account (UF)")
				("CLP" . "Chilean Peso")
				("CNH" . "Chinese Yuan (Offshore)")
				("CNY" . "Chinese Yuan")
				("COP" . "Colombian Peso")
				("CRC" . "Costa Rican Colón")
				("CUC" . "Cuban Convertible Peso")
				("CUP" . "Cuban Peso")
				("CVE" . "Cape Verdean Escudo")
				("CZK" . "Czech Republic Koruna")
				("DJF" . "Djiboutian Franc")
				("DKK" . "Danish Krone")
				("DOP" . "Dominican Peso")
				("DZD" . "Algerian Dinar")
				("EEK" . "Estonian Kroon")
				("EGP" . "Egyptian Pound")
				("ERN" . "Eritrean Nakfa")
				("ETB" . "Ethiopian Birr")
				("EUR" . "Euro")
				("FJD" . "Fijian Dollar")
				("FKP" . "Falkland Islands Pound")
				("GBP" . "British Pound Sterling")
				("GEL" . "Georgian Lari")
				("GGP" . "Guernsey Pound")
				("GHS" . "Ghanaian Cedi")
				("GIP" . "Gibraltar Pound")
				("GMD" . "Gambian Dalasi")
				("GNF" . "Guinean Franc")
				("GTQ" . "Guatemalan Quetzal")
				("GYD" . "Guyanaese Dollar")
				("HKD" . "Hong Kong Dollar")
				("HNL" . "Honduran Lempira")
				("HRK" . "Croatian Kuna")
				("HTG" . "Haitian Gourde")
				("HUF" . "Hungarian Forint")
				("IDR" . "Indonesian Rupiah")
				("ILS" . "Israeli New Sheqel")
				("IMP" . "Manx pound")
				("INR" . "Indian Rupee")
				("IQD" . "Iraqi Dinar")
				("IRR" . "Iranian Rial")
				("ISK" . "Icelandic Króna")
				("JEP" . "Jersey Pound")
				("JMD" . "Jamaican Dollar")
				("JOD" . "Jordanian Dinar")
				("JPY" . "Japanese Yen")
				("KES" . "Kenyan Shilling")
				("KGS" . "Kyrgystani Som")
				("KHR" . "Cambodian Riel")
				("KMF" . "Comorian Franc")
				("KPW" . "North Korean Won")
				("KRW" . "South Korean Won")
				("KWD" . "Kuwaiti Dinar")
				("KYD" . "Cayman Islands Dollar")
				("KZT" . "Kazakhstani Tenge")
				("LAK" . "Laotian Kip")
				("LBP" . "Lebanese Pound")
				("LKR" . "Sri Lankan Rupee")
				("LRD" . "Liberian Dollar")
				("LSL" . "Lesotho Loti")
				("LYD" . "Libyan Dinar")
				("MAD" . "Moroccan Dirham")
				("MDL" . "Moldovan Leu")
				("MGA" . "Malagasy Ariary")
				("MKD" . "Macedonian Denar")
				("MMK" . "Myanma Kyat")
				("MNT" . "Mongolian Tugrik")
				("MOP" . "Macanese Pataca")
				("MRO" . "Mauritanian Ouguiya (pre-2018)")
				("MRU" . "Mauritanian Ouguiya")
				("MTL" . "Maltese Lira")
				("MUR" . "Mauritian Rupee")
				("MVR" . "Maldivian Rufiyaa")
				("MWK" . "Malawian Kwacha")
				("MXN" . "Mexican Peso")
				("MYR" . "Malaysian Ringgit")
				("MZN" . "Mozambican Metical")
				("NAD" . "Namibian Dollar")
				("NGN" . "Nigerian Naira")
				("NIO" . "Nicaraguan Córdoba")
				("NOK" . "Norwegian Krone")
				("NPR" . "Nepalese Rupee")
				("NZD" . "New Zealand Dollar")
				("OMR" . "Omani Rial")
				("PAB" . "Panamanian Balboa")
				("PEN" . "Peruvian Nuevo Sol")
				("PGK" . "Papua New Guinean Kina")
				("PHP" . "Philippine Peso")
				("PKR" . "Pakistani Rupee")
				("PLN" . "Polish Zloty")
				("PYG" . "Paraguayan Guarani")
				("QAR" . "Qatari Rial")
				("RON" . "Romanian Leu")
				("RSD" . "Serbian Dinar")
				("RUB" . "Russian Ruble")
				("RWF" . "Rwandan Franc")
				("SAR" . "Saudi Riyal")
				("SBD" . "Solomon Islands Dollar")
				("SCR" . "Seychellois Rupee")
				("SDG" . "Sudanese Pound")
				("SEK" . "Swedish Krona")
				("SGD" . "Singapore Dollar")
				("SHP" . "Saint Helena Pound")
				("SLL" . "Sierra Leonean Leone")
				("SOS" . "Somali Shilling")
				("SRD" . "Surinamese Dollar")
				("SSP" . "South Sudanese Pound")
				("STD" . "São Tomé and Príncipe Dobra (pre-2018)")
				("STN" . "São Tomé and Príncipe Dobra")
				("SVC" . "Salvadoran Colón")
				("SYP" . "Syrian Pound")
				("SZL" . "Swazi Lilangeni")
				("THB" . "Thai Baht")
				("TJS" . "Tajikistani Somoni")
				("TMT" . "Turkmenistani Manat")
				("TND" . "Tunisian Dinar")
				("TOP" . "Tongan Paʻanga")
				("TRY" . "Turkish Lira")
				("TTD" . "Trinidad and Tobago Dollar")
				("TWD" . "New Taiwan Dollar")
				("TZS" . "Tanzanian Shilling")
				("UAH" . "Ukrainian Hryvnia")
				("UGX" . "Ugandan Shilling")
				("USD" . "United States Dollar")
				("UYU" . "Uruguayan Peso")
				("UZS" . "Uzbekistan Som")
				("VEF" . "Venezuelan Bolívar Fuerte")
				("VND" . "Vietnamese Dong")
				("VUV" . "Vanuatu Vatu")
				("WST" . "Samoan Tala")
				("XAF" . "CFA Franc BEAC")
				("XAG" . "Silver (troy ounce)")
				("XAU" . "Gold (troy ounce)")
				("XCD" . "East Caribbean Dollar")
				("XDR" . "Special Drawing Rights")
				("XOF" . "CFA Franc BCEAO")
				("XPD" . "Palladium Ounce")
				("XPF" . "CFP Franc")
				("XPT" . "Platinum Ounce")
				("YER" . "Yemeni Rial")
				("ZAR" . "South African Rand")
				("ZMW" . "Zambian Kwacha")))

(defun exchange-get-historical (date)
  "The date should be YYYY-MM-DD."
  (let ((url "")
	(exchange ""))
    (setq url (concatenate 'string
			   "https://openexchangerates.org/api/historical/"
			   date
			   ".json?app_id="
			   *exchange-api-id*))
    (setq exchange (drakma:http-request url :decode-content t))
    (setq exchange (map 'string #'code-char exchange)) ;; convert to string
    (setq exchange (yason:parse exchange :object-as :alist))))

(defun exchange-get ()
 (let ((exchange ""))
   (setq exchange (drakma:http-request
                   (concatenate 'string "https://openexchangerates.org/api/latest.json?app_id="
                                *exchange-api-id*)
                   :decode-content t))
   (setq exchange (map 'string #'code-char exchange)) ;; convert to string
   (setq exchange (yason:parse exchange :object-as :alist))))

(defun exchange (moneta)
  (cdr (assoc moneta (cdr (car exchange)) :test 'equal)))

(defun convert (amount from &optional (to :USD))
  "I take a certain AMOUNT in some FROM currency and convert it to the TO currency.
If no TO currency is given, I assume it to be \"USD\"."
  ;; universal-time is defined as the amount of seconds since 1900-01-01.
  ;; but posix-time starts from 1970. We test the timestamp so that, if it’s
  ;; more than an hour old, (* 60 60) secounds, the exchange is updated.
  (let ((exchange-time (cdr (assoc "timestamp" (cdr exchange) :test 'equal)))
	(current-time (- (get-universal-time) +posix-epoch+)))
    (unless exchange-time
      (setq exchange-time 1))
    (if (< (+ exchange-time 3600) current-time)
	(setq exchange (exchange-get))))
  (if (equal from :USD)
      (* amount (exchange to)) ;; USD → to
      (* (/ amount (exchange from)) (exchange to)))) ;; from → USD → to

(defparameter exchange (exchange-get))

