**How to Participate (Note from Matt’s Email):**

- Identify any area or process where manual labor (i.e. toil) can be automated or streamlined to reduce labor required and/or improve speed to market
- Deliver on actual implementation of technology and/or process to achieve the reduction/improved speed to market
- Provide an overview of your accomplishment by Jan 11th to include
  - What the opportunity you identified was
  - Why you believed it was an opportunity
  - What solution you came up with and why
  - How you implemented the solution
  - Tangible evidence of the outcome


**Process Identified:**

Azure charges its customers for Cosmos DB (a type of No-SQL database) based on the Request Unit (or RU) consumption, there is no easy way to view/report on assigned RUs for each collection in the Cosmos DB. The previous procedure involved logging in to Azure portal manually, and finding each Cosmos DB database, and then drilling down to the collection level in each database and viewing the RU Throughput Setting. 

We checked with Microsoft, other third-party tools and CarMax Application teams regarding finding the Cosmos DB setting and were advised it is hidden and it is a cumbersome and manual process to retrieve the Throughput value and report.  

This is toil for the Operations team as someone must manually check the values regularly (once a week) and reach out to application teams to update it. 



**HCS believes it is an opportunity because:**


The HCS team does not see a business need for a Cosmos DB collection to have more than the default 400 RUs in Non-Production (DEV, QA and SBX); other than for doing performance testing or any sizeable load transactions.  For any Non-Prod databases that need more than 400 RUs, an exception can be requested by adding a tag value to the database.

There is a significant cost savings in monitoring and associating the right RU Throughput to the Azure Cosmos DB collections. 

Azure charges customers about $6 per 100 RU per month. Reducing the RU Throughput value from 1,000 RUs (default in many application teams’ deployment) to 400 RUs is savings of $420 annually per database collection. 

As of 12/19/2018, There were 115 **NON-PROD** Cosmos DB collections with more than default 400 RU Throughput limit, varying from 500 RUs to 25,000 RUs. Most of them at 1,000 RUs.  The overall estimated cost savings annually by reducing the Cosmos DB RUs to 400 in Non-Prod is about $120,000




**HCS solution for the opportunity (What, Why and How):**

HCS Team has worked on two scripts using Azure “AZ Cli “

1. Script1 -  Reports back the RU Throughput value of each Cosmos DB collection. Script accesses Azure through AZ Cli and finds all the Cosmos DB collections in each Azure subscription. For each Cosmos DB collection, it generates a text file with name, location of the database, owner and application team information along with Throughput value.

1. Script2 –  Once we get the buy in from application teams to let us scale down their Cosmos DB Throughput settings in Azure; this script will lower the RU limit on Cosmos DB collections without manual intervention from application teams. This script works based on a tag value associated with the Cosmos DB collection. The app teams are requested to append a tag to their Cosmos DB resource that sets the RU limit on the Cosmos DB account. The script would run regularly and check the tag on the resource to see if it matches the RU limits of the containers in the account, if the tag does not exist, the script updates the RU limit to default 400. If the tag exists and does not match the value, it will update the Throughput Value to match the tag.


Currently, the scripts are invoked from HCS team desktops, the idea is to upload them to git hub, configure them to run as a Team City job regularly and notify/email the teams with more than default 400 RUs about their settings and potential savings.

The scripts have lot of potential for growth, similar procedure and scripts are currently used for notifying application teams about their ownership and support as part of the quarterly audit. This can be extended to check/notify settings on other resources in Azure such as App service, Functions, SQL database, IP Restrictions and many more.

This solution will reduce the Toil for HCS and application teams. There is significant cost savings with reduced charges for Cosmos DB in Azure and not to ignore the hidden cost savings of regular manual checks.

`	`The scripts are located on GitHub at:



Script1 – To report the through put limits: <https://github.carmax.com/CarMax/hcs-ezpaas/blob/master/scripts/gatherrulimits.ps1> 

Script2 – To set the limits:

` `https://github.carmax.com/CarMax/hcs-ezpaas/blob/master/scripts/cosmosdbrusmultsubs.ps1


**Tangible evidence of the outcome:**

1. **Time Savings**

It takes about 2 minutes to get RU information from each collection. There about 260 Cosmos DB collections in Azure NonProd, of which 115 had more than 400 RU settings. To get the RU information manually on all collections effort estimate is about 9 hours.  

\1.	That is nine hours per week for HCS for retrieving the information

\2.	Then four hours or more for Application teams and update the values

\3.	Time to manage/update spreadsheets with the RU information about 1-2 hours per week.

This is an estimate of 16 hours per week of time savings. This value does not include the distractions and Azure portal lag and other delays.

1. **Cost Savings**

Currently, script1 is executed and application team owners~~,~~ and Lead Developers are already notified about the RU settings on their Cosmos DBs and the potential savings.  Tech Ops, BUYS, Recruiting Systems and SELLS Team have already reduced the Throughput settings to reduce the costs. SEARCHES and Online Systems teams are looking at their settings. HCS team has reached out to Online Systems and SEARCHES team managers for CarMax Master settings.



As of 01/08/2019, There are 81 **NON-PROD** Cosmos DB collections with more than default 400 RU Throughput limit and all of them are in CarMax Master, which is 34 fewer from original 115 as of 12/19/2018.   The overall estimated cost savings achieved annually so far with this effort is about $42,000 and has potential to save about $120,000 after Cosmos DB collections in CarMax Master are updated.


CarMax Internal Use Only

CarMax Internal Use Only
