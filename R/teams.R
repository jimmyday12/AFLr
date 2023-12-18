# https://aflapi.afl.com.au/afl/v2/teams?compSeasonId=52&pageSize=100

fetch_teams <- function(compSeason_id) {

  resources <- c("afl", "v2", "teams")

  query <- list(
    compSeasonId = compSeason_id,
    pageSize = 100)


  resp <- afl_api(resources, query = query, response = "string")

  jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("teams") |>
    tibble::as_tibble()

}
