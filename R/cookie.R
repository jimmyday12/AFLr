
fetch_cookie <- function() {

  cookie_resp <- afl_api(resource = "cfs/afl/WMCTok",
                         headers = list(`Content-Length` = 0),
                         base_url = "https://api.afl.com.au/",
                         method = "POST")

  cookie_resp$token

}
