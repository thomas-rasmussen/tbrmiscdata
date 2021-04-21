# install.packages("data.table")
# install.packages("here")

library(data.table)

# Download data. We simply read each line into a single variable, then
# parse the data by position manually.
data_url <- paste0(
  "https://sor-filer.sundhedsdata.dk/sor_produktion/data/shak",
  "/shakcomplete/shakcomplete.txt"
)
dat_raw <- fread(
  input = data_url,
  header = FALSE,
  sep = NULL,
  showProgress = FALSE
)

# Create/update file with information on when data was downloaded.
note <- paste0(
  "shak_complete.txt downloaded ",
  as.character(Sys.time()),
  " from\n",
  "https://sor-filer.sundhedsdata.dk/sor_produktion/data/sha/shakcomplete/shakcomplete.txt"
)
writeLines(note, here::here("data-raw", "shakcomplete_download_info.txt"))

# Parse data
dat <- dat_raw[, `:=`(
    record_type = substr(V1, 1, 3),
    shak_code = trimws(substr(V1, 4, 23)),
    valid_from = as.Date(substr(V1, 24, 31), format = "%Y%m%d"),
    date_change = as.Date(substr(V1,32, 39), format = "%Y%m%d"),
    valid_to = as.Date(substr(V1, 40, 47), format = "%Y%m%d"),
    text = trimws(substr(V1, 48, 167)),
    group_a = substr(V1, 168, 170),
    group_b = substr(V1, 171, 173),
    group_c = substr(V1, 174, 176),
    group_d = substr(V1, 177, 179),
    group_e = substr(V1, 180, 182),
    value_a = substr(V1, 183, 183),
    value_b = substr(V1, 184, 185),
    value_c = substr(V1, 186, 187),
    value_d = substr(V1, 188, 188),
    inclusion = substr(V1, 189, 213),
    extra_reg = substr(V1, 214, 214)
  )][
    # Restrict to data lines with hospital codes
    record_type == "sgh"
  ][
    # Restrict to relevant variables
    , .(hospital_code = shak_code, hospital_name = text, valid_from, valid_to)
  ]

# "Smooth data", ie if a hospital code has multiple data lines with time-periods
# that are in continuation of each other, combine them into a single line.
dat[, `:=`(
    new_start = (
      is.na(shift(valid_to)) | hospital_code != shift(hospital_code) |
      hospital_name != shift(hospital_name) | valid_from > (shift(valid_to) + 1)
    )
  )][,
     new_end := shift(new_start, n = -1L, fill = TRUE)
  ]
dat <- with(dat,
            data.table(
              hospital_code = hospital_code[new_start],
              hospital_name = hospital_name[new_start],
              valid_from = valid_from[new_start],
              valid_to = valid_to[new_end]
            )
  )

# There are still some cases where there are small gaps between periods,
# and/or slight name changes where it would make sense to smooth the data
# even more, but this would have to be done manually.

# Manually add region codes based on
# "Sygehusafdelingsklassifikation 2018-1.pdf" and
# "Retningslinjer Afdelingsklassifikation.pdf" from
# https://sundhedsdatastyrelsen.dk/da/rammer-og-retningslinjer/om-klassifikationer/afdelingsklassifikation
# and looking at what codes are present in the data. When allocating private
# hospitals etc not covered by the online documentation, we are working from the
# assumption that, generally, numerical codes that are close to each other
# belong to the same region.
dat[, num_code := as.numeric(hospital_code)
  ][
    , region_code := fcase(
      # Nordjylland
      (8000 <= num_code & num_code <= 8900) | num_code == 7603, "081",
      # Midtjylland
      (6500 <= num_code & num_code <= 7700) & num_code != 7603, "082",
      # Syddanmark
      (4200 <= num_code & num_code <= 6100), "083",
      # Hovedstaden (incl. Bornholm)
      (1300 <= num_code & num_code <= 2300) | 4000 <= num_code & num_code <= 4100, "084",
      # Sjælland
      (2500 <= num_code & num_code <= 4000) | num_code == 3800, "085",
      # Grønland
      9000 <= num_code & num_code <= 9100, "090",
      # Færørerne. Note: coded as 097 but there might be other standards
      9700 <= num_code & num_code <= 9800, "097",
      # Foreign hospital. Note: coded as 999 but there might be other standards
      num_code == 9990 | num_code == 9999, "999",
      # Any code that is not explicitly handled is set to an empty string.
      default = ""
    )
  ][
    # Add labels
    , region_name := fcase(
      region_code == "081", "Nordjylland",
      region_code == "082", "Midtjylland",
      region_code == "083", "Syddanmark",
      region_code == "084", "Sjælland",
      region_code == "085", "Hovedstaden",
      region_code == "090", "Grønland",
      region_code == "097", "Færørerne",
      region_code == "999", "Udland",
      region_code == "", "Ukendt"
    )
  ][ , num_code := NULL]

# Convert to UTF-8 encoding
Encoding(dat$hospital_name) <- "latin1"
Encoding(dat$region_name) <- "latin1"
dat$hospital_name <- enc2utf8(dat$hospital_name)
dat$region_name <- enc2utf8(dat$region_name)

dk_hospital_region <- dat
usethis::use_data(dk_hospital_region, overwrite = TRUE)
