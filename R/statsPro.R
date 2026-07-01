# https://api.afl.com.au/statspro/leadingPlayerStats/season/CD_S2023014?limit=5

# https://api.afl.com.au/statspro/leadingPlayerMatchTotals/round/CD_R202301428

# https://api.afl.com.au/statspro/playersStats/seasons/CD_S2023014?includeBenchmarks=false

# https://api.afl.com.au/statspro/playerHeadToHead/featured?seasonId=CD_S2023014


fetch_statspro_playerStats_season <- function(
    compSeason_providerId,
    ...,
    includeBenchmarks = FALSE,
    cookie = NULL,
    verbose = FALSE) {

  if(is.null(cookie)) cookie <- fetch_cookie()

  resources <- c("statspro", "playersStats", "seasons", compSeason_providerId)

  query <- list(includeBenchmarks = includeBenchmarks)

  resps <- afl_api(resources,
                  base_url = "https://api.afl.com.au/",
                  headers = list("X-Media-Mis-Token" = cookie),
                  query = query,
                  verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "players")

}


fetch_statspro_playerStats_round <- function(
    compSeason_providerId,
    ...,
    includeBenchmarks = FALSE,
    cookie = NULL,
    verbose = FALSE) {

  if(is.null(cookie)) cookie <- fetch_cookie()

  resources <- c("statspro", "playersStats", "rounds", compSeason_providerId)

  query <- list(includeBenchmarks = includeBenchmarks)

  resps <- afl_api(resources,
                   base_url = "https://api.afl.com.au/",
                   headers = list("X-Media-Mis-Token" = cookie),
                   query = query,
                   verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "players")

}

fetch_statspro_playerStats_match <- function(
    compSeason_providerId,
    ...,
    includeBenchmarks = FALSE,
    cookie = NULL,
    verbose = FALSE) {

  if(is.null(cookie)) cookie <- fetch_cookie()

  resources <- c("statspro", "playersStats", "rounds", compSeason_providerId)

  query <- list(includeBenchmarks = includeBenchmarks)

  resps <- afl_api(resources,
                   base_url = "https://api.afl.com.au/",
                   headers = list("X-Media-Mis-Token" = cookie),
                   query = query,
                   verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "players")

}
