# https://api.afl.com.au/cfs/afl/players?pageSize=20&pageNum=1&sortBy=name&seasonId=CD_S2023014&teamIds=&playerPosition=

fetch_players <- function(
    season_provider_id = NULL,
    cookie = NULL,
    verbose = verbose) {

  if(is.null(cookie)) cookie <- fetch_cookie()
  resources <- c("cfs", "afl", "players")

  query <- list(
    seasonId = season_provider_id,
    pageSize = 1000)


  resps <- afl_api(resources,
                  query = query,
                  headers = list("X-Media-Mis-Token" = cookie),
                  base_url = "https://api.afl.com.au/")


  resps |>
    afl_api_resp_data(pluck_names = "players")

}
