#' Title
#'
#' @return
#' @export
#'
#' @examples
fetch_comps <- function() {

  resources <- c("afl", "v2", "competitions")

  query <- list(
    pageSize = 100)

  resps <- afl_api(resources)

  resps |>
    afl_api_resp_data(pluck_names = "competitions")

}


