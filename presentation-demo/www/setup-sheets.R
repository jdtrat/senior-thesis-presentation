options(gargle_oauth_email = TRUE,
        gargle_oauth_cache = ".secrets")


# Create once on set up
# gs4_create(name = "thesis-presentation-demo")

# Get ID of the sheet
pres_sheet_id <- drive_get("thesis-presentation-demo")$id

# Write initial data to the sheet
sheet_write(data.frame(favorite_food = "Sushi", name = "Jonathan"), ss = pres_sheet_id, sheet = "Sheet1")
