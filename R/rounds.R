
fetch_rounds<- function(compSeason_id, verbose = FALSE) {

  resources <- c("afl", "v2", "compseasons", compSeason_id, "rounds")

  query <- list(
    pageSize = 50)

  resps <- afl_api(resources,
                   query = query,
                   verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "rounds")


}

