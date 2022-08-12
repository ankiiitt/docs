# HCS Self Service Tag Request Form (STAGR)

Tags are applied to all Azure resources to manage billing and to provide a point of contact to communicate outages and impactful events. Tagging is enforced through Resource Manager Policies. A maximum of 15 tags can be applied per Azure resource. The HCS Self Service Tag Request Form (STAGR) allows users to easily request changes to tags, while also empowering them with automation to be able to make sweeping tag updates across their environments.

STAGR provides the following key benefits:

* Allow users to easily request changes in an intuitive webform
* Resource Group Owners can be informed of potential changes to tags in their environment and approve or reject a request
* Automated tag deployments will recursively update tags of all resources within scoped resource group(s), allowing greater ease of tag management

## Usage

### Tag Requestor

The role of the tag requestor is any user of the Tag Request Form who intends to submit a request to create or modify tags on an Azure Resource/Resource Group.

The user is able to create new requests by accessing the HCS Portal site (https://hcsportal.carmax.com) and clicking on the Azure Tagging Self-Service button. Once in the correct application, the request form will be on the main body of the page.

Please note the following:

* The subscription and resource group dropdowns may take a moment to load
* Subscription must be selected first before selecting the desired resource groups
* Resource Group selection is a multi-select. You may select multiple before clicking outside the dropdown list to return to the form.
* Select the tag that you wish to change. Add Row and Remove Row buttons will allow you to add or remove requested tags.

### Resource Group Owner

The role of the Resource Group Owner is any user who is identified in the Owner tag of an Azure Resource Group. This user is designated as the primary approver for any tag change requests that impact the user's Resource Group(s). In the absence of the Resource Group Owner, or any extraordinary circumstance that require it, the HCS senior management may approve an override approval. This should only be utilized in the unlikely event that a Resource Group Owner is unable to provide approval via the HCS Portal.

The primary approver is able to review and approve requests by accessing the HCS Portal site (https://hcsportal.carmax.com) and clicking on the Azure Tagging Self-Service button. Once in the correct application, all pending requests will appear in the Request Approval Panel. Clicking on a request will allow the user to review the details and approve or reject the request.

### Special Case: Secondary Approver

In special cases, such as a transfer of ownership of a Resource Group, a secondary approver is required. In the case of a transfer of ownership of a Resource Group, the secondary approver is the user designated as the incoming owner. Since certain tags are critical to ensuring accurate cost allocation, this process is to ensure that the risk of system abuse is mitigated (i.e. fradulently or mistakenly transferring ownership). The seconary approver will also receive an email notifying of a pending request.

The secondary approver is able to review and approve requests by accessing the HCS Portal site (https://hcsportal.carmax.com) and clicking on the Azure Tagging Self-Service button. Once in the correct application, all pending requests will appear in the Request Approval Panel. Clicking on a request will allow the user to review the details and approve or reject the request.

### HCS Team Member

The HCS Team Member is the final approver of requests. For normal requests, an HCS Team Member will not review a request until the Primary Approver (or in special cases, also the Secondary Approver) has given approval. In extraordinary circumstances, only the HCS senior management will be able to provide an override approval to submit the request for deployment.

## Authorization Flow

1. User submits tag request
2. Resource Group Owner(s) receive email notifying them of pending request
3. Resource Group Owner reviews request
4. Resource Group Owner rejects or approves request
5. SPECIAL CASE: Secondary approver required: Secondary approver rejects or approves request
6. HCS Team member rejects or approves request
7. If approved, request is submitted to automation for tag deployment and propagation

## Important Considerations

* Tags are vital to our Azure cost management efforts. Please review the [Azure Tagging Standards documentation](https://github.carmax.com/pages/CarMax/enterprise-azure-standards/#/AzureGeneral/aztaggingguide) to ensure that you are making complaint changes to tags
* This application is an iterative product. There will be bugs and happy little accidents from time to time. We ask that you please be patient and inform us anytime you encounter something unexpected or off (load times of more than a minute is considered unusual)

## Known issues

* Currently, Subscription-wide deployments are disabled. Please only use the Resource Group option in the Scope Selection
* The email function seems to be sending two of the same email notifications in certain cases. We are actively investigating and will patch a fix when we are able
