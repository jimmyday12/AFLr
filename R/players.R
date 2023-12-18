# https://api.afl.com.au/cfs/afl/players?pageSize=20&pageNum=1&sortBy=name&seasonId=CD_S2023014&teamIds=&playerPosition=

fetch_player <- function(season_provider_id, cookie) {

  resources <- c("cfs", "afl", "players")

  query <- list(
    seasonId = season_provider_id,
    pageSize = 50)


  resp <- afl_api(resources,
                  query = query,
                  headers = list("X-Media-Mis-Token" = cookie),
                  base_url = "https://api.afl.com.au/",
                  response = "json")

  jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("venues") |>
    tibble::as_tibble()

}
