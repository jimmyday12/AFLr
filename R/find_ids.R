#' Title
#'
#' @param comp
#' @param ...
#' @param .id_type
#' @param .index
#'
#' @return
#' @export
#'
#' @examples
find_comps_id <- function(comp, ...,
                          .id_type = "id", .index = 1) {

  rlang::arg_match(
    .id_type,
    c("id", "providerId"))

  comps <- fetch_comps()

  rlang::arg_match(
    comp,
    unique(comps$code))

  comps |>
    dplyr::filter(code == comp) |>
    dplyr::slice(.index) |>
    dplyr::pull(!!.id_type)

}



find_compSeason_id <- function(comp, season, ...,
                          .id_type = "id", .index = 1,
                          .comp_id_type = "id", .comp_index = 1) {

  rlang::arg_match(
    .id_type,
    c("id", "providerId"))

  comp_id <- find_comps_id(comp,
                           .id_type = .comp_id_type,
                           .index = .comp_index)

  compSeasons <- fetch_compSeasons(comp_id)

  compSeasons <- compSeasons |>
    dplyr::filter(!stringr::str_detect(.data$name, "Legacy")) |>
    dplyr::mutate(season = as.numeric(gsub("^.*([0-9]{4}).*", "\\1", .data$name)))

  min_seas <- min(compSeasons$season)
  max_seas <- max(compSeasons$season)

  if(!dplyr::between(season, min_seas, max_seas)) {
    cli::cli_abort(c(
      "{.var season} not found for {.var comp} = \"{comp}\"",
      "i" = "Available seasons are from {min_seas}-{max_seas}",
      "x" = "You've supplied round {season}"
    ))

  }

  compSeasons |>
    dplyr::filter(season == season) |>
    dplyr::slice(.index) |>
    dplyr::pull(!!.id_type)

}



find_round_id <- function(comp,
                          season,
                          round,
                          ...,
                          .id_type = "id",
                          .index = 1,
                          .comp_id_type = "id",
                          .comp_index = 1,
                          .season_id_type = "id",
                          .season_index = 1) {

  rlang::arg_match(
    .id_type,
    c("id", "providerId"))

  compSeason_id <- find_compSeason_id(comp,
                                      season,
                                      .id_type = .season_id_type,
                                      .index = .season_index,
                                      .comp_id_type = .comp_id_type,
                                      .comp_index = .comp_index)


  rounds <- fetch_rounds(compSeason_id)

  min_round <- min(rounds$roundNumber)
  max_round <- max(rounds$roundNumber)

  if(!dplyr::between(round, min_round, max_round)) {
    cli::cli_abort(c(
      "{.var round} not found for {.var season} = {season}",
      "i" = "Available rounds for the {season} season are {min_round}-{max_round}",
      "x" = "You've supplied round {round}"
    ))

  }


  rounds |>
    dplyr::filter(roundNumber == round) |>
    dplyr::slice(.index) |>
    dplyr::pull(!!.id_type)

}
