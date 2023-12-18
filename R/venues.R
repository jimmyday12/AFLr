# https://aflapi.afl.com.au/afl/v2/venues?compSeasonId=52&pageSize=100

fetch_venues <- function(compSeason_id) {

  resources <- c("afl", "v2", "venues")

  query <- list(
    compSeasonId = compSeason_id,
    pageSize = 100)


  resp <- afl_api(resources, query = query, response = "string")

  jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("venues") |>
    tibble::as_tibble()

}
