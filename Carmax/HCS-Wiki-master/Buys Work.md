**What have we done So far:**



Team City Build Agents :

So far, we have built them four Team city Build agents 

- **TCAGTBD31** - This is the first agent we have built connected to ci.carmax.org in Appdelivery2 nonprod Subscription under kmx-dev-east-buys-teamcityagent resource group. (The license for this agent has been deprovisioned and currently the VM is been turned off).
- **BUYTCAPPP31, BUYTCAPPP32, BUYTCAPPP33** – These are the current active agents that are being used by Buys teams for their deployments and are connected to ci2.carmax.com. These VMs are under kmx-prod-east-buys-teamcityagent resource group in Appdelivery 2 prod Subscription.

The code to build these agents are stored under 

<https://github.carmax.com/CarMax/hcs-azure-projects/tree/master/Buys/TeamcityAgent>

The service account under which these agents run is *svcBuysdevBuild1* for TCAGTBD31 and 

svcBuysProdBuild1 for BUYTCAPPP31, BUYTCAPPP32, BUYTCAPPP33. Password for these accounts are stored in keepass under service accounts.

# **Resource Groups and SPO’s:**

Within the buys team there are three other teams called Buys Explorers, Buys Catalysts, Buys Experience, altogether manages 11 services (This count doesn’t include the recent request we have from them) so far in azure. Below mentioned are the specific details of each teams and their services.

## Buys Explorers:  

KMX-AD-G-AZURE-BuysExplorers-Developer, KMX-AD-G-AZURE-BuysExplorers-Architects are the AAD groups for the team and the tags values are 

Team Name :  buysexplorers;

Owner:  <Lee_Morris@carmax.com>

Contact:  OPExplorers@carmax.com 

Services owned by Explorers: Buys-Credit, Buys- Vehicleorder, Buys-opinfrastructure . Buys-credit and Buys-vehicleorder services has resource groups deployed in East, West, Central Region in DEV, QA, Prod Environments. Buys-Opinfrastructure service has resource groups deployed only in Central region in DEV, QA, PROD environments.

Each service has SPO associated to it in DEV, QA, Prod environments. All the SPO password Wrapper certificates are currently pushed on to the three build agents in prod and can be find under buys folder under Azure SPO Password Encryption certificates in Venafi.

## Busy Catalysts:

KMX-AD-G-AZURE-BuysCatalyst-Developers, KMX-AD-G-AZURE-Buys Catalyst-Developers are the AAD groups for the catalyst team and the tag values are: 

Team Name :  buysexplorers;

Owner:  <Lee_Morris@carmax.com>

Contact:  opcatalyst@carmax.com

Services owned by Catalyst: Busy-accessory, Buys-customer, Buys-vehicle, Buys-gap, Buys-tafe, Buys-maxcare, Buys-registration. All these services have resource groups deployed in East, West, Central Region in DEV, QA, Prod environments. 

Each service has SPO associated to it in DEV, QA, Prod environments. All the SPO password Wrapper certificates are currently pushed on to the three build agents in prod and can be find under buys folder under Azure SPO Password Encryption certificates in Venafi.

## KMX-Key vault Contributor role assignment to all Buys SPO’s:


All the buys services have the wildcard SSL cert per environment that is store in a shared key vault where all the buys SPO’s would have a custom role KMX-Keyvaultcontributor role assigned to it at management level. Below mentioned are the key vault names per environment



**Key Vault Name**                                   **Resource Group Name** 

buysshared-dev-keyvault            kmx-dev-central-buys-opinfrastructure-shared

buysshared-qa-keyvault                 kmx-qa-central-buys-opinfrastructure-shared

buysshared-prod-keyvault          kmx-prod-central-buys-opinfrastructure-shared



` `**Rename Certs:**

Credit-integration-client-dev-qa   => Integration-client-dev-qa

creditservice-monitor-client => Service-monitor-client

IAM Roles Assignments for all Buys Resource groups:


- All the nonprod resource groups have their respective team Developers and Architects AAD groups Contributor Access at resource group level.
- All the nonprod and prod resource groups have their corresponding SPO’s Contributor access at resource group level.
- All the prod resource groups have their respective teams Developers Group Reader access and Architects Group Contributor access at resource groups level.
- KMX-AD-G-AZURE-Buys-ReadOnlyusers has the Reader access to all the resource groups that we have for Buys in all environments.
- KMX-AD-G-AZURE-BuysExplorers-Developers, KMX-AD-G-AZURE-BuysExplorers-Architects groups has Reader access to all the resource groups that Catalyst Owns in all Environments.
- KMX-AD-G-AZURE-BuysCatalyst-Developers, KMX-AD-G-AZURE-BuysCatalyst-Architects groups has Reader access to all the resource groups that Explorers owns in all Environments.

Client Certificates information for buys Services:

Over the period there are many things that got changed with the way Buys operates with client certificates. The certificate names have been changed and some of them were revoked. But below mentioned are the current client certificates for the services buys manage.

The client certs used by credit, customer,vehicle order needs to be pushed on to the corresponding key vaults in azure. We can look at the keyvault name on to which the certificate is being pushed in Venafi.(Make sure the certificate is being pushed on to the key vaults with private key exportable.)

BuysDeveloper-dev-qa, Integration-client-dev-qa, Service-monitor-client are the client certs that needs to be pushed on to the agent under personal certs of team city service account.  Recently there are some changes in client certificates names as shown below. But the old ones are not deleted from the agents since some of the buys deployments still looking for the old certificates and failing their builds.

` `**Rename Certs:**

Credit-integration-client-dev-qa   => Integration-client-dev-qa

creditservice-monitor-client => Service-monitor-client




Current Active client certificates


![](./images/buyscertrename.png)





Server certificates information for buys Service:

*BuysConfigEncryption, BuysCreditEncryption, BuysCreditEncryption-dev-qa* are the three server certificates that needs to be pushed on to all the three agents. They use these certificates for encrypting the data of some of their services.

**Issues/ Trouble shooting for Buys:**

Over the past three months, buys teams had come across many deployment issues from infrastructure level and build level. But, Since their platform is now setup completely and their developers had much better knowledge with the resources in Azure, The issues have been reduced over a period of time.  I can talk more about these in our meeting. This is so far what I can recollect but surely there must be some minor details/information which I might miss to include in this document but feel free to reach out to me for any other clarifications.

