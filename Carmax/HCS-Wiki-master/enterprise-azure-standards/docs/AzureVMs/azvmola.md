# Azure Virtual Machine (VM) - Operational Level Agreement (OLA)

## Purpose

The purpose of this document is to clarify the operational level agreement (OLA) between different teams working within our cloud environment (Azure). Our goal is to bring greater clarity and simplicity in the overall administration of Windows and Linux VMs within Azure while also enabling the teams to move quickly and focus on the areas that are most important to them.

A summarized version of this document can be found: [Azure VM OLA Summary Document](/AzureVMs/azvmolasummary.md)

An OLA defines the interdependent relationships in support of a service-level agreement (SLA). The agreement describes the responsibilities of each internal support group toward other support groups, including the process and timeframe for delivery of their services. The objective of the OLA is to present a clear, concise and measurable description of the service provider's internal support relationships.

We currently define the level of support for any VM in Azure through a RACI document which is captured during the initial intake. There is currently a range of how much teams are responsible for the VMs in their environment. Some teams take on more ownership than others based on a variety of factors. The intent of the below information is to provide greater clarity of the level of support provided by the various teams.

There are 2 operational levels for VMs in Azure (Gold & Silver). Details for each of these are below.

## Reference Information for All Azure VMs

Because our Azure environment is shared amoung multiple teams and departments, there are some platform related services that are common to all applications which utilize VMs in Azure.

The following link contains information applicable to all VMs deployed in Azure. [Azure VM Reference Information](/AzureVMs/azvmreferenceinfo.md)

## Gold Level (Operations Managed)

Within the gold operational level, application teams assume a similar level of responsibility and risk as they would if their VM were running on-premises. The application teams are granted resource group access and can make updates in their VM along with any other resources within their resource group. The application team should only be making changes on these systems that are related to their application. If any changes need to be made to these systems other than application related, they need to communicate with a member of the Enterprise Public Cloud Reliability or Delivery teams so that any code related to their environment is up to date. Due to these requirements, the application team should be granted just enough access within their resource group to perform limited administration and maintenance of the resources within their resource group.

Below are the items that are specific to the Gold OLA.

### Gold - VM Build & Deployment

The VM is built and deployed by a member of the Enterprise Public Cloud Delivery or Reliability team.

- The deployment is performed using the standard Azure Resource Manager (ARM) template via Team City.
- The ARM template and parameters files related to this build needs to exist in an Enterprise GitHub repository.

### Gold - Backup/Restore

Backups are configured and maintained by the Enterprise Public Cloud Reliability team using a centrally managed backup vault with a 14-day retention policy.

### Gold - Maintenance & Updates

- The Enterprise Public Cloud Reliability team own the day to day administration and maintenance of these systems.
- The Enterprise Public Cloud Reliability team is responsible for configuration management of the CarMax technology standard software that needs to be installed within our environment.
- Network Security Group (NSG) Rules may need to be updated to enable the administration and/or maintenance of these standard software applications.
  - These NSG rules can be updated by the Enterprise Public Cloud Reliability team or the application team.
  - Any modifications made to an NSG rule need to be added to the ARM template code.
- The Hosting and Compute Operations (HCO) team will install Windows patches on a monthly basis for Windows servers that are joined to the kmx.local domain using Windows Server Update Services (WSUS).
  - For additional information regarding Windows Server Patrhing using WSUS, refer to: [WSUS Details](/AzureVMs/azvmwsus.md).
- The HCO team will centrally manage any kmx.local domain joined Windows server VM using Active Directory (AD) Group Policy Objects (GPO).
  - For additional information regarding GPOs, refer to: [GPO Details](/AzureVMs/azvmgrouppolicy.md).

### Gold - Monitoring & Alerting

Alerting is configured and sends tickets on these systems to the Enterprise Cloud Reliability Team Service Now queue.
For additional information regarding alerting metrics, refer to [Monitoring & Alerting Standards](/AzureVMs/azmonitoringstandards.md)

## Silver Level (Non-Operations Managed)

Within the silver operational level, the application team is taking on a greater level of responsibility and with that assumes more risk within their environment. The application team is given permissions within the resource group which allows them the ability to create and delete resources. The application team can still partner with the Enterprise Public Cloud Delivery/Reliability teams and/or the Information Security team as needed to maintain the VMs in their environment.

The following items are specific to the Silver level OLA:

### Silver - VM Build & Deployment

- The VM is built and deployed by a member of the application team.
- The VM ARM template files, parameter files and associated scripts used for the VM deployment is setup and maintained by the application team and should be saved in a GitHub repository that the application team owns.
- NSGs are created and maintained by the application teams using an ARM template during the deployment process.
- Any changes to the application team environment needs to be created in code and saved within their GitHub repository.

### Silver - Backup/Restore

Backups are configured and maintained by the application team.

### Silver - Maintenance & Updates

- The application team is responsible for all aspects of managing, maintaining and updating VMs in their environment.

- This includes the following areas:
  - Permissions - The application team is responsible for any Role Based Access Control (RBAC) updates.
  - The application team will own the day to day administration and maintenance of these systems.
  - The application team is responsible for configuration management of the CarMax technology standard software that needs to be installed & configured within our environment. The information security operations team will partner with the application team as needed.
  - The Hosting and Compute Operations (HCO) team will install Windows patches on a monthly basis for Windows servers that are joined to the kmx.local domain using Windows Server Update Services (WSUS).
    - It is the responsibility of the application team to test these patches and report any problems.
    - For additional information regarding Windows Server Patrhing using WSUS, refer to: [WSUS Details](/AzureVMs/azvmwsus.md).
  - For any non-Windows systems, Windows workstations, or non-domain joined Windows servers, the HCO team will not centrally patch any of these VMs.
  - The HCO team will centrally manage any kmx.local domain joined Windows server VM using Active Directory (AD) Group Policy Objects (GPO).
    - For additional information regarding GPOs, refer to: [GPO Details](/AzureVMs/azvmgrouppolicy.md).

### Silver - Monitoring & Alerting

- Monitoring and alerting is configured by the application team.
- Teams may decide to setup their own Log Analytics workspace; however, the centrally managed workspace is recommended.

## Final Notes

The communication and maintenance of the specific service level for each of these VMs can be maintained using tags on the Azure VMs. If no tags exist, then the virtual machine will be supported as a Silver operational level system.

### OLA Tags

    ‘tag.key’ = ‘opslevel’
    ‘tag.value’ = 'opsmanaged' or 'nonopsmanaged'

### OLA Exceptions

If an exception is needed regarding any Azure VM(s) that doesn’t fit into one of the above OLAs, this exception needs to be documented and communicated between the following teams:

- Application team
- Enterprise Public Cloud Delivery team
- Enterprise Public Cloud Reliability team
- Information Security team
