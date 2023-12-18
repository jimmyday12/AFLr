# https://aflapi.afl.com.au/afl/v2/compseasons/52/ladders

fetch_ladder <- function(compSeason_id, round_id) {

  resources <- c("afl", "v2", "compseasons", compSeason_id, "ladders")
  query = list(roundId = round_id)

  resp <- afl_api(resources,
                  query = query,
                  response = "string")

  jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("ladders", "entries", 1) |>
    tibble::as_tibble()

}
