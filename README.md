# Query ClinicalTrials.gov through AACT

ClinicalTrials.gov is a repository of clinical trial registrations in the United States and is maintained by the National Library of Medicine (NLM) at the National Institutes of Health (NIH) in collaboration with the Food and Drug Administration (FDA). The [AACT database](https://www.ctti-clinicaltrials.org/aact-database) or Aggregate Analysis of Clinical Trials database was developed and is maintained by the Clinical Trials Transformation Initiative (CTTI) group, a government-academic collaboration between the FDA and Duke University. The AACT database contains ClinicalTrials.gov data that has been parsed and deposited into a structured relational database. AACT also links clinical trials data to Medical Subject Headings (MeSH terms), a controlled vocabulary containing terms describing disease indications and interventions. This mapping enables querying the data by intervention and disease indication terms. AACT represents the data as it can be found in clinicaltrials.gov.

## query_clinicaltrials.R
This script will connect you to the AACT database. If you do not already have one, you will need to [make an account](:https://aact.ctti-clinicaltrials.org/users/sign_u) with AACT so that you can get connection credentials.

An example query is shared in the R script, but in order to customize it to your needs, you may want to reference the [Database Schema](https://aact.ctti-clinicaltrials.org/schema) and [Data Dictionary](https://aact.ctti-clinicaltrials.org/data_dictionary).

The script will return the results of a query as a dataframe and save the file in your working directory as "aact_sample.csv".

## Query Example Details
The Query example given in this script uses the following AACT tables:
1. browse_conditions: NLM uses an internal algorithm to assess the data entered for a study and creates a list of standard MeSH terms that describe the condition(s) being addressed by the clinical trial.  This table provides the results of NLM's assessment
2. conditions: Name(s) of the disease(s) or condition(s) studied in the clinical study, or the focus of the clinical study. Can include NLM's Medical Subject Heading (MeSH)-controlled vocabulary terms.
3. studies: Basic info about study, including study title, date study registered with ClinicalTrials.gov, date results first posted to ClinicalTrials.gov, dates for study start and completion, phase of study, enrollment status, planned or actual enrollment, number of study arms/groups, etc. (Note: Overall Recruitment Status *
Definition: The recruitment status for the clinical study as a whole, based upon the status of the individual sites. If at least one facility in a multi-site clinical study has an Individual Site Status of "Recruiting," then the Overall Recruitment Status for the study must be "Recruiting.")
4. overall_officials:People responsible for the overall scientific leadership of the protocol including the principal investigator.
5. facility_contacts: Contact information for people responsible for the study at each facility. (primary and backup)  Facility contact information is available if the facility status (Facilities.Status) is ‘Recruiting’ or ‘Not yet recruiting’, and if the data provider has provided such information. Contact information is removed from the publicly available content at ClinicalTrials.gov when the facility is no longer recruiting, or when the overall study status (Studies.Overall_status) changes to indicate that the study has completed recruitment.

## Other notes
The example query will return several rows with duplicate information (but each row will be unique if you look across all of the information in each row). You can apply a distinct filter on nct_id to get a list of unique trials. Running a distinct command on the dataframe returned by the query will also allow you to get distinct contact information or principal investigators.
