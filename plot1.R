YWSID <- "..."
CONSUMER_KEY <- "..."
CONSUMER_SECRET <- "..."
TOKEN <- "..."
TOKEN_SECRET <- "..."

signature <- as.character(curlPercentEncode(base64(hmac(key=paste(cons_sec, tok_sec, sep="&"), object=api_url, algo="sha1", serialize=FALSE, raw=TRUE))))

yelp_bus <- function(rest, ywsid, cons_key, cons_sec, tok, tok_sec) {
  require(package = "digest")
  require(package = "rjson")
  require(package = "RCurl")
  require(package = "stringr")
  rest1 <- gsub(pattern = " ", replacement = "%2520", x = rest)
  rest2 <- gsub(pattern = " ", replacement = "+", x = rest)
  nonce <- paste(sample(x = c(0:9, letters, LETTERS, "_"), size = 32, replace = TRUE), collapse = "")
  tm <- format(x = Sys.time(), "%s")
  api_url <- paste("GET\u0026http%3A%2F%2Fapi.yelp.com%2Fv2%2Fsearch\u0026",
                   "limit%3D1%26location%3DChicago%2520IL%26",
                   "oauth_consumer_key%3D", cons_key, "%26",
                   "oauth_nonce%3D", nonce, "%26",
                   "oauth_signature_method%3DHMAC-SHA1%26",
                   "oauth_timestamp%3D", tm, "%26",
                   "oauth_token%3D", tok, "%26",
                   "term%3D", rest1,
                   sep = "")
  signature <- hmac(key = tok_sec, object = api_url, algo = "sha1")
  api_url <- paste("http://api.yelp.com/v2/search?",
                   "limit=1&location=Chicago+IL&",
                   "oauth_consumer_key=", cons_key, "&",
                   "oauth_nonce=", nonce, "&",
                   "oauth_signature=", signature, "&",
                   "oauth_signature_method=HMAC-SHA1&",
                   "oauth_timestamp=", tm, "&",
                   "oauth_token=", tok, "&",
                   "term=", rest2,
                   sep = "" )
  return(api_url)
}

yelp_bus(rest = "chez moi",
         ywsid = YWSID,
         cons_key = CONSUMER_KEY,
         cons_sec = CONSUMER_SECRET,
         tok = TOKEN,
         tok_sec = TOKEN_SECRET)