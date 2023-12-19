# https://aflapi.afl.com.au/afl/v2/matches?pageSize=300&competitionId=1&compSeasonId=52&roundNumber=20

fetch_matches <- function(
    comp_id = NULL,
    compSeason_id = NULL,
    round_number = NULL,
    verbose = FALSE) {

  resources <- c("afl", "v2", "matches")

  query <- list(
    competitionId = comp_id,
    compSeasonId = compSeason_id,
    roundNumber = round_number,
    pageSize = 1000
  )

  resps <- afl_api(resources,
                   query = query,
                   verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "matches")
}
