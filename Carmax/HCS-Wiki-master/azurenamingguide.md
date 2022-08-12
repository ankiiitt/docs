# Enterprise Azure Naming Guide

There are various resource types within Azure that will be used in order to stand up the infrastructure used at CarMax. Below is a guide regarding how resources should be named in order to maintain consistency across different groups who want to utilize Azure to host their application.

Online Systems Naming standards can be found at: https://github.carmax.com/pages/CarMax/platform-reference/reference/azure-resource-naming-guide/


## Resource Groups

#### Overview:
One item of distinction that is worth mentioning is the fact that some resources are shared and some are non-shared. The resource group should indicate if it is being used as a shared resource between multiple regions. Shared resources are meant to contain highly-available, geographically distributed resources.  Examples of this would include Traffic Manager, DocumentDB, App Insights, or any other resource group used for PaaS resources.  Since these shared resources are initially created within a specific region, the region should be identified in the name.

#### Format:
    kmx-{env}-{region}-{app or service name}
    kmx-{env}-{region}-{app / service / bounded context}-{shared}

    With product vertical in the name:
    kmx-{env}-{region}-{productVertical}-{app or service name}
    kmx-{env}-{region}-{productVertical}-{app / service / bounded context}-{shared}

#### Examples:
    kmx-dev-west-teamcity
    kmx-dev-central-appraisalstoreconfig-shared
    kmx-dev-west-buys-teamcity
    kmx-dev-central-buys-appraisalstoreconfig-shared

## Application Insights

#### Overview
This service is currently only available in East US and South Central US data centers, therefore, the resource group for this resource will need to be created in one of those regions.

#### Format:
    {servicename}-{env}-insights

#### Examples:
    storeconfig-dev-insights

## Application Gateway

#### Format:
    {servicename}-{env}-{region}-appgateway

#### Example:
    cafalfa-dev-east-appgateway
    cafalfa-prod-east-appgateway

## App Registrations (Application Name when creating an Application ID)

#### Overview:
This value is used within Azure AD to create a new App registration.  App registrations are used for authentication into Azure for specific applications and application teams.  There are two aspects of the creation of these items in order to allow the proper level of authentication (automation and application accounts). These are also known as SPOs or Service Principals.

#### Format:
    http://{app or service name}{env}Automation.com
    http://{app or service name}{env}Application.com

#### Example:
    http://CarmaxcomProdApplication.com
    http://CarmaxcomProdAutomation.com

## App Service Plans

#### Overview:
App Services are generally thought of as either a “gateway” or a “service”:
1. Gateways are meant for external consumption, either another CarMax team or a 3rd party vendors.
2. Services are meant for internal consumption - the idea is that these contracts could iterate more rapidly since we have more control over the clients. There are various types of app service plans including gateways, APIs, websites, service plans, and functions.  When these resources are created, they get .azurewebsites.net added to the end of the name to form the URL.

#### Format:
    {servicename}-{env}-{region}-{type}-{version for v2 and up}

#### Example:
    webvehicle-qa-eastus-plan
	finance-dev-east-gateway
	images-dev-east-functions
	mediacapture-qa-west-website

## CosmosDB

#### Format:
    {servicename}-{env}-docdb

#### Examples:
    webvehicle-qa-docdb

## ExpressRoute Circuit

#### Format:
    expressroute-{region}-circuit

#### Examples:
    expressroute-eastus-circuit

## Functions

#### Format:
    {servicename}-{env}-{region}-functions

#### Examples:
    webvehicle-qa-east-functions

## KeyVault

#### Format:
    {app or service name}-{env}-{region}-{type}

#### Example:
    webvehicle-dev-east-vault

## OMS Log Analytics

#### Overview:
This name should be kept short as "portal.mms.microsoft.com" gets put onto the end of the name when creating the OMS portal.  Shared in the name indicates that this resource is being utilized by resources in multiple regions.

#### Format:
    kmx-{env}-{region or shared}

#### Example:
    kmx-dev-east
    kmx-prod-shared

## Network Security Group (NSG)

#### Format:
    {app or service name}-{prod or nonprod}-{region}-nsg

