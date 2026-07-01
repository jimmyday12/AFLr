
#https://api.afl.com.au/cfs/afl/matchRoster/full/CD_M20230142801

fetch_matchRosters <- function(
    match_providerId,
    ...,
    minimal = TRUE,
    cookie = NULL,
    verbose = FALSE) {

  if(is.null(cookie)) cookie <- fetch_cookie()

  resources <- c("cfs", "afl", "matchRoster", "full", match_providerId)

  query <- list()

  resps <- afl_api(resources,
                   base_url = "https://api.afl.com.au/",
                   headers = list("X-Media-Mis-Token" = cookie),
                   query = query,
                   verbose = verbose)

  #resps |>
  #  afl_api_resp_data(pluck_names = "teamPlayers")

}
