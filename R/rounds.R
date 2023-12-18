#' Title
#'
#' @param season
#' @param comp
#' @param season_id
#' @param comp_id
#'
#' @return
#' @export
#'
#' @examples
fetch_rounds<- function(season = NULL,
                            comp = NULL,
                            season_id = NULL,
                            comp_id = NULL) {

  if(is.null(season) & is.null(season_id)) {
    cli::cli_abort("One of `season` or `season_id` must be supplied")
  }

  if(is.null(comp) & is.null(comp_id)) {
    cli::cli_abort("One of `comp` or `comp_id` must be supplied")
  }

  if(is.null(comp_id)) {
    comp_id <- find_comp_id(comp)
  }

  if(is.null(season_id)) {
    season_id <- find_season_ids(season, comp_id = comp_id)

    if(length(season_id) > 1){
      cli::cli_warn("`fetch_rounds` does not return data for multiple seasons. Returning data for only season ID {max(season_id)}")
      season_id <- max(season_id)
    }
  }


  resources <- c("afl", "v2", "compseasons", season_id, "rounds")

  resources |>
    afl_api(query = list(pageSize = 50)) |>
    purrr::pluck("rounds") |>
    purrr::map(~purrr::list_modify(., byes = rlang::zap())) |>
    purrr::map_dfr(dplyr::as_tibble)

}

#' Title
#'
#' @param round
#' @param season
#' @param comp
#' @param season_id
#' @param comp_id
#'
#' @return
#' @export
#'
#' @examples
find_round_ids <- function(rounds,
                           season = NULL,
                           comp = NULL,
                           season_id = NULL,
                           comp_id = NULL) {

  if(is.null(season) & is.null(season_id)) {
    cli::cli_abort("One of `season` or `season_id` must be supplied")
  }

  if(is.null(comp) & is.null(comp_id)) {
    cli::cli_abort("One of `comp` or `comp_id` must be supplied")
  }

  if(is.null(comp_id)) {
    comp_id <- fetch_comp_id_afl(comp)
  }

  if(is.null(season_id)) {
    season_id <- fetch_season_id(season, comp_id = comp_id)
  }

  round_ids <- fetch_round_ids(season_id = season_id,
                               comp_id = comp_id)


}
