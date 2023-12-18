
fetch_rounds<- function(compSeason_id) {

  resources <- c("afl", "v2", "compseasons", compSeason_id, "rounds")

  resources |>
    afl_api(query = list(pageSize = 50)) |>
    purrr::pluck("rounds") |>
    purrr::map(~purrr::list_modify(., byes = rlang::zap())) |>
    purrr::map_dfr(dplyr::as_tibble)

}

