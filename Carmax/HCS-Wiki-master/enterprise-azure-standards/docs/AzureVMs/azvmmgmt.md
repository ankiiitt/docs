# Azure Virtual Machine (VM) - Operational Management Strategy

## Overview

The purpose of this document is to provide details on the operational management strategy between different teams working within our cloud environment (Azure) and the Public Cloud Platform team. Our goal is to bring greater clarity and simplicity in the overall administration of Windows and Linux VMs within Azure while also enabling the teams to move quickly and focus on the areas that are most important to them.

As CarMax moves into the world of DEVOPs it is important for application teams to adopt the mindset of managing what they build. If management comes to an agreement the Public Cloud Platform team will assistant with operational management of VMs, however the preferred model is for teams to manage it themselves. 

## Reference Information for All Azure VMs

Because our Azure environment is shared among multiple teams and departments, there are some platform related services that are common to all applications which utilize VMs in Azure.

The following link contains information applicable to all VMs deployed in Azure. [Azure VM Reference Information](/AzureVMs/azvmreferenceinfo.md)

## Application Team Managed (Preferred Model)

Within the application team management model the application team takes on full responsibility for their environment. The application team is given permissions within the resource group or their own subscription which allows them the ability to create and delete resources. The application team maybe still have to partner with the BTAC - Vulnerability Management and Information Security teams as needed to maintain the VMs in their environment. In addition if new VNETs are required in a new application subscription will require work completed by the Public Cloud Platform team.

### VM Build & Deployment

- The VM is built and deployed by a member of the application team.
- The VM ARM template files, parameter files and associated scripts used for the VM deployment is setup and maintained by the application team and should be saved in a GitHub repository that the application team owns.
- NSGs are created and maintained by the application teams using an ARM template during the deployment process.

### Backup/Restore

Backups are configured and maintained by the application team.

### Maintenance & Updates

- The application team is responsible for all aspects of managing, maintaining and updating VMs in their environment.

- This includes the following areas:
  - Permissions - The application team is responsible for any Role Based Access Control (RBAC) updates.
  - The application team will own the day to day administration and maintenance of these systems.
  - The application team is responsible for configuration management of the CarMax technology standard software that needs to be installed & configured within our environment. The information security operations team will partner with the application team as needed.
  - The BTAC - Vulnerability Management team will install Windows patches on a monthly basis for Windows servers that are joined to the kmx.local domain using Windows Server Update Services (WSUS).
    - It is the responsibility of the application team to test these patches and report any problems and respond to IST if patches have fallen behind schedule. 
    - For additional information regarding Windows Server patching using WSUS, refer to: [WSUS Details](/AzureVMs/azvmwsus.md).
  - The BTAC - Vulnerability Management team will centrally manage any kmx.local domain joined Windows server VM using Active Directory (AD) Group Policy Objects (GPO).
    - For additional information regarding GPOs, refer to: [GPO Details](/AzureVMs/azvmgrouppolicy.md).
  - For any non-Windows systems, Windows workstations, or non-domain joined Windows servers, the BTAC - Vulnerability Management team will not centrally patch any of these VMs and it shall be the responsibility of the application team to manage Windows updates. 


### Monitoring & Alerting

- Monitoring and alerting is configured by the application team.
- Teams may decide to setup their own Log Analytics workspace; however, the centrally managed workspace is recommended.

## Public Cloud Managed

The Public Cloud Platform team manages a handful of VM's for applications that we support and for teams that we have established resources to provide DevOps support - Team City, Active Directory, CPS, eDOC's and a handful of others. We partner closely with the application team to manage these VM's. If you need assistance building deploying or managing your VM's and want to partner with the team please submit a request on https://hcsportal.carmax.com.

### VM Build & Deployment

The VM is built and deployed by a member of the Public Cloud Platform team.

- The deployment is performed using the standard Azure Resource Manager (ARM) template via Team City.
- The ARM template and parameters files related to this build needs to exist in an Enterprise GitHub repository.

### Backup/Restore

Backups are configured and maintained by the Public Cloud Platform team using a centrally managed backup vault with a 14-day retention policy.

### Maintenance & Updates

- The Public Cloud Platform team own the day to day administration and maintenance of these systems.
- The Public Cloud Platform team is responsible for configuration management of the CarMax technology standard software that needs to be installed within our environment.
- Network Security Group (NSG) Rules may need to be updated to enable the administration and/or maintenance of these standard software applications.
  - These NSG rules can be updated by the Public Cloud Platform team or the application team.
  - Any modifications made to an NSG rule need to be added to the ARM template code.
- The BTAC - Vulnerability Management team will install Windows patches on a monthly basis for Windows servers that are joined to the kmx.local domain using Windows Server Update Services (WSUS).
  - For additional information regarding Windows Server Patching using WSUS, refer to: [WSUS Details](/AzureVMs/azvmwsus.md).
- The Public Cloud Platform team will centrally manage any kmx.local domain joined Windows server VM using Active Directory (AD) Group Policy Objects (GPO).
  - For additional information regarding GPOs, refer to: [GPO Details](/AzureVMs/azvmgrouppolicy.md).

### Monitoring & Alerting

Alerting is configured and sends tickets on these systems to the Enterprise Cloud Reliability Team Service Now queue.
For additional information regarding alerting metrics, refer to [Monitoring & Alerting Standards](/AzureVMs/azmonitoringstandards.md)


## Final Notes

The communication and maintenance of the specific service level for each of these VMs can be maintained using tags on the Azure VMs. If no tags exist, then the virtual machine will be supported as a Silver operational level system.

### Public Cloud Management Tags

For VMs currently management by the Public Cloud Platform team an Azure tag exists on the VM labeled PublicCloudManaged with a value of True. This tag currently does not exist on any other VM in the Azure environment.

Below is a link to a Splunk dashboard with a breakdown of all Azure VMs and those that are managed by the Public Cloud Platform team. 

https://search.splunk.carmax.org/en-US/app/search/azure__vms_managed_by_public_cloud

### Exceptions

If an exception is needed regarding any Azure VM(s) that doesn’t fit into one of the above OLAs, this exception needs to be documented and communicated between the following teams:

- Application team
- Public Cloud Platform team
- Information Security team