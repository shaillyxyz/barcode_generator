# Load necessary library
library(readr)
library(dplyr)

# Read the CSV file
file_path <- "IHBT_20%_Serum_Sec_Id_Raw.csv"
data <- read_csv(file_path)

# Function to generate rows based on the Serum_vol value
expand_rows <- function(row) {
  n <- as.numeric(row["Serum_vol"])
  test_id_base <- row["Test_id"]
  lab_id <- row["Lab_id"]
  test_id <- paste0(test_id_base, "J")
  
  if (n > 0) {
    if (n == 1) {
      sec_ids <- list(toupper(test_id))  # Convert to uppercase
    } else {
      letters_suffix <- c("", toupper(letters[1:(n-1)]))  # Convert to uppercase
      sec_ids <- paste0(test_id, letters_suffix)
    }
  } else {
    sec_ids <- list("")
  }
  
  # Combine Lab_id with Sec_id entries
  lab_sec_ids <- c(lab_id, unlist(sec_ids))
  
  return(lab_sec_ids)
}

# Round up the Serum_vol values
data$Serum_vol <- ceiling(as.numeric(data$Serum_vol))

# Apply the expand_rows function to each row using lapply
expanded_sec_ids <- unlist(lapply(1:nrow(data), function(i) expand_rows(data[i, ])))

# Create a data frame with only the Sec_id column
expanded_data <- data.frame(Sec_id = expanded_sec_ids)


# Remove empty Sec_id rows
final_data <- expanded_data %>% filter(Sec_id != "")

# Save the modified data back to a CSV file
write_csv(final_data, "C:/Users/quasid.akhter/Desktop/Barcode/Output_files/IHBT_20%_Serum_Sec_Ids.csv")

