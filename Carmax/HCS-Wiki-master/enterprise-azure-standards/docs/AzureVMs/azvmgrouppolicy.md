# AD Group Policy Details for VMs in Azure

This document gives additional information regarding Group Policy Objects (GPOs) that are applied to Windows Servers that are joined to the kmx.local domain.

Windows Servers in Azure that are joined to the kmx.local domain are added to an OU located within either of these OUs:

- Prod: "OU=PROD,OU=Azure,OU=Servers,DC=KMX,DC=LOCAL"

- NonProd: "OU=NONPROD,OU=Azure,OU=Servers,DC=KMX,DC=LOCAL"

## GPO Details

Each of these OUs contain the following Group Policy configurations as part of our AD configuration.

In order for a team to gain information about any group policies that are assigned to their Windows Virtual Machines, perform the following steps:

1. Perform a Remote Desktop Connection (RDP) into the Windows Server user a user account on the kmx.local domain with local administrator privileges.

2. Open PowerShell as an Administrator and run the following command.

```
$FilePath = "C:\temp\gporeport.html"
Gpresult /h $FilePath /f
Start-process $FilePath

```

The results of this command will be a report similar to the following: [Group Policy Report](/images/gporeport.html)

## Exceptions

Any exceptions to this will need to be requested by the Hosting and Compute (HCO) Reliability Team.
