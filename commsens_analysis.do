clear
set more off 

capture log close
log using "commsens_log.log", replace

use "commsens_data.dta"

* ANALYSIS FOR MAIN SECTION OF PAPER
* summary statistics 
* overall meeting attendance
tab sv_any, m 
tab hf_any, m
tab sensitiz_any, m
tab sv_any hf_any, m
		
*individual meeting attendance among 2016-18 survey participants
tab hf_buhingo_20190408
tab hf_buhingo_20190506
tab hf_bukuna1_20190401
tab hf_bukuna1_20190509
tab hf_bukuna2_20190401
tab hf_bukuna2_20190509
tab hf_bushenyi_20190404
tab hf_bushenyi_20190502
tab hf_nyakabare_20190408
tab hf_nyakabare_20190506
tab hf_nyamikanja1_20190403
tab hf_nyamikanja1_20190508
tab hf_nyamikanja2_20190508
tab hf_rwembogo_20190404
tab hf_rwembogo_20190502
tab hf_parishhq_20190328
			
tab sv_buhingo_20180830
tab sv_bukuna2_20180823
tab sv_bushenyi_20180830
tab sv_nyakabare_20180829
tab sv_nyamikanja1_20180827
tab sv_nyamikanja2_20180827
tab sv_rwembogo_20180829
tab sv_leadership_20180820
		
*sociodemographic comparison - whole sample vs survey/hf meeting attendees
tabstat age, stats(n mean sd p50 p25 p75)
tabstat age, by(sv_any) stats(n mean sd p50 p25 p75)
tabstat age, by(hf_any) stats(n mean sd p50 p25 p75)

tab female
tab female sv_any, col m
tab female hf_any, col m

tab married
tab married sv_any, col m
tab married hf_any, col m
			
*characteristics of study participants, stratified by attendance (Table 2)
*categorical / binary variables
tab agecat sensitiz_any, m row col
tab female sensitiz_any, m row col
tab married sensitiz_any, m row col
tab primary_complete sensitiz_any, m row col
tab hivstat_binary sensitiz_any, m row col
tab obese sensitiz_any, m row col
tab hfiascat sensitiz_any, m row col
tab hwiascat sensitiz_any, m row col

*continuous variables
tabstat hscld_bolton, stats(n mean sd p50 p25 p75)
tabstat hscld_bolton if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat hscld_bolton if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat n_particip, stats(n mean sd p50 p25 p75)
tabstat n_particip if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat n_particip if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat loneliness, stats(n mean sd p50 p25 p75)
tabstat loneliness if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat loneliness if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat dist_sens_any, stats(n mean sd p50 p25 p75)
tabstat dist_sens_any if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat dist_sens_any if sensitiz_any==0, stats(n mean sd p50 p25 p75)
			
*network centrality variables
tabstat _in_degree, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat _closeness, stats(n mean sd p50 p25 p75)
tabstat _closeness if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if sensitiz_any==0, stats(n mean sd p50 p25 p75)
tabstat _between, stats(n mean sd p50 p25 p75)
tabstat _between if sensitiz_any==1, stats(n mean sd p50 p25 p75)
tabstat _between if sensitiz_any==0, stats(n mean sd p50 p25 p75)

*single variable Poisson regression models
*attendance at community sensitization meeting in advance of survey (Table 3)
*excluding participants from village 6 (Bukuna 1) - no attendance log
poisson sv_any age if vid!=6, irr vce(cluster vid)
poisson sv_any female if vid!=6, irr vce(cluster vid)
poisson sv_any married if vid!=6, irr vce(cluster vid)
poisson sv_any primary_complete if vid!=6, irr vce(cluster vid)
poisson sv_any hivstat_binary if vid!=6, irr vce(cluster vid)
poisson sv_any obese if vid!=6, irr vce(cluster vid)
poisson sv_any hscld_bolton if vid!=6, irr vce(cluster vid)
poisson sv_any i.hfiascat if vid!=6, irr vce(cluster vid)
poisson sv_any i.hwiascat if vid!=6, irr vce(cluster vid)
poisson sv_any i.aindexq if vid!=6, irr vce(cluster vid)
poisson sv_any n_memberships if vid!=6, irr vce(cluster vid)
poisson sv_any n_particip if vid!=6, irr vce(cluster vid)
poisson sv_any loneliness if vid!=6, irr vce(cluster vid)
poisson sv_any dist_sv if vid!=6, irr vce(cluster vid)
			
