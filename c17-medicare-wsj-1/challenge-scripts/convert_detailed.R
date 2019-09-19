# Convert Medicare detailed data from tab delimited to RDS

# Author: Daniel
# Version: 

# Libraries
library(tidyverse)

# Parameters
  # File with raw detailed data
file_detailed_tsv <- "~/Google Drive/classes/dcl/c16/Medicare_Provider_Util_Payment_PUF_CY2012.txt"
  # File with detailed data in RDS format
file_detailed_rds <- "~/Google Drive/classes/dcl/c16/c16_medicare_1.rds"

#===============================================================================

# Convert Medicare detailed data from tab delimited to RDS

file_detailed_tsv %>%
  read_tsv() %>%
  write_rds(file_detailed_rds)