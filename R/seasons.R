#' Title
#'
#' @param comp
#' @param comp_id
#'
#' @return
#' @export
#'
#' @examples
fetch_seasons <- function(comp = NULL, comp_id = NULL) {

  if(is.null(comp) & is.null(comp_id)) {
    rlang::abort("One of `comp` or `comp_id` must be supplied")
  }

  if(is.null(comp_id)) {
    comp_id <- fetch_comp_id(comp)
  }

  resources <- c("afl", "v2", "competitions", comp_id, "compseasons")

  seas_resp <- resources |>
    afl_api()

  dplyr::bind_rows(seas_resp$compSeasons)

}

#' Title
#'
#' @param seasons
#' @param comp
#' @param comp_id
#'
#' @return
#' @export
#'
#' @examples
find_season_ids <- function(seasons, comp = NULL, comp_id = NULL) {

  if(is.null(comp) & is.null(comp_id)) {
    rlang::abort("One of `comp` or `comp_id` must be supplied")
  }

  if(is.null(comp_id)) {
    comp_id <- fetch_comp_id(comp)
  }

  seas_df <- fetch_seasons(comp_id = comp_id)

  seas_df <- seas_df %>%
    dplyr::filter(!stringr::str_detect(.data$name, "Legacy")) %>%
    dplyr::mutate(season = as.numeric(gsub("^.*([0-9]{4}).*", "\\1", .data$name)))

  ids <- seas_df$id[seas_df$season %in% seasons]

  ids <- ids[!is.na(ids)]

  if (length(ids) < 1) {
    rlang::warn(glue::glue("Could not find a matching ID to the {comp} for {season}"))
    return(NULL)
  }

  return(ids)

}
