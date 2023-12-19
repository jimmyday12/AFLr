

fetch_venues <- function(compSeason_id = NULL,
                         verbose = FALSE) {

  resources <- c("afl", "v2", "venues")

  query <- list(
    compSeasonId = compSeason_id,
    pageSize = 100)


  resps <- afl_api(resources,
                  query = query,
                  verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "venues")

}

