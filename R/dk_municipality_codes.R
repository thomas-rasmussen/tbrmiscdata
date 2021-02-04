#' Danish Municipality Codes
#'
#' List of municipality codes, including historic municipality codes, codes used
#' in Greenland, and miscellaneous proxy codes for unknown/missing municipality
#' information. The data also contains the corresponding updated municipality
#' code (post 2007 municipality reform), and the corresponding region in which
#' the municipality is located.
#'
#' In Danish registry data, a mixture of old and new municipality codes is
#' used, depending on what time period the data is from. This list facilitates
#' translation of old municipality codes to the post 2007 municipality reform
#'  codes, and can also be used to find the corresponding region to which the
#' municipalities belong.
#'
#' @source
#' Original data: <medcom.dk/media/1208/gl_nye_kommuner_regioner.xls>
#'
#' An enhanced version of the original data, developed at the Department of
#' Clinical Epidemiology, Aarhus University Hospital was imported instead
#' of the original data.
#'
#' Full list of codes appearing in Danish registry data:
#'
#' <http://www.dst.dk/extranet/staticsites/times3/html/0e3da20e-99e5-439d-b50d-1de712fa9e85.htm>
#'
#' @format Data frame with columns
#' \describe{
#' \item{municipality_code}{Municipality code}
#' \item{updated_municipality_code}{Updated municipality code}
#' \item{municipality_name}{Municipality name}
#' \item{updated_municipality_name}{Updated municipality name}
#' \item{region_code}{Region code}
#' \item{region_name}{Region name}
#' }
#' @examples
#'   dk_municipality_codes
"dk_municipality_codes"
