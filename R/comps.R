#' Title
#'
#' @return
#' @export
#'
#' @examples
fetch_comps <- function() {

  resources <- c("afl", "v2", "competitions")
  query <- list(pageSize = 50)

  resp <- afl_api(resources,
                  query = query,
                  response = "string")

  jsonlite::fromJSON(resp, flatten = TRUE) |>
    purrr::pluck("competitions") |>
    tibble::as_tibble()

}