*attendance at community sensitization meeting in advance of health fair (Table 3)
*all villages 
poisson hf_any age, irr vce(cluster vid)
poisson hf_any female, irr vce(cluster vid)
poisson hf_any married, irr vce(cluster vid)
poisson hf_any primary_complete, irr vce(cluster vid)
poisson hf_any hivstat_binary, irr vce(cluster vid)
poisson hf_any obese, irr vce(cluster vid)
poisson hf_any hscld_bolton, irr vce(cluster vid)
poisson hf_any i.hfiascat, irr vce(cluster vid)
poisson hf_any i.hwiascat, irr vce(cluster vid)
poisson hf_any i.aindexq, irr vce(cluster vid)
poisson hf_any n_memberships, irr vce(cluster vid)
poisson hf_any n_particip, irr vce(cluster vid)
poisson hf_any loneliness, irr vce(cluster vid)
poisson hf_any dist_hf19, irr vce(cluster vid)
			
*multivariable Poisson regression models
*attendance at community sensitization meeting in advance of survey (Table 3)
*excluding participants from village 6 (Bukuna 1) - no attendance log
global xlist age female married primary_complete hivstat_binary obese hscld_bolton i.hfiascat i.hwiascat i.aindexq n_memberships n_particip loneliness dist_sv
poisson sv_any $xlist if vid!=6, irr vce(cluster vid)

*attendance at community sensitization meeting in advance of health fair (Table 3)
*all villages
global ylist age female married primary_complete hivstat_binary obese hscld_bolton i.hfiascat i.hwiascat i.aindexq n_memberships n_particip loneliness dist_hf19
poisson hf_any $ylist, irr vce(cluster vid)
			
*t-tests and chi-squared tests 
*non-attendees in attendees' social networks (geodesic=1) vs non-attendees NOT in attendees' social networks (geodesic>1)
*survey meeting 
tab agecat sv_nonattendee_geodesic if sv_any==0, chi2
ttest age if sv_any==0, by(sv_nonattendee_geodesic)

tab female sv_nonattendee_geodesic if sv_any==0, chi2 row col
ereturn list
return list
bootstrap r(chi2), reps(1366) : tab female sv_nonattendee_geodesic if sv_any==0, chi2
estat bootstrap, all

tab married sv_nonattendee_geodesic if sv_any==0, chi2 row col
ereturn list
return list
bootstrap r(chi2), reps(1366) : tab married sv_nonattendee_geodesic if sv_any==0, chi2
estat bootstrap, all

ttest n_memberships if sv_any==0, by(sv_nonattendee_geodesic)

ttest _in_degree if sv_any==0, by(sv_nonattendee_geodesic)
ttest _out_degree if sv_any==0, by(sv_nonattendee_geodesic)
ttest _closeness if sv_any==0, by(sv_nonattendee_geodesic)
ttest _between if sv_any==0, by(sv_nonattendee_geodesic)

*health fair meeting 
tab agecat hf_nonattendee_geodesic if hf_any==0, chi2
ttest age if hf_any==0, by(hf_nonattendee_geodesic)

tab female hf_nonattendee_geodesic if hf_any==0, chi2 row col
ereturn list
return list
bootstrap r(chi2), reps(1166) : tab female hf_nonattendee_geodesic if hf_any==0, chi2
estat bootstrap, all

tab married hf_nonattendee_geodesic if hf_any==0, chi2 row col
ereturn list
return list
bootstrap r(chi2), reps(1166) : tab married hf_nonattendee_geodesic if hf_any==0, chi2
estat bootstrap, all

ttest n_memberships if hf_any==0, by(hf_nonattendee_geodesic)

ttest _in_degree if hf_any==0, by(hf_nonattendee_geodesic)
ttest _out_degree if hf_any==0, by(hf_nonattendee_geodesic)
ttest _closeness if hf_any==0, by(hf_nonattendee_geodesic)
ttest _between if hf_any==0, by(hf_nonattendee_geodesic)

*non-attendees in attendees' households vs overall sample 
*survey meeting 
tab agecat sv_nonattendee_hid if sv_hid==1, chi2
ttest age if sv_hid==1, by(sv_nonattendee_hid)

tab female sv_nonattendee_hid if sv_hid==1, chi2 row col
ereturn list
return list
bootstrap r(chi2), reps(545) : tab female sv_nonattendee_hid if sv_hid==1, chi2
estat bootstrap, all

tab married sv_nonattendee_hid if sv_hid==1, chi2 row col 
ereturn list
return list
bootstrap r(chi2), reps(545) : tab married sv_nonattendee_hid if sv_hid==1, chi2
estat bootstrap, all

ttest n_memberships if sv_hid==1, by(sv_nonattendee_hid)

ttest _in_degree if sv_hid==1, by(sv_nonattendee_hid)
ttest _out_degree if sv_hid==1, by(sv_nonattendee_hid)
ttest _closeness if sv_hid==1, by(sv_nonattendee_hid)
ttest _between if sv_hid==1, by(sv_nonattendee_hid)

*health fair meeting 
tab agecat hf_nonattendee_hid if hf_hid==1, chi2
ttest age if hf_hid==1, by(hf_nonattendee_hid)

tab female hf_nonattendee_hid if hf_hid==1, chi2 row col
ereturn list
return list
bootstrap r(chi2), reps(897) : tab female hf_nonattendee_hid if hf_hid==1, chi2
estat bootstrap, all

tab married hf_nonattendee_hid if hf_hid==1, chi2 row col 
ereturn list
return list
bootstrap r(chi2), reps(897) : tab married hf_nonattendee_hid if hf_hid==1, chi2
estat bootstrap, all
			
ttest n_memberships if hf_hid==1, by(hf_nonattendee_hid)
			
ttest _in_degree if hf_hid==1, by(hf_nonattendee_hid)
ttest _out_degree if hf_hid==1, by(hf_nonattendee_hid)
ttest _closeness if hf_hid==1, by(hf_nonattendee_hid)
ttest _between if hf_hid==1, by(hf_nonattendee_hid)

*combined network reach (attendees, non-attendees in attendees' social networks, non-attendees in attendees' households)
*survey meeting 
tab sv_nonattendee_geodesic if sv_nonattendee_hid!=1
tab sv_nonattendee_hid if sv_nonattendee_geodesic!=1
tab sv_nonattendee_hid if sv_nonattendee_geodesic==1
tab sv_nonattendee_hid if sv_nonattendee_geodesic==0
tab sv_network sv_hid, row col

ttest age, by(sv_reach)
tab female sv_reach, chi2 row col
tab married sv_reach, chi2 row col 
tab primary_complete sv_reach, chi2 row col
tab hivstat_binary sv_reach, chi2 row col
tab obese sv_reach, chi2 row col 
ttest hscld_bolton, by(sv_reach)
ttest n_memberships, by(sv_reach)
ttest n_particip, by(sv_reach)
ttest loneliness, by(sv_reach)	
		
*health fair meeting 
tab hf_nonattendee_geodesic if hf_nonattendee_hid!=1
tab hf_nonattendee_hid if hf_nonattendee_geodesic!=1
tab hf_nonattendee_hid if hf_nonattendee_geodesic==1
tab hf_network hf_hid, row col

ttest age, by(hf_reach)
tab female hf_reach, chi2 row col
tab married hf_reach, chi2 row col 
tab primary_complete hf_reach, chi2 row col
tab hivstat_binary hf_reach, chi2 row col
tab obese hf_reach, chi2 row col 
ttest hscld_bolton, by(hf_reach)
ttest n_memberships, by(hf_reach)
ttest n_particip, by(hf_reach)
ttest loneliness, by(hf_reach)
			
			
			
*ANALYSIS FOR SUPPORTING INFORMATION TABLES
*summary statistics 
*attendance at community sensitization meetings in advance of survey (S1 Table)
*survey meeting attendees
tab agecat sv_any, m row col
tab female sv_any, m row col
tab married sv_any, m row col
tab primary_complete sv_any, m row col
tab hivstat_binary sv_any, m row col
tab obese sv_any, m row col
tab hfiascat sv_any, m row col
tab hwiascat sv_any, m row col
tabstat hscld_bolton if sv_any==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_any==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_any==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_any==1, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_any==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_any==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_any==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_any==1, stats(n mean sd p50 p25 p75)
tabstat _between if sv_any==1, stats(n mean sd p50 p25 p75)

*survey meeting non-attendees in attendees' social networks 
tab agecat if sv_nonattendee_geodesic==1, m
tab female if sv_nonattendee_geodesic==1, m
tab married if sv_nonattendee_geodesic==1, m
tab primary_complete if sv_nonattendee_geodesic==1, m
tab hivstat_binary if sv_nonattendee_geodesic==1, m
tab obese if sv_nonattendee_geodesic==1, m
tab hfiascat if sv_nonattendee_geodesic==1, m
tab hwiascat if sv_nonattendee_geodesic==1, m
tabstat hscld_bolton if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _between if sv_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
			
*survey meeting non-attendees NOT in attendees' social networks
tab agecat if sv_nonattendee_geodesic==0 & sv_any==0, m
tab female if sv_nonattendee_geodesic==0 & sv_any==0, m
tab married if sv_nonattendee_geodesic==0 & sv_any==0, m
tab primary_complete if sv_nonattendee_geodesic==0 & sv_any==0, m
tab hivstat_binary if sv_nonattendee_geodesic==0 & sv_any==0, m
tab obese if sv_nonattendee_geodesic==0 & sv_any==0, m
tab hfiascat if sv_nonattendee_geodesic==0 & sv_any==0, m
tab hwiascat if sv_nonattendee_geodesic==0 & sv_any==0, m
tabstat hscld_bolton if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _between if sv_nonattendee_geodesic==0 & sv_any==0, stats(n mean sd p50 p25 p75)

*survey meeting non-attendees in attendees' households
tab agecat if sv_nonattendee_hid==1, m
tab female if sv_nonattendee_hid==1, m
tab married if sv_nonattendee_hid==1, m
tab primary_complete if sv_nonattendee_hid==1, m
tab hivstat_binary if sv_nonattendee_hid==1, m
tab obese if sv_nonattendee_hid==1, m
tab hfiascat if sv_nonattendee_hid==1, m
tab hwiascat if sv_nonattendee_hid==1, m
tabstat hscld_bolton if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _between if sv_nonattendee_hid==1, stats(n mean sd p50 p25 p75)

*survey meeting non-attendees NOT in attendees' households
tab agecat if sv_nonattendee_hid==0 & sv_any==0, m
tab female if sv_nonattendee_hid==0 & sv_any==0, m
tab married if sv_nonattendee_hid==0 & sv_any==0, m
tab primary_complete if sv_nonattendee_hid==0 & sv_any==0, m
tab hivstat_binary if sv_nonattendee_hid==0 & sv_any==0, m
tab obese if sv_nonattendee_hid==0 & sv_any==0, m
tab hfiascat if sv_nonattendee_hid==0 & sv_any==0, m
tab hwiascat if sv_nonattendee_hid==0 & sv_any==0, m
tabstat hscld_bolton if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)
tabstat _between if sv_nonattendee_hid==0 & sv_any==0, stats(n mean sd p50 p25 p75)

*overall reach - attendees, non-attendees in attendees' social networks, non-attendees in attendees' households
tab agecat if sv_reach==1, m
tab female if sv_reach==1, m
tab married if sv_reach==1, m
tab primary_complete if sv_reach==1, m
tab hivstat_binary if sv_reach==1, m
tab obese if sv_reach==1, m
tab hfiascat if sv_reach==1, m
tab hwiascat if sv_reach==1, m
tabstat hscld_bolton if sv_reach==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_reach==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_reach==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_reach==1, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_reach==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_reach==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_reach==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_reach==1, stats(n mean sd p50 p25 p75)
tabstat _between if sv_reach==1, stats(n mean sd p50 p25 p75)

