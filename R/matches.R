# https://aflapi.afl.com.au/afl/v2/matches?pageSize=300&competitionId=1&compSeasonId=52&roundNumber=20

fetch_matches <- function(comp_id, compSeason_id, round_number) {

  resources <- c("afl", "v2", "matches")

  query <- list(
    competitionId = comp_id,
    compSeasonId = compSeason_id,
    roundNumber = round_number
  )


  resp <- afl_api(resources, query = query, response = "string")

 jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("matches") |>
    tibble::as_tibble()

}


