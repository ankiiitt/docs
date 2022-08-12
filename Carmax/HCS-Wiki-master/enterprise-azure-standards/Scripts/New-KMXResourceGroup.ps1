<#
    .SYNOPSIS
    This file will create a new resource group in the subscription your context is currently in. This resource group will follow the CarMax standardized naming scheme. This is not meant to be utilized with the New Subscription Model Pilot.
    WARNING: If there is a resource group with the same name, it WILL modify the tags to fit what this commandlet is setting.
    Naming Scheme (All Lower case):
        kmx-<ENVIRONMENT>-<REGION>-<APPLICATIONNAME>
        or
        kmx-<ENVIRONMENT>-<REGION>-<PRODUCTVERTICAL>-<APPLICATIONNAME>

        Example:
        kmx-dev-east-pastastrainer
        or:
        kmx-dev-east-buys-pastastrainer

    .EXAMPLE
    New-KMXResourceGroup -ApplicationName "MySpecialApp" -TeamName "HCS" -Owner "david_harold@carmax.com" -Contact "it-enterprise-cloud-platform@carmax.com" -SecurityLevel "Public" -Region "East" -Environment "dev"

    Creates a resource group with the name:
    kmx-dev-east-myspecialapp
    with tags:
    TeamName - hcs
    SecurityLevel - Public
    Owner - david_harold@carmax.com
    Contact - it-enterprise-cloud-platform@carmax.com
    Environment - nonprod
    ApplicationName - myspecialapp

    .NOTES
    The additional information required in this function is used for tagging that is required from an enterprise azure standards standpoint and mostly utilize for contact and billing purposes.

    Questions, Comments, please contact the HCS Public Cloud Engineering Team at
    #>

[CmdletBinding(
    PositionalBinding = $false,
    SupportsShouldProcess = $true
)]
param (
    # Name of the Application being deployed
    [Parameter(Mandatory = $true)]
    [string]
    $ApplicationName,
    # Environment of the new resource group. This will be used for both naming and tagging. Allowed Values: dev,qa,sbx,prod
    [Parameter(Mandatory = $true)]
    [ValidateSet(
        "prod",
        "dev",
        "qa",
        "sbx"
    )]
    [string]
    $Environment,
    # Owner of the resource group. This should be the email address of the owning manager.
    [Parameter(Mandatory = $true)]
    [string]
    $Owner,
    # Owner's VP of the resource group. This should be the email address of the owning manager's VP.
    [Parameter(Mandatory = $true)]
    [string]
    $OwnerVP,    
    # Contact of the resource group. This should be the email address distribution group that needs to be contacted for issues
    [Parameter(Mandatory = $true)]
    [string]
    $Contact,
    # Security Level of the resource group. The allowed values here are dictated by the Security Team and logged here: http://carmaxworld.carmax.org/carmax%20world/cmxweb.nsf/a85706b53cb779f88525712d0061e309/dc28338dd2d211ae8525802e003f05ab/$FILE/301_InformationClassificationPolicy.pdf
    [Parameter(Mandatory = $true)]
    [ValidateSet(
        "Non-CarMax",
        "Internal Use Only",
        "Confidential",
        "Restricted Confidential",
        "Public"
    )]
    [string]
    $SecurityLevel,
    # Team Name needs to be the name of the team building/managing the application
    [Parameter(Mandatory = $true)]
    [string]
    $TeamName,
    # Region the resource group will live in. EX: east the allowed values here are based on our current usage, if you need a different region, this will need changes lower in the script.
    [Parameter(Mandatory = $true)]
    [ValidateSet(
        "east",
        "eastus",
        "east us",
        "west",
        "westus",
        "west us",
        "central",
        "centralus",
        "central us"
    )]
    [string]
    $Region,
    # Product Vertical is applicaable to anyone working within a product vertical and will modify the name of the resource group by appending the product vertical before the application name.
    [Parameter(Mandatory = $false)]
    [string]
    $ProductVertical
)

begin {
    try {
        Disable-AzDataCollection -ErrorAction Stop
        Enable-AzureRmAlias -ErrorAction Stop
    }
    catch {
        Write-Error "This file depends on the Az PowerShell module which has not been detected"
    }
    # Standardize almost all values to lower case.
    $Environment = $Environment.ToLower()
    $Region = $Region.ToLower()
    $Contact = $Contact.ToLower()
    $Owner = $Owner.ToLower()
    $OwnerVP = $OwnerVP.ToLower()
    $ApplicationName = $ApplicationName.ToLower()
    $TeamName = $TeamName.ToLower()
    if ($Environment -eq "prod") {
        $EnvironmentTag = "prod"
    }
    else {
        $EnvironmentTag = "nonprod"
    }
    # Configure region in name correctly
    switch ($Region) {
        { $_ -match "east" } {
            $Location = "east"
            $DeployRegion = "eastus"
        }
        { $_ -match "west" } {
            $Location = "west"
            $DeployRegion = "westus"
        }
        { $_ -match "central" } {
            $Location = "central"
            $DeployRegion = "centralus"
        }
    }
    # Build RG Name:
    if ($ProductVertical) {
        switch ($Location) {
            "east" {
                $ResourceGroupName = "kmx-$Environment-$Location-$($ProductVertical.ToLower())-$ApplicationName"
            }
            "west" {
                $ResourceGroupName = "kmx-$Environment-$Location-$($ProductVertical.ToLower())-$ApplicationName"
            }
            "central" {
                $ResourceGroupName = "kmx-$Environment-$Location-$($ProductVertical.ToLower())-$ApplicationName-shared"
            }
        }
    }
    else {
        switch ($Location) {
            "east" {
                $ResourceGroupName = "kmx-$Environment-$Location-$ApplicationName"
            }
            "west" {
                $ResourceGroupName = "kmx-$Environment-$Location-$ApplicationName"
            }
            "central" {
                $ResourceGroupName = "kmx-$Environment-$Location-$ApplicationName-shared"
            }
        }
    }
    # Configure security level correctly
    switch ($SecurityLevel) {
        { $_.ToLower() -match "non-carmax" } { $SecurityLevelTag = "Non-CarMax" }
        { $_.ToLower() -match "internal use only" } { $SecurityLevelTag = "Internal Use Only" }
        { $_.ToLower() -match "confidential" } { $SecurityLevelTag = "Confidential" }
        { $_.ToLower() -match "restricted confidential" } { $SecurityLevelTag = "Restricted Confidential" }
        { $_.ToLower() -match "public" } { $SecurityLevelTag = "Public" }
    }
    # Build Tag Object
    $Tags = @{
        ApplicationName = $ApplicationName
        TeamName        = $TeamName
        Environment     = $EnvironmentTag
        Owner           = $Owner
        OwnerVP         = $OwnerVP
        Contact         = $Contact
        SecurityLevel   = $SecurityLevelTag
    }
}

process {
    try {
        $NewResourceGroupSplat = @{
            Name        = $ResourceGroupName
            Location    = $DeployRegion
            Tag         = $Tags
            ErrorAction = "Stop"
        }
        $ResourceGroupResponse = New-AzResourceGroup @NewResourceGroupSplat -Force
    }
    catch {
        Write-Host $_
        Write-Error "There was an error creating the new resource group"
    }
}

end {
    return $ResourceGroupResponse
}