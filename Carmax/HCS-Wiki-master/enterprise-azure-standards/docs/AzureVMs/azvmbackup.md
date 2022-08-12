# VM Backup and Restore

## Backups
When configuring backups on a new VM, this can be done using a centrally managed recovery vault and policies.  


### Backup Policies

#### Persistent VMs
Currently a full vm snapshot is taken every day at 1:30 AM EST. These backups have a full backup of the VM which will be retained for 2 weeks. The policy also specifies an instant restore feature where the disks are backed up as well for an instant restore. These disks will only be retained for 2 days at a time. Each managed subscription contains a central resource group with two recovery vaults for east and west where the aformentioned backups are stored.

 Below are the details regarding these resource groups and recovery vaults per subscription:

| SubScriptionName | ResourceGroup | RecoveryVault | PolicyName | BackupTime |
|------------------|---------------|---------------|------------|------------|
| AppDelivery 1 Non Production Subscription | kmx-appdelivery1-nonprod-central-backup | appdelivery1-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 1 Non Production Subscription | kmx-appdelivery1-nonprod-central-backup | appdelivery1-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 1 Production Subscription | kmx-appdelivery1-prod-central-backup | appdelivery1-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 1 Production Subscription | kmx-appdelivery1-prod-central-backup | appdelivery1-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 2 Non Production Subscription | kmx-appdelivery2-nonprod-central-backup | appdelivery2-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 2 Non Production Subscription | kmx-appdelivery2-nonprod-central-backup | appdelivery2-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 2 Production Subscription | kmx-appdelivery2-prod-central-backup | appdelivery2-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| AppDelivery 2 Production Subscription | kmx-appdelivery2-prod-central-backup | appdelivery2-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| Application Shared Non Production Subscription | kmx-appshared-nonprod-central-backup | appshared-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| Application Shared Non Production Subscription | kmx-appshared-nonprod-central-backup | appshared-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| Application Shared Production Subscription | kmx-appshared-prod-central-backup | appshared-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| Application Shared Production Subscription | kmx-appshared-prod-central-backup | appshared-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| CAF Non Production Subscription | kmx-caf-nonprod-central-backup | caf-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| CAF Non Production Subscription | kmx-caf-nonprod-central-backup | caf-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| CAF Production Subscription | kmx-caf-prod-central-backup | caf-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| CAF Production Subscription | kmx-caf-prod-central-backup | caf-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| Information Security Non Production Subscription | kmx-infosec-nonprod-central-backup | infosec-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| Information Security Non Production Subscription | kmx-infosec-nonprod-central-backup | infosec-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| Information Security Prod Subscription | kmx-infosec-prod-central-backup | infosec-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| Information Security Prod Subscription | kmx-infosec-prod-central-backup | infosec-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| Infrastructure Shared Non Production Subscription | kmx-infrashared-nonprod-central-backup | infrashared-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| Infrastructure Shared Non Production Subscription | kmx-infrashared-nonprod-central-backup | infrashared-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| Infrastructure Shared Production Subscription | kmx-infrashared-prod-central-backup | infrashared-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| Infrastructure Shared Production Subscription | kmx-infrashared-prod-central-backup | infrashared-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| IT Operations Non Production Subscription | kmx-itops-nonprod-central-backup | itops-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| IT Operations Non Production Subscription | kmx-itops-nonprod-central-backup | itops-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| IT Operations Prod Subscription | kmx-itops-prod-central-backup | itops-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| IT Operations Prod Subscription | kmx-itops-prod-central-backup | itops-prod-east-backupvault | KMXPolicy | 2:30:00 | 
| PCI Non Production Subscription | kmx-pci-nonprod-central-backup | pci-nonprod-west-backupvault | KMXPolicy | 2:30:00 | 
| PCI Non Production Subscription | kmx-pci-nonprod-central-backup | pci-nonprod-east-backupvault | KMXPolicy | 2:30:00 | 
| PCI Production Subscription | kmx-pci-prod-central-backup | pci-prod-west-backupvault | KMXPolicy | 2:30:00 | 
| PCI Production Subscription | kmx-pci-prod-central-backup | pci-prod-east-backupvault | KMXPolicy | 2:30:00 | 

Each managed VM that cannot be easily rehydrated should have the default KMX backup policy activated. In addition the VMs should have a Backup tag and a BackupCadence tag to aid automation efforts. The BackupCadence tag is open ended string important for deliniating any VMs that may have different backup requirements than the standard KMX policy accounts for. See example of tags below:

>Backup: True
>BackupCadence: "daily, 4week retention"

We plan to enforce this in the future using a service such as cloud custodian to identify VMs that are HCSManaged but do not have the backup tags. This capability is not currently built out but is being designed. 

#### Rehydratable VMs
VM's that are perfectly rehydratable will not require a full vm snapshot as stored data will exist on an external medium such as a storage account. Therefore if a VM is truly rehydratable in nature backing it up would be pointless since it can be rebuilt at anytime via the automated build process for that VM. 

These Vms should have the following Tag applied to denote that the default backup policy is not needed:
> Backup: False


### Restore

For both File level and full VM restores, follow the Azure documentation:

- File Level: https://docs.microsoft.com/en-us/azure/backup/backup-azure-restore-files-from-vm
- Full VM: https://docs.microsoft.com/en-us/azure/backup/backup-azure-arm-restore-vms



### Considerations for the New Subscription Model
As the team continues to refine and automate the subscription creation process a required step should be to ensure there is a recovery vault with the default KMX backup policy defined. 