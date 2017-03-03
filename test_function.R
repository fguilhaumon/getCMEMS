################################################
# Testing :
# R wrapper for motu CMEMS data download
#
# francois.guilhaumon@ird.fr
################################################

## sourcing the function
source("getCMEMS.R")

## parameters

### motu-client.py path
### this may chnage according to your computer configuration
motu_cl_lib <- "libs/motu-client-python-master/src/python/motu-client.py"

### output dir
outDir <- "downs/"

### credentials (in cred.txt)
source("cred.txt")

### call the functions
res <- getCMEMS(motu_cl = motu_cl_lib , 
	    out_path = outDir,
	    log_cmems = log,
	    pwd_cmems = pass,
	    # Date 
	    yyyystart="2013",
	    mmstart="01",
	    yyyyend="2013",
	    mmend="03",
	    hh=" 12:00:00",
	    dd="01")



res_monthly <- getCMEMS_monthly(motu_cl = motu_cl_lib , 
		        out_path = outDir,
		        log_cmems = log,
		        pwd_cmems = pass,
		        # Date 
		        yyyystart="2013",
		        mmstart="01")

## ---- ReadResults
library(ncdf4)


#getCMEMS
jan <- nc_open("downs/global-analysis-forecast-phy-001-024_thetao_2013-01.nc")

# Read longitude & latitude
lon <- ncvar_get(jan, "longitude")
lat <- ncvar_get(jan, "latitude")

#Read the time
time_jan <- ncvar_get(jan, "time")

length(time_jan) == length(res)


#monthly

mon <- nc_open("downs/monthly_global-analysis-forecast-phy-001-024_thetao_2013-01.nc")

#Read the time
time_mon <- ncvar_get(mon, "time")

length(time_mon) == length(res_monthly)

