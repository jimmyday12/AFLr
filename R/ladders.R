# https://aflapi.afl.com.au/afl/v2/compseasons/52/ladders

fetch_ladder <- function(compSeason_id,
                         round_id = NULL,
                         verbose = FALSE) {

  resources <- c("afl", "v2", "compseasons", compSeason_id, "ladders")
  query = list(roundId = round_id,
               pageSize = 1000)

  resps <- afl_api(resources,
                  query = query,
                  verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = list("ladders", "entries", 1))


}
