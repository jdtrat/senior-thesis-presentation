library(googledrive)
library(googlesheets4)

options(gargle_oauth_email = TRUE,
        gargle_oauth_cache = ".secrets")


# Create once on set up
# gs4_create(name = "thesis-presentation-demo")

# Get ID of the sheet
pres_sheet_id <- drive_get("thesis-presentation-demo")$id
