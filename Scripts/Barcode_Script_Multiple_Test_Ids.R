library(dplyr)

# Define input and output file paths
input_file <- "C:/User/quasid.akhter/Desktop/Barcode/Input_files/NISCPR_Day1_2_3_Id_Raw.csv"
output_file <- "C:/Users/quasid.akhter/Desktop/Barcode/Output_files/NISCPR_Day1_2_3_Id_multiple.csv"

# Read the input CSV file
df <- read.csv(input_file)

# Function to generate the sequence of IDs
generate_ids <- function(lab_id, test_id) {
  c(
    lab_id,
    paste0(test_id, "A"), 
    paste0(test_id, "A"), 
    paste0(test_id, "A"), 
    paste0(lab_id),
    paste0(test_id, "A"), 
    paste0(test_id, "A"), 
    paste0(test_id, "A"), 
    paste0(test_id, "A"), 
    paste0(test_id, "B"), 
    paste0(test_id, "C"),
    paste0(test_id, "D"), 
    paste0(test_id, "E"),
    paste0(test_id, "F"), 
    paste0(test_id, "G"), 
    paste0(test_id, "H"), 
    paste0(test_id, "I"), 
    paste0(test_id, "J"), 
    paste0(test_id, "K"), 
    paste0(test_id, "L"), 
    paste0(test_id, "M"), 
    paste0(test_id, "N"), 
    paste0(lab_id),
    paste0(test_id, "A"),
    paste0(test_id, "A"), 
    paste0(test_id, "B"), 
    paste0(test_id, "C"), 
    paste0(test_id, "D"), 
    paste0(test_id, "E"), 
    paste0(test_id, "F"), 
    paste0(test_id, "G"), 
    paste0(test_id, "H"), 
    paste0(test_id, "I"), 
    paste0(test_id, "J"), 
    paste0(test_id, "K"), 
    paste0(test_id, "L"), 
    paste0(test_id, "M"), 
    paste0(test_id, "N"), 
    paste0(lab_id),
    paste0(test_id, "A")
  )
}

# Initialize an empty data frame for storing results
new_df <- data.frame()

# Loop through each row of the input data frame
for (i in 1:nrow(df)) {
  lab_id <- df$Lab_ID[i]
  test_id <- df$Test_ids[i]
  
  # Generate the additional rows
  additional_rows <- data.frame(
    Lab_ID = lab_id,
    IDs = generate_ids(lab_id, test_id)
  )
  
  # Append the new rows to new_df
  new_df <- rbind(new_df, additional_rows)
}

# Remove the Lab_ID column if not needed in the final output
new_df$Lab_ID <- NULL

# Write the new data frame to the output CSV file
write.csv(new_df, output_file, row.names = FALSE)

# Print confirmation message
##cat("Multiplex CSV file saved as:", output_file, "\n")
