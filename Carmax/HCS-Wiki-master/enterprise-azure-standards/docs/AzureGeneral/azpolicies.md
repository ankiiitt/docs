#  Azure Security Policies

## Public IPs

* No Public IPs should be used on VMs.
* Virtual Network Service Endpoints (VNSEs) should be configured for PaaS resources when available.

## Virtual Networks (vnets)

* The only team who is able and authorized to make changes to vnets is the Enterprise Cloud Delivery team.  
* All vnets need to be centrally managed in either the “Infrastructure Shared NonProd” or “Infrastructure Shared Prod” Subscriptions.
* There is currently a “deny vnet” changes policy associated to all vnets.

## The following agents need to be installed on Windows VMs that are domain joined/centrally managed.
The list of standard software can be found: [Standard Software on Azure VMs](azvmsoftwarestandard.md) 

## Exceptions
Any exceptions to these rules needs approval by a member of the Information Security architecture team.