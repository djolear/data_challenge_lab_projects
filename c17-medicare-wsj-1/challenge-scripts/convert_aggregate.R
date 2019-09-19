# Convert Medicare aggregate data from Excel format to RDS. Rename and keep only
# the following columns of the DATA sheet as follows:
# NPI                              = "NPI"
# NPPES_PROVIDER_LAST_ORG_NAME     = "NPPES Provider Last Name / Organization Name"
# NPPES_PROVIDER_FIRST_NAME        = "NPPES Provider First Name"
# NPPES_PROVIDER_MI                = "NPPES Provider Middle Initial"
# NPPES_CREDENTIALS                = "NPPES Credentials"
# NPPES_PROVIDER_GENDER            = "NPPES Provider Gender"
# NPPES_ENTITY_CODE                = "NPPES Entity Code"
# NPPES_PROVIDER_STREET1           = "NPPES Provider Street Address 1"
# NPPES_PROVIDER_STREET2           = "NPPES Provider Street Address 2"
# NPPES_PROVIDER_CITY              = "NPPES Provider City"
# NPPES_PROVIDER_ZIP               = "NPPES Provider Zip Code"
# NPPES_PROVIDER_STATE             = "NPPES Provider State"
# NPPES_PROVIDER_COUNTRY           = "NPPES Provider Country"
# PROVIDER_TYPE                    = "Provider Type"
# MEDICARE_PARTICIPATION_INDICATOR = "Medicare Participation Indicator"
# TOTAL_HCPCS_CODE                 = "Number of HCPCS"
# TOTAL_LINE_SRVC_CNT              = "Number of Services"
# BENE_UNIQUE_CNT                  = "Number of Unique Beneficiaries"
# TOTAL_SUBMITTED_CHRG_AMT         = "Total Submitted Charges"
# TOTAL_MEDICARE_ALLOWED_AMT       = "Total Medicare Allowed Amount"
# TOTAL_MEDICARE_PAYMENT_AMT       = "Total Medicare Payment Amount"

# Author: Daniel
# Version: 

# Libraries
library(tidyverse)
library(readxl)

# Parameters
  # File with raw aggregate data
file_aggregate_xlxs <- "~/Google Drive/classes/dcl/c16/Medicare-Physician-and-Other-Supplier-NPI-Aggregate-CY2012.xlsx"
  # File with aggregate data in RDS format
file_aggregate_rds <- "~/Google Drive/classes/dcl/c16/c16_medicare_agg.rds"

#===============================================================================

# Convert Medicare aggregate data from Excel format to RDS


file_aggregate_xlxs %>%
  read_lines(n_max = 10L)

file_aggregate_xlxs %>%
  readxl::read_excel(sheet = 3) %>%
  select(
    NPI                              = "NPI",
    NPPES_PROVIDER_LAST_ORG_NAME     = "NPPES Provider Last Name / Organization Name",
    NPPES_PROVIDER_FIRST_NAME        = "NPPES Provider First Name",
    NPPES_PROVIDER_MI                = "NPPES Provider Middle Initial",
    NPPES_CREDENTIALS                = "NPPES Credentials",
    NPPES_PROVIDER_GENDER            = "NPPES Provider Gender",
    NPPES_ENTITY_CODE                = "NPPES Entity Code",
    NPPES_PROVIDER_STREET1           = "NPPES Provider Street Address 1",
    NPPES_PROVIDER_STREET2           = "NPPES Provider Street Address 2",
    NPPES_PROVIDER_CITY              = "NPPES Provider City",
    NPPES_PROVIDER_ZIP               = "NPPES Provider Zip Code",
    NPPES_PROVIDER_STATE             = "NPPES Provider State",
    NPPES_PROVIDER_COUNTRY           = "NPPES Provider Country",
    PROVIDER_TYPE                    = "Provider Type",
    MEDICARE_PARTICIPATION_INDICATOR = "Medicare Participation Indicator",
    TOTAL_HCPCS_CODE                 = "Number of HCPCS",
    TOTAL_LINE_SRVC_CNT              = "Number of Services",
    BENE_UNIQUE_CNT                  = "Number of Unique Beneficiaries",
    TOTAL_SUBMITTED_CHRG_AMT         = "Total Submitted Charges",
    TOTAL_MEDICARE_ALLOWED_AMT       = "Total Medicare Allowed Amount",
    TOTAL_MEDICARE_PAYMENT_AMT       = "Total Medicare Payment Amount"
  ) %>%
  write_rds(file_aggregate_rds)
