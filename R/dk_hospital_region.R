#' Danish Hospital Codes and Corresponding Region
#'
#' List of hospital codes in Denmark and the corresponding region to which the
#' hospital belongs. The list also includes historic codes, and codes for
#' private hospitals.
#'
#' The hospital SHAK codes are not unique, ie in some cases when new codes have
#' been introduced, instead of introducing a new unique SHAK code, an old
#' historic code not currently used, was reused instead. The data includes
#' dates with information on when the specific code/hospital pairing is valid.
#'
#' The source data is updated daily, and as such will be changed/augmented over
#' time. Information on when the source data for the current version of the
#' package was downloaded can be found in
#' "\\data-raw\\shakcomplete_download_info.txt" in the source code.
#'
#' Hospital codes were manually assigned based on information in
#' "Sygehusafdelingsklassifikation 2018-1.pdf" and
#' "Retningslinjer Afdelingsklassifikation.pdf" from
#' https://sundhedsdatastyrelsen.dk/da/rammer-og-retningslinjer/om-klassifikationer/afdelingsklassifikation
#' and by manual inspection of the downloaded source data.
#'
#' @source
#' https://sor-filer.sundhedsdata.dk/sor_produktion/data/shak"/shakcomplete/shakcomplete.txt"
#'
#' @format Data frame with columns
#' \describe{
#' \item{hospital_code}{Hospital SHAK code}
#' \item{hospital_name}{Hospital name}
#' \item{valid_from}{Start of period where code was used}
#' \item{valid_to}{End of period in which the code was used}
#' \item{region_code}{Region code}
#' \item{region_name}{Region name}
#' }
#' @examples
#'   dk_hospital_region
"dk_hospital_region"
