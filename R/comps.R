#' Title
#'
#' @return
#' @export
#'
#' @examples
fetch_comps <- function() {

  comp_resp <- afl_api("afl/v2/competitions",
                       query = list(pageSize = 50))

  dplyr::bind_rows(comp_resp$competitions)

}



#' Title
#'
#' @param comp
#'
#' @return
#' @export
#'
#' @examples
find_comp_id <- function(comp) {

  comp_df <- fetch_comps()

  if (comp == "AFLM") comp <- "AFL"

  comp_df <- comp_df |>
    tidyr::drop_na() |>
    dplyr::filter(!stringr::str_detect(.data$name, "Legacy"))


  ids <- comp_df$id[comp_df$code == comp]
  min(ids, na.rm = TRUE)

}