*survey meeting non-attendees NOT in attendees' social networks OR households 
tab agecat if sv_reach==0, m
tab female if sv_reach==0, m
tab married if sv_reach==0, m
tab primary_complete if sv_reach==0, m
tab hivstat_binary if sv_reach==0, m
tab obese if sv_reach==0, m
tab hfiascat if sv_reach==0, m
tab hwiascat if sv_reach==0, m
tabstat hscld_bolton if sv_reach==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships if sv_reach==0, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if sv_reach==0, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if sv_reach==0, stats(n mean sd p50 p25 p75)
tabstat dist_sv if sv_reach==0, stats(n mean sd p50 p25 p75)
tabstat _in_degree if sv_reach==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree if sv_reach==0, stats(n mean sd p50 p25 p75)
tabstat _closeness if sv_reach==0, stats(n mean sd p50 p25 p75)
tabstat _between if sv_reach==0, stats(n mean sd p50 p25 p75)

*attendance at community sensitization meetings in advance of health fair (S1 Table)
*health fair meeting attendees 
tab agecat hf_any, m row col
tab female hf_any, m row col
tab married hf_any, m row col
tab primary_complete hf_any, m row col
tab hivstat_binary hf_any, m row col
tab obese hf_any, m row col
tab hfiascat hf_any, m row col
tab hwiascat hf_any, m row col
tabstat hscld_bolton if hf_any==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_any==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_any==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_any==1, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_any==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_any==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_any==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_any==1, stats(n mean sd p50 p25 p75)
tabstat _between if hf_any==1, stats(n mean sd p50 p25 p75)

*health fair meeting non-attendees in attendees' social networks 
tab agecat if hf_nonattendee_geodesic==1, m
tab female if hf_nonattendee_geodesic==1, m
tab married if hf_nonattendee_geodesic==1, m
tab primary_complete if hf_nonattendee_geodesic==1, m
tab hivstat_binary if hf_nonattendee_geodesic==1, m
tab obese if hf_nonattendee_geodesic==1, m
tab hfiascat if hf_nonattendee_geodesic==1, m
tab hwiascat if hf_nonattendee_geodesic==1, m
tabstat hscld_bolton if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
tabstat _between if hf_nonattendee_geodesic==1, stats(n mean sd p50 p25 p75)
			
*health fair meeting non-attendees NOT in attendees' social networks
tab agecat if hf_nonattendee_geodesic==0 & hf_any==0, m
tab female if hf_nonattendee_geodesic==0 & hf_any==0, m
tab married if hf_nonattendee_geodesic==0 & hf_any==0, m
tab primary_complete if hf_nonattendee_geodesic==0 & hf_any==0, m
tab hivstat_binary if hf_nonattendee_geodesic==0 & hf_any==0, m
tab obese if hf_nonattendee_geodesic==0 & hf_any==0, m
tab hfiascat if hf_nonattendee_geodesic==0 & hf_any==0, m
tab hwiascat if hf_nonattendee_geodesic==0 & hf_any==0, m
tabstat hscld_bolton if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _between if hf_nonattendee_geodesic==0 & hf_any==0, stats(n mean sd p50 p25 p75)

*health fair meeting non-attendees in attendees' households
tab agecat if hf_nonattendee_hid==1, m
tab female if hf_nonattendee_hid==1, m
tab married if hf_nonattendee_hid==1, m
tab primary_complete if hf_nonattendee_hid==1, m
tab hivstat_binary if hf_nonattendee_hid==1, m
tab obese if hf_nonattendee_hid==1, m
tab hfiascat if hf_nonattendee_hid==1, m
tab hwiascat if hf_nonattendee_hid==1, m
tabstat hscld_bolton if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
tabstat _between if hf_nonattendee_hid==1, stats(n mean sd p50 p25 p75)
			
*health fair meeting non-attendees NOT in attendees' households
tab agecat if hf_nonattendee_hid==0 & hf_any==0, m
tab female if hf_nonattendee_hid==0 & hf_any==0, m
tab married if hf_nonattendee_hid==0 & hf_any==0, m
tab primary_complete if hf_nonattendee_hid==0 & hf_any==0, m
tab hivstat_binary if hf_nonattendee_hid==0 & hf_any==0, m
tab obese if hf_nonattendee_hid==0 & hf_any==0, m
tab hfiascat if hf_nonattendee_hid==0 & hf_any==0, m
tab hwiascat if hf_nonattendee_hid==0 & hf_any==0, m
tabstat hscld_bolton if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)
tabstat _between if hf_nonattendee_hid==0 & hf_any==0, stats(n mean sd p50 p25 p75)

*overall reach - attendees, non-attendees in attendees' social networks, non-attendees in attendees' households
tab agecat if hf_reach==1, m
tab female if hf_reach==1, m
tab married if hf_reach==1, m
tab primary_complete if hf_reach==1, m
tab hivstat_binary if hf_reach==1, m
tab obese if hf_reach==1, m
tab hfiascat if hf_reach==1, m
tab hwiascat if hf_reach==1, m
tabstat hscld_bolton if hf_reach==1, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_reach==1, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_reach==1, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_reach==1, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_reach==1, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_reach==1, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_reach==1, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_reach==1, stats(n mean sd p50 p25 p75)
tabstat _between if hf_reach==1, stats(n mean sd p50 p25 p75)

*survey meeting non-attendees NOT in attendees' social networks OR households
tab agecat if hf_reach==0, m
tab female if hf_reach==0, m
tab married if hf_reach==0, m
tab primary_complete if hf_reach==0, m
tab hivstat_binary if hf_reach==0, m
tab obese if hf_reach==0, m
tab hfiascat if hf_reach==0, m
tab hwiascat if hf_reach==0, m
tabstat hscld_bolton if hf_reach==0, stats(n mean sd p50 p25 p75)
tabstat n_memberships if hf_reach==0, stats(n mean sd p50 p25 p75 min max)
tabstat n_particip if hf_reach==0, stats(n mean sd p50 p25 p75 min max)
tabstat loneliness if hf_reach==0, stats(n mean sd p50 p25 p75)
tabstat dist_hf19 if hf_reach==0, stats(n mean sd p50 p25 p75)
tabstat _in_degree if hf_reach==0, stats(n mean sd p50 p25 p75)
tabstat _out_degree if hf_reach==0, stats(n mean sd p50 p25 p75)
tabstat _closeness if hf_reach==0, stats(n mean sd p50 p25 p75)
tabstat _between if hf_reach==0, stats(n mean sd p50 p25 p75)
			
	
			
*ANALYSIS FOR RESPONSE TO REVIEWERS
*single variable Poisson regression models
*attendance at community sensitization meeting in advance of survey (R&R)
*network centrality variables
poisson sv_any _in_degree if vid!=6, irr vce(cluster vid)
poisson sv_any _out_degree if vid!=6, irr vce(cluster vid)
poisson sv_any _closeness if vid!=6, irr vce(cluster vid)
poisson sv_any _between if vid!=6, irr vce(cluster vid)

*attendance at community sensitization meeting in advance of health fair (R&R)
*network centrality variables
poisson hf_any _in_degree, irr vce(cluster vid)
poisson hf_any _out_degree, irr vce(cluster vid)
poisson hf_any _closeness, irr vce(cluster vid)
poisson hf_any _between, irr vce(cluster vid)
			
*attendance at community sensitization in advance of either study activity (R&R)
*all villages
poisson sensitiz_any age, irr vce(cluster vid)
poisson sensitiz_any female, irr vce(cluster vid)
poisson sensitiz_any married, irr vce(cluster vid)
poisson sensitiz_any primary_complete, irr vce(cluster vid)
poisson sensitiz_any hivstat_binary, irr vce(cluster vid)
poisson sensitiz_any obese, irr vce(cluster vid)
poisson sensitiz_any hscld_bolton, irr vce(cluster vid)
poisson sensitiz_any i.hfiascat, irr vce(cluster vid)
poisson sensitiz_any i.hwiascat, irr vce(cluster vid)
poisson sensitiz_any i.aindexq, irr vce(cluster vid)
poisson sensitiz_any n_memberships, irr vce(cluster vid)
poisson sensitiz_any n_particip, irr vce(cluster vid)
poisson sensitiz_any loneliness, irr vce(cluster vid)
poisson sensitiz_any dist_hf19, irr vce(cluster vid)
			
*multivariable Poisson regression models
*attendance at community sensitization meeting in advance of either study activity (R&R)
global wlist age female married primary_complete hivstat_binary obese hscld_bolton i.hfiascat i.hwiascat i.aindexq n_memberships n_particip loneliness dist_sens_any
poisson sensitiz_any $wlist, irr vce(cluster vid)
		
*with network centrality measures (R&R)
*attendance at community sensitization meeting in advance of survey - excluding participants from village 6 (Bukuna 1)
poisson sv_any $xlist _in_degree _out_degree _closeness _between if vid!=6, irr vce(cluster vid)
			
*attendance at community sensitization meeting in advance of health fair 
poisson hf_any $ylist _in_degree _out_degree _closeness _between, irr vce(cluster vid)
			
*attendance at community sensitization meeting in advance of either study activity 
poisson sensitiz_any $wlist _in_degree _out_degree _closeness _between, irr vce(cluster vid)

*single variable log-binomial regression models 
*attendance at community sensitization meeting in advance of survey - excluding participants from village 6 (Bukuna 1; R&R)
glm sv_any age if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any female if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any married if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any primary_complete if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any hivstat_binary if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any obese if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any hscld_bolton if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any i.hfiascat if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any i.hwiascat if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any i.aindexq if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any n_memberships if vid!=6, family(binomial) link(log) vce(cluster vid) eform difficult
glm sv_any n_particip if vid!=6, family(binomial) link(log) vce(cluster vid) eform difficult
glm sv_any loneliness if vid!=6, family(binomial) link(log) vce(cluster vid) eform
glm sv_any dist_sv if vid!=6, family(binomial) link(log) vce(cluster vid) eform
			
*attendance at community sensitization meeting in advance of health fair (R&R)
glm hf_any age, family(binomial) link(log) vce(cluster vid) eform
glm hf_any female, family(binomial) link(log) vce(cluster vid) eform
glm hf_any married, family(binomial) link(log) vce(cluster vid) eform
glm hf_any primary_complete, family(binomial) link(log) vce(cluster vid) eform
glm hf_any hivstat_binary, family(binomial) link(log) vce(cluster vid) eform
glm hf_any obese, family(binomial) link(log) vce(cluster vid) eform
glm hf_any hscld_bolton, family(binomial) link(log) vce(cluster vid) eform
glm hf_any i.hfiascat, family(binomial) link(log) vce(cluster vid) eform
glm hf_any i.hwiascat, family(binomial) link(log) vce(cluster vid) eform
glm hf_any i.aindexq, family(binomial) link(log) vce(cluster vid) eform
glm hf_any n_memberships, family(binomial) link(log) vce(cluster vid) eform
glm hf_any n_particip, family(binomial) link(log) vce(cluster vid) eform
glm hf_any loneliness, family(binomial) link(log) vce(cluster vid) eform
glm hf_any dist_hf19, family(binomial) link(log) vce(cluster vid) eform
	
*multivariable log-binomial regression models 
*attendance at community sensitization meeting in advance of survey - excluding participants from village 6 (Bukuna 1; R&R)
glm sv_any $xlist if vid!=6, family(binomial) link(log) vce(cluster vid) eform difficult
		
*attendance at community sensitization meeting in advance of health fair (R&R)
glm hf_any $ylist, family(binomial) link(log) vce(cluster vid) eform iterate(1000) difficult
**NOTE: model does not converge 

log close