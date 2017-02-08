#' Example data conversion using multiple sites.
#'
#' Finds all sites in a directory, an converts them to netcdf.
#' Converts useful variables from a Fluxnet 2015 spreatsheet format into two
#' netcdf files, one for fluxes, and one for met forcings.


# initial garbage collection
rm(list = ls(all = TRUE))

library("FluxnetProcessing")

# This directory should contain appropriate data from
# http://fluxnet.fluxdata.org/data/fluxnet2015-dataset/
in_path <- "~/phd/data/Fluxnet2015/FULLSET/"

# Directory where the converted Fluxnet netcdf files will be saved.
out_path <- "~/phd/data/Fluxnet2015/processed/"

# Search for available site files. Matches e.g. AU-How.
# If your extraction method is different, you may need to change the pattern.
site_code_pattern <- paste0(in_path, "??-*")
site_codes <- basename(Sys.glob("~/phd/data/Fluxnet2015/FULLSET/??-*"))

# Flux file pattern
flux_csv_template <- paste0(in_path, "%s/FLX_%s_FLUXNET2015_FULLSET_HH_2001-2014_1-3.csv")

# ERA file pattern
era_csv_template <- paste0(in_path, "%s/FLX_%s_FLUXNET2015_ERAI_HH_1989-2014_1-3.csv")

era_gapfill <- TRUE

for (site_code in site_codes) {
    flux_csv_file <- sprintf(flux_csv_template, site_code)
    era_csv_file <- sprintf(era_csv_template, site_code)

    convert_fluxnet_to_netcdf(infile = flux_csv_file, site_code = site_code, out_path = out_path,
                              ERA_file = era_csv_file, ERA_gapfill = era_gapfill)
}
