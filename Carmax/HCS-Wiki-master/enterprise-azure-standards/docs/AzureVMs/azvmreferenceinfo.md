# Azure VM Reference Information

The following information is applicable to all VMs deployed within one of the Enterprise managed Azure subscriptions.

## Resource Group Creation

Performed by the Public Cloud Platform team or automated via the HCS portal – https://hcsportal.carmax.com/

- Role Based Access Control (RBAC) is configured at the resource group level.
- Tagging is initially configured upon creation of the resource group.

## Networking

- Virtual Networks and subnets are deployed and supported prior to the VM being built.
- Virtual Network peering is setup, maintained and supported by the Public Cloud Platform team.
- Express-route connectivity is supported by the Network Services team.
- FortiGate firewalls are maintained and supported by the Network Services team.

## VM Build & Deployment

- The Public Cloud Platform team will has a standard Azure Resource Manager (ARM) template that can be used as an example for VM deployments.
  - The standard VM ARM template is located: https://github.carmax.com/CarMax/enterprise-azure-standards/tree/master/VMBuild
  - Standard NSGs are: https://github.carmax.com/CarMax/enterprise-azure-standards/NSG

### VM Naming Standard

For more information on standard VM naming, go to [Standard VM Naming](/AzureVMs/azvmnaming.md)

### VM Software

The list of software that should be installed on VMs in Azure can be found here: [Standard Software on Azure VMs](/AzureVMs/azvmsoftwarestandard.md)

- All other software outside of the operating system, patches and the standards applications listed above is maintained by the application team.
- As these standards change over time, the Public Cloud Platform team will either update systems as needed or ensure that there is an automated process in place for the application team(s) to handle this.
- This including installing new agents that become part of the standard and/or removing software and agents that are no longer part of the standard.

### Domain Join

- Windows and Linux VMs need to be domain joined to the ‘kmx.local’ domain when they are built.
- If an Azure VM is not joined to the ‘kmx.local’ domain, then the VM will be considered as a Bronze system.

## Maintenance & Updates

- Domain joined Windows VM patching is managed by the BTAC - Vulnerability Management team using Windows Server Update Services (WSUS).
- Windows Active Directory (AD) group policy object (GPO) administration is managed by the HCO team.

## Audit & Compliance

The application team manager is responsible for the following audit and compliance tasks:

- Resource Group permissions
- Virtual Machine permissions (where applicable)
- Application permissions (where applicable)