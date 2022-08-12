# Azure Virtual Machine (VM) - Operational Level Agreement (OLA) Summary

## Purpose

The purpose of this document is to provide a summarized version of the operational level agreement (OLA) between different teams working within our cloud environment (Azure). For more information on the details on these OLAs, refer to: [Azure VM OLA Document](/AzureVMs/azvmola.md). For more information on Azure VMs, please refer to: [Azure VM Reference Information](/AzureVMs/azvmreferenceinfo.md)

There are 2 operational levels for VMs in Azure (Gold & Silver). Details for each of these are below.

## Gold Level (Operations Managed)

Within the gold operational level, application teams assume a similar level of responsibility and risk as they would if their VM were running on-premises.

### Gold - VM Build & Deployment

The VM is built and deployed by a member of the Enterprise Public Cloud Delivery or Reliability team.

### Gold - Backup/Restore

Backups are configured and maintained by the Enterprise Public Cloud Reliability team using a centrally managed backup vault with a 14-day retention policy.

### Gold - Maintenance & Updates

- The Enterprise Public Cloud Reliability team own the day to day administration and maintenance of these systems.
- The Enterprise Public Cloud Reliability team is responsible for configuration management of the CarMax technology standard software that needs to be installed within our environment.
- The Hosting and Compute Operations (HCO) team will install Windows patches on a monthly basis for Windows servers that are joined to the kmx.local domain.
- Network Security Group (NSG) Rules may need to be updated to enable the administration and/or maintenance of these standard software applications.

### Gold - Monitoring & Alerting

Alerting is configured and sends tickets on these systems to the Enterprise Cloud Reliability Team Service Now queue.
For additional information regarding alerting metrics, refer to [Monitoring & Alerting Standards](/AzureVMs/azmonitoringstandards.md)

## Silver Level (Non-Operations Managed)

Within the silver operational level, the application team is taking on a greater level of responsibility and with that assumes more risk within their environment.

### Silver - VM Build & Deployment

- The VM, NSGs and other Azure resources are built and deployed by a member of the application team.

### Silver - Backup/Restore

Backups are configured and maintained by the application team.

### Silver - Maintenance & Updates

- The application team is responsible for all aspects of managing, maintaining and updating VMs in their environment.

- This includes the following areas:

  - Azure RBAC Permissions
  - NSG Updates
  - Day to Day Administration
  - Configuration Management
    - Software - Includes adding, removing or updating.
    - Updates - This includes all VMs other than Windows (KMX.LOCAL) domain joined servers.

- Windows (KMX.LOCAL) Domain Joined Servers Details
  - The Hosting and Compute Operations (HCO) team will install Windows patches on a monthly basis for Windows servers that are joined to the kmx.local domain, however, it is the responsibility of the application team to test these patches and report any problems. [WSUS Details](/AzureVMs/azvmwsus.md)
  - The HCO team will centrally manage any kmx.local domain joined Windows server VM using Active Directory (AD) Group Policy Objects (GPO). [GPO Details](/AzureVMs/azvmgrouppolicy.md)

### Silver - Monitoring & Alerting

- Monitoring and alerting is configured by the application team.

## Final Notes

The communication and maintenance of the specific service level for each of these VMs can be maintained using tags on the Azure VMs. If no tags exist, then the virtual machine will be supported as a Silver operational level system.

### OLA Tags

    ‘tag.key’ = ‘opslevel’
    ‘tag.value’ = 'opsmanaged' or 'nonopsmanaged'
