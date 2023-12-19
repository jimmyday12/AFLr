#' Title
#'
#' @param resource
#' @param headers
#' @param query
#' @param base_url
#' @param method
#'
#' @return
#' @export
#'
#' @examples
afl_api <- function(
    resource,
    ...,
    headers = list(),
    query = list(),
    method = NULL,
    base_url = NULL,
    verbose = FALSE) {

  if(is.null(base_url)) {
    url <- "https://aflapi.afl.com.au"
  } else {
    url <- base_url
  }

  # General Request
  req <- httr2::request(url) |>
    httr2::req_url_path_append(resource) |>
    httr2::req_headers(!!!headers) |>
    httr2::req_url_query(!!!query) |>
    httr2::req_user_agent("AFLr (http://my.package.web.site)")

  # Custom Method
  if(!is.null(method)) {
    req <- req |>
      httr2::req_method(method)
  }

  if(verbose) print(req)

  # Perform iterative requests

  # Create helper function for performing request
  num_pages <- function(resp) {
    resp_json <- resp_body_json(resp)
    resp_json$meta$pagination$numPages
  }

  is_complete <- function(resp) {
    resp_json <- resp_body_json(resp)
    is.null(resp_json$meta$pagination$numPages)
  }

  # Perform requests
  resp <- httr2::req_perform_iterative(
    req,
    next_req = httr2::iterate_with_offset(
      "page",
      resp_pages = num_pages,
      resp_complete = is_complete),
    max_reqs = Inf)

}

afl_api_resp_data <- function(resps, pluck_names = NULL) {

  if(is.null(pluck_names)) {
    x <- httr2::resp_body_json(resps[[1]])
    pluck_names <- names(x)[2]
  }

  # Iterate over data and return tibble
  resps |>
    httr2::resps_successes() |>
    httr2::resps_data(function(resp, pluck_list = pluck_names) {
      httr2::resp_body_string(resp) |>
        jsonlite::fromJSON(flatten = TRUE) |>
        purrr::pluck(!!!pluck_list) |>
        purrr::list_modify(byes = rlang::zap()) |>
        tibble::as_tibble()
  })

}