#### Example:
    activedirectory-nonprod-eastus-nsg
    infosec-utilities-prod-westus-nsg

## Recovery Services Vault (Backups)

#### Format:
    {team name}-{prod or nonprod}-{region}-backupvault

#### Example:
    es-nonprod-east-backupvault
    cafalfa-nonprod-west-backupvault

## RBAC Role (Custom)

#### Format:
    kmx{group_descriptive_name}

#### Example:
    kmx-dbapowerusers
    kmx-dashboardpublish

## Route Table

#### Format:
    {team}-{prod or nonprod}-{region}-routetable

#### Examples:
    itops-nonprod-eastus-routetable
    appdelivery2-prod-westus-routetable

## SendGrid Account (Email Delivery)

#### Format:
    {servicename}-{env}-{type}

#### Example:
    webvehicle-qa-sendgrid

## Storage Accounts

#### Overview:
There are different types of storage available within Azure including file, table, and blob storage. The storage resource names are constrained in length and characters, which is where the following standards come from.  There is a limit of 24 characters for this name.

#### Format:
    {8-character servicename}{env}{region}{type}

#### Example:
    teamcityqaeaststorage
    appraisalqawestlogs
    cafalfaprodweststorage

## SQL Database

#### Format:
    {app or service name}-{env}-{region or shared}-sqldb

#### Example:
    teamcity-dev-east-sqldb
    appraisal-dev-shared-sqldb

## SQL Server

#### Format:
    {app or service name}-{env}-{region or shared}-sqlsvr

#### Example:
    teamcity-dev-east-sqlsvr
    appraisal-dev-shared-sqlsvr

## Subscription Names

#### Format:
    Department Name Production Subscription
    Department Name Non Production Subscription

#### Example:
    AppDelivery 1 Production Subscription
    IT Operations Non-production Subscription

## Traffic Manager

### Overview:
The Traffic Manager service adds .trafficmanager.net to the DNS name, therefore keeping this name short is best.

#### Format:
    {service-name}-{env. if not prod}

#### Examples:
    storeconfig-dev
    webvehicle-qa
    finance

## User Defined Routes (UDR)

#### Overview:
UDRs are used to define specific routes within Azure.  They can be applied to a NIC or a Subnet.  They are defined within a Route Table.

#### Format:
    {Source App Group}-{Prod or NonProd}-{Source Region}-TO-{Destination Location}-{Destination Subnet Description}

#### Examples:
    Infrashared-NonProd-West-TO-WC-VDI
    Infrashared-Prod-East-TO-Pit-AD
    ASAv-NonProd-East-TO-AZ-East-AD

## Virtual Machines

#### Overview:
Virtual Machines will use the naming convention standard that already exists which is found in the following wiki:  [server_host_names](https://eskb.carmax.org/doku.php?id=server_host_names)

#### Format:
    {Owning Team code}{System Code}{Role Code}{env code P/Q/D/T}{Azure location code 3(East) or 4(West)}{system #}

#### Example:
    CAFALFWEBD31
    (Car Max Auto Finance Alfa System Web Server Dev in East Azure datacenter – 1st server in series)

## Virtual Networks (vnets)

#### Overview:
Vnets can be associated with a specific application or they may be shared.

#### Format:
    kmx-{app or service name}-{env}-{region or shared}-vnet

#### Example:
    kmx-webvehicle-dev-eastus-vnet
	kmx-infrastructure-dev-eastus-shared-vnet

## Virtual Network Subnet

#### Overview:
Subnets are configured within vnets with the following naming details.

#### Format:
    {app or service name}-{env}-{region}-subnet-{subnet tier}

#### Example:
    webvehicle-dev-eastus-subnet-web

## Virtual Network Gateway

#### Format:
    {application}-{prod or nonprod}-{region}-{type of gateway ergw or vpngw}

#### Examples:
    infrastructure-prod-eastus-ergw
    itops-nonprod-westus-vpngw

## Web API

#### Format:
    {servicename}-{env}-{region}-api

#### Examples:
    storeconfig-dev-east-api
