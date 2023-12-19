#' Title
#'
#' @param comp_id
#'
#' @return
#' @export
#'
#' @examples
fetch_compSeasons <- function(comp_id, verbose = FALSE) {


  resources <- c("afl", "v2", "competitions", comp_id, "compseasons")

  query <- list(
    pageSize = 100)

  resps <- afl_api(resources,
                   query = query,
                   verbose = verbose)

  resps |>
    afl_api_resp_data(pluck_names = "compSeasons")

}
