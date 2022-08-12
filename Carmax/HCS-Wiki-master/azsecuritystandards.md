# Azure Security Policies

Below is a list of the current standards for security within Azure.

The following policies are in place within Azure.  

#### Tagging Policy

Tagging enforcement policies are in place to ensure that tags listed in the following document are maintained: [Tagging Standards](https://github.carmax.com/pages/CarMax/enterprise-azure-standards/#/aztaggingguide)

#### Public IPs

- No Public IPs should be used on VMs.
- Virtual Network Service Endpoints (VNSEs) should be configured for PaaS resources when available.

#### Virtual Networks (vnets)

- The only team who is able and authorized to make changes to vnets is the Enterprise Cloud team.
- All vnets need to be centrally managed in either the “Infrastructure Shared NonProd” or “Infrastructure Shared Prod” Subscriptions.
- There is currently a “deny vnet” changes policy associated to all subscriptions.

#### VM Outbound Internet Access

Outbound internet access must go through a proxy server.

#### VM Standard Software

The list of agents needed on both Windows and Linux Azure VMs can be found at the following location: [Standard Software on VMs](https://github.carmax.com/pages/CarMax/enterprise-azure-standards/#/azvmsoftwarestandard)

#### Exceptions

Any exceptions to these rules needs the approval of a member of the Information Security Architecture team.
