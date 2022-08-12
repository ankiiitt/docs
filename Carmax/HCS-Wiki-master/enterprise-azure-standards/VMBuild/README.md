# VMBuild Templates

The following folder contains a standardized template file (VM-Template.json) and parameters file (VM-Parameters.json) to deploy a VM in Azure. This templates correspond with Team City build jobs and will  will deploy or update the Resource Group, NSG, and the VM(s).  

The same template can be used for either prod or nonprod as well as either Windows or Linux.  In addition, this template will deploy 'x' number of VMs within an availability set in the same Resource Group. These values are defined within the parameters file.  When updating the parameters file, there are only a handful of parameters that need to be updated. They are all listed at the top of the parameters file. Below is a list of the parameters that should be reviewed prior to any VM Build:

location, RGName, platform, environment, vmPrefixName, availabilitySetName, numberOfInstances, storageaccountname, virtualMachineSize, virtualNetworkName, subNetName, virtualNetworkResourceGroup, subnetName, virtualNetworkResourceGroup, sizeOfEachDataDiskInGB, ouPath, WinOSVersion, & RHELVersion.

## Windows VM Details:

If you want to deploy a single or multiple Windows VM(s), update the platform parameter to WinSrv. 

When this VM is deployed, the following will be part of the build: 
- Extensions: BGInfo, domainjoin, and custom script extension.

The custom script extension installs the following software on the VM when it is build:
- Crowdstrike, Nexpose, Splunk, Log Analyics (OMS) agent, and the Microsoft Dependency Agent.

In addition to this software, there are multiple configuration settings made to CarMax standard specifications when it is built.

To review this script in greater detail, refer to [CustomScriptExtension](https://github.carmax.com/CarMax/enterprise-azure-standards/tree/master/CustomScriptExtension/Windows)  This custom script extension is downloaded and run from a blob storage location defined in the ARM template. 

## Linux VM Details:

As mentioned previously, the same template and parameters file can be used for either Windows or Linux VMs. If you want to deploy a single or multiple Windows VM(s), update the platform parameter to Linux. 

When this VM is deployed, the following will be part of the build:
- Extensions: Log Analytics (OMS) Extension, Microsoft Dependency Agent, and the Linux custom script extension.
The custom script extension installs the following software when the VM is built:
- Crowdstrike, Nexpose, & Splunk

In addition, to this software, the system is configured to be part of the kmx.local domain as well as ensuring that the VM is built to the CarMax standard specifications. 

To review this script in greater detail, refer to [CustomScriptExtension](https://github.carmax.com/CarMax/enterprise-azure-standards/tree/master/CustomScriptExtension/Linux)  This custom script extension is downloaded and run from a blob storage location defined in the ARM template.  This script downloads and runs other scripts in a specific order.

## Team City Deployment Example

An example of these files used in a Team City job can be found:

[VM TeamCity Example](https://ci2.carmax.org/admin/editBuildRunners.html?id=buildType:EnterpriseSystems_HcoVmAdministration_SimpleVmDeployment)

The following items are covered as part of this Team City deployment job:

- NSG Created or updated based on standard rules.
- x VM(s) created and joined to the kmx.local domain using CarMax corporate standards.