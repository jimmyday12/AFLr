#' Title
#'
#' @param comp_id
#'
#' @return
#' @export
#'
#' @examples
fetch_compSeasons <- function(comp_id) {


  resources <- c("afl", "v2", "competitions", comp_id, "compseasons")

  query <- list(pageSize = 50)

  resp <- afl_api(resources,
                  response = "string")

  jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("compSeasons") |>
    tibble::as_tibble()



}
