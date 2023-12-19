# https://aflapi.afl.com.au/afl/v2/teams?compSeasonId=52&pageSize=100

fetch_teams <- function(compSeason_id = NULL,
                        verbose = FALSE) {

  resources <- c("afl", "v2", "teams")

  query <- list(
    compSeasonId = compSeason_id,
    pageSize = 50)


  resp <- afl_api(resources,
                  query = query,
                  verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "teams")

}
