# Azure Resource Tagging Guide

Tags are applied to all Azure resources to manage billing and to provide a point of contact to communicate outages and impactful events. Tagging is enforced through Resource Manager Policies. A maximum of 15 tags can be applied per Azure resource.

## Standard Tags (IaaS or PaaS):
?> Additional tags can be utilized based on the team's specific needs.
### Enterprise Subscription:

- Environment:
  - prod and nonprod are the only allowed values
  - Lowercase
- ApplicationName (e.g. connectappraisal, blueprism)
  - Lowercase
  - No spaces
- SecurityLevel
  - Non-CarMax
  - Internal Use Only
  - Confidential
  - Restricted Confidential
  - Public
  - [IST List of Security Levels](http://carmaxworld.carmax.org/carmax%20world/cmxweb.nsf/a85706b53cb779f88525712d0061e309/dc28338dd2d211ae8525802e003f05ab/$FILE/301_InformationClassificationPolicy.pdf)
- TeamName (e.g. onlinesystems, informatiosecurity, enterprisesystems)
  - Lowercase
  - No spaces
- Owner
  - Email address of Manager or Product Owner of team that owns application.
  - Lowercase
  - No spaces
- OwnerVP
  - Email address of VP of Manager or Product Owner who owns application.
  - Lowercase
  - No spaces
- Contact
  - Email distribution list of team that owns application
  - Lowercase
  - No spaces

### Tags in the New Subscription Model:

- ApplicationName
  - Applied via policy from a management group.
- Owner:
  - Applied via policy from a management group.
- OwnerVP:
  - Applied via policy from a management group.
- Contact:
  - Applied via policy from a management group.
- SecurityLevel:
  - Required by policy and follows the same guidelines as above
- Environment:
  - Required by policy and follows the same guidelines as above

?> TeamName has been dropped from the New Subscription Model tagging requirements.


### Managed Service Identities used by Tagging Policies:

To perform remediations, or on-demand policy enforcements to bring in-scope resources into compliance, Azure Policy automatically creates and assigns a Managed Service Identity (MSI), with a role of contributor on the scope of the Policy Assignment. As we typically assign tagging policies at the management group level, this means that all child resources from this scope down will inherit this access. The following is a table of current known MSIs specific to Azure Policy. Other non-tagging policies will be added to this table for convenience reasons.

| MSI Display Name         | Policy or Initiative    | Scope                               |
| ------------------------ |-------------------------| ------------------------------------|
| 941138fffeaf403d9024f8ff | KMX-Tagging-Enforce     | Enterprise-Cloud-Test-Subscriptions |
| b9124217144e458eaf66f01b | KMX-Tagging-Enforce     | KMX-NonProd-Subscriptions           |
| a5d2187700984ed6ae452b9b | KMX-Tagging-Enforce     | KMX-Prod-Subscriptions              |


## HCS Self Service Tag Request Form (STAGR)

We have released a Self-Service Tag Request Form as part of our HCS Portal suite of microservices. For more information, please visit the [documentation](https://github.carmax.com/pages/CarMax/enterprise-azure-standards/#/AzureGeneral/taggingselfservice)

