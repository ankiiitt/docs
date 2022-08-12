# Linux KMX.LOCAL Domain Join details

Below are the details to add a Linux VM to the kmx.local domain during the deployment of a VM.  There are a few prerequisites needed to facilitate this action.  

1. Access to the KMX-Azure.psm1 module.
2. A keyvault with secrets needed to join the domain within the same subscription and within the same region. Permissions need to be granted to the keyvault for a specific application team SPO.
3. ARM template code along with the appropriate parameters.
4. Linux Custom Script Extension with necessary steps to install & configure the components needed.

---
## 1. KMX-Azure PowerShell Module

Details regarding this module can be found at https://github.carmax.com/CarMax/es-kmx-azure-module
In order to use it, you will need to import the module using the following command:

```Import-Module C:\location\of\module\KMX-Azure.psm1```

This module is needed to perform the task of allowing a non-domain admin user the ability to create an AD computer object along with the DNS records (A & PTR).  

#The following script creates the AD computer object within the KMX.LOCAL domain.
```New-KMXADComputer -Vaultname $vaultname -OUPath "OU=PROD,OU=Azure,OU=Servers,DC=KMX,DC=LOCAL" -ComputerName $computerName -Verbose```

#The following script creates the DNS (A & PTR) Records for the VM that is being joined to the KMX.LOCAL domain.
```New-KMXDNSRecord -Vaultname $vaultname -IPAddress "10.xx.yy.zz" -ComputerName $computerName -Verbose```
 
This module is also used within the VM deployment to create the NSG, and deploy the VM.

---
## 2. Keyvault Details

The following keyvaults have been configured for each subscription which contain the necessary secrets to accomplish this task. All of the secrets for this have been added to these keyvaults.  Permissions for the SPO will be granted upon request.

| Subscription Name | Keyvault East| Keyvault West |
|-------------------|--------------|---------------|
| AppDelivery 1 Non Production | app1-nonprod-east-vault | app1-nonprod-west-vault |
| AppDelivery 1 Production | app1-prod-east-vault | app1-prod-west-vault |
| AppDelivery 2 Non Production | app2-nonprod-east-vault | app2-nonprod-west-vault |
| AppDelivery 2 Production | app2-prod-east-vault | app2-prod-west-vault |
| Application Shared Non Production | apps-nonprod-east-vault | apps-nonprod-west-vault |
| Application Shared Production | apps-nonprod-east-vault | apps-nonprod-west-vault |
| CAF Non Production | caf-nonprod-east-vault | caf-nonprod-west-vault |
| CAF Production | caf-prod-east-vault | caf-prod-west-vault |
| Information Security Non Production | sec-nonprod-east-vault | sec-nonprod-west-vault |
| Information Security Production | sec-prod-east-vault | sec-prod-west-vault |
| Infrastructure Shared Non Production | infra-nonprod-east-vault | infra-nonprod-west-vault |
| Infrastructure Shared Production | infra-prod-east-vault | infra-prod-west-vault |
| IT Operations Non Production | itops-nonprod-east-vault | itops-nonprod-west-vault |
| IT Operations Production | itops-prod-east-vault | itops-prod-west-vault |
| PCI Non Production | pci-nonprod-east-vault | pci-nonprod-west-vault |
| PCI Production | pci-prod-east-vault | pci-prod-west-vault |

---
## 3. ARM Template Details

The ARM templates which can be used as a starting point for deploying Linux domain joined systems that are added to the kmx.local domain can be found:
https://github.carmax.com/CarMax/enterprise-azure-standards/tree/master/VMBuild

---
## 4. Custom Script Extension Details

The Linux custom script extension is used to install the necessary packages and software on the VM during deployment.  This script is saved in the following locations:

https://github.carmax.com/CarMax/enterprise-azure-standards/blob/master/CustomScriptExtension/Linux/master.sh 

These custom scripts are referenced in the ARM templates mentioned above.