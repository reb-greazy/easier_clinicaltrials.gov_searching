#Query ClinicalTrials.gov through AACT
#REBEKAH GRIESENAUER
#rgriesenauer@wustl.edu

########
#uncomment to install packages
#install.packages('rentrez') 
#install.packages('RPostgreSQL')

library(RPostgreSQL)

########
#setup postgres driver
drv <- dbDriver('PostgreSQL')

# SQL query string that you want to query the AACT database with, can change this string to get different information:https://aact.ctti-clinicaltrials.org/learn_more

#You may want to reference the AACT database schema to help with your query: 

#Example Query
query_string="SELECT  t1.nct_id, t1.downcase_mesh_term, t2.downcase_name, t.study_type, 
t5.contact_type, t5.name, t5.email, t5.phone, t6.role as overall_official_role, t6.name as overall_official_name
FROM ctgov.studies t
left join ctgov.browse_conditions t1 on t.nct_id = t1.nct_id
left join ctgov.conditions t2 on t.nct_id=t2.nct_id
left join ctgov.studies t3 on t.nct_id=t3.nct_id
left join ctgov.facilities t4 on t.nct_id=t4.nct_id
left join ctgov.facility_contacts t5 on t.nct_id= t5.nct_id
left join ctgov.overall_officials t6 on t.nct_id=t6.nct_id
where t.study_type = 'Interventional'
and t4.country = 'United States'
and t.overall_status in ('Recruiting','Enrolling by invitation','Active, not recruiting')
and t1.downcase_mesh_term like ('%alzheimer%') 
or t2.downcase_name like('%alzheimer%') "

#Connect to the live AACT database
# if you do not have your own credentials, you can create an account here:https://aact.ctti-clinicaltrials.org/users/sign_up

#con <- dbConnect(drv, dbname="aact",host="aact-db.ctti-clinicaltrials.org", port=5432, user=("sign up/in to get a username"), password="'your AACT password' ")

#!!! Please sign up and use your own username!!!
con <- dbConnect(drv, dbname="aact",host="aact-prod.cr4nrslb1lw7.us-east-1.rds.amazonaws.com", port=5432, user="rebekahgriesenauer", password="crib_aact")

#get query results using the SQL based query string
aact_sample <- dbGetQuery(con, query_string)

#write the output to a .csv
write.csv(aact_sample, file='aact_sample.csv')

#display results
print(aact_sample)
