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
afl_api <- function(resource, headers = list(), query = list(),
                    base_url = NULL, method = NULL, verbose = FALSE) {

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
    httr2::req_user_agent("AFLr (http://my.package.web.site)") |>
    httr2::req_progress()

  # Custom Method
  if(!is.null(method)) {
    req <- req |>
      httr2::req_method(method)
  }

  if(verbose) print(req)

  # Perform Request
  req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
