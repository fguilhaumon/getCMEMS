################################################
#
# R wrapper for CMEMS3567_GLO_Daily_by_Month.py
#
# francois.guilhaumon@ird.fr
################################################

getCMEMS <- function(scriptPath="libs/CMEMS3567_GLO_Daily_by_Month_CallFromR.py",
	         python = "python",  #path to python executable
	         motu_cl = "libs/motu-client-python-master/src/python/motu-client.py", #path to 'motu-client.py' (https://github.com/clstoulouse/motu-client-python),
	         # Login Credentials
	         log_cmems=log,   
	         pwd_cmems=pass, 
	         # Motu Server and chosen Product/Dataset
	         motu_sc="http://nrtcmems.mercator-ocean.fr/mis-gateway-servlet/Motu",
	         serv_id="http://purl.org/myocean/ontology/service/database#GLOBAL_ANALYSIS_FORECAST_PHY_001_024-TDS",
	         dataset_id="global-analysis-forecast-phy-001-024",
	         # Date 
	         yyyystart="2013",
	         mmstart="01",
	         yyyyend="2013",
	         mmend="02",
	         hh=" 12:00:00",
	         dd="01",
	         # Area 
	         xmin="163.473146",
	         xmax="163.633146",
	         ymin="-21.523697",
	         ymax="-21.363697",
	         zsmall="0.494", 
	         zbig="1.5415",
	         # Variables 
	         var = "thetao",
	         # Output files 
	         out_path =  "downs/", #Make sure to end your path with "/" 
	         pre_name= ""){
	
	c1 <- 'python '
	c2 <- ' -u '
	c3 <- ' -p '
	c4 <- ' -m '
	c5 <- ' -s '
	c6 <- ' -d '
	c7 <- ' -x '
	c8 <- ' -X '
	c9 <- ' -y '
	c10 <- ' -Y '
	c11 <- ' -t '
	c12 <- ' -T '
	c13 <- ' -z '
	c14 <- ' -Z '
	c15 <- ' -v '
	c16 <- ' -o '
	c17 <- ' -f '
	
	outFName <- paste0(pre_name,dataset_id,"_",var,"_",yyyystart,"-",mmstart,".nc")
	tstart <- paste0(yyyystart,"-",mmstart,"-",dd," ",hh)
	tend <- paste0(yyyyend,"-",mmend,"-",dd," ",hh)
	
	
	command <- paste0(c1 , motu_cl , c2 , log_cmems , c3 , pwd_cmems , c4 , motu_sc ,
		      c5 , serv_id , c6 , dataset_id , c7 , xmin, c8 , xmax , c9 ,
		      ymin , c10 , ymax , c11 , tstart , c12 , tend , c13 , zsmall ,
		      c14 , zbig , c15 , var , c16 , outDir, c17, outFName)
	
	res_com <- system(command)
	
	fail <- ifelse(res_com!=0,TRUE,FALSE)
	if(fail) return(NA)
	
	if(!fail){
		
		n_days <- as.numeric(as.Date(tend) - as.Date(tstart))
		seq_days <- as.Date(tstart)+0:(n_days-1)
		
		return(seq_days)
		
	}#eo if fail

}#eo getCMEMS


getCMEMS_monthly <- function(python = "python",  #path to python executable
		     motu_cl = "libs/motu-client-python-master/src/python/motu-client.py", #path to 'motu-client.py' (https://github.com/clstoulouse/motu-client-python),
		     # Login Credentials
		     log_cmems=log,   
		     pwd_cmems=pass, 
		     # Motu Server and chosen Product/Dataset
		     motu_sc="http://nrtcmems.mercator-ocean.fr/mis-gateway-servlet/Motu",
		     serv_id="http://purl.org/myocean/ontology/service/database#GLOBAL_ANALYSIS_FORECAST_PHY_001_024-TDS",
		     dataset_id="global-analysis-forecast-phy-001-024",
		     # Date 
		     yyyystart="2013",
		     mmstart="12",
		     # Area 
		     xmin="163.473146",
		     xmax="163.633146",
		     ymin="-21.523697",
		     ymax="-21.363697",
		     zsmall="0.494", 
		     zbig="1.5415",
		     # Variables 
		     var = "thetao",
		     # Output files 
		     out_path =  "downs/", #Make sure to end your path with "/" 
		     pre_name= "monthly_"){
	
	tstart <- paste0(yyyystart,"-",mmstart,"-01 12:00:00")
	
	date_end <- seq(as.Date(tstart),by='months',length=2)[2]
	
	dat_end_split <- strsplit(as.character(date_end),"-")[[1]]

	yyyyend <- dat_end_split[1]
	mmend <- dat_end_split[2]
	dd <- "01"
	hh <- "12:00:00"
	
	getCMEMS(python = python,  #path to python executable
	         motu_cl = motu_cl,
	         # Login Credentials
	         log_cmems=log_cmems,   
	         pwd_cmems=pwd_cmems, 
	         # Motu Server and chosen Product/Dataset
	         motu_sc=motu_sc,
	         serv_id=serv_id,
	         dataset_id=dataset_id,
	         # Date 
	         yyyystart=yyyystart,
	         mmstart=mmstart,
	         yyyyend=yyyyend,
	         mmend=mmend,
	         hh=hh,
	         dd=dd,
	         # Area 
	         xmin=xmin,
	         xmax=xmax,
	         ymin=ymin,
	         ymax=ymax,
	         zsmall=zsmall, 
	         zbig=zbig,
	         # Variables 
	         var=var,
	         # Output files 
	         out_path=out_path, #Make sure to end your path with "/" 
	         pre_name=pre_name)
	
	
}#getCMEMS_monthly



