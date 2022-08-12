# Operations Management Suite (OMS) Setup

OMS is a tool that we are using for aggregating log data, alerting, automation and patching. In order to take advantage of OMS, the agent needs to be installed on the VM. In addition to the OMS agent, there is also a Dependency agent which also needs to be installed in order to give access to Service Map.

A few items to note are the following: *We have two different environments (Prod and NonProd). *All of the deployment values are stored in keyvault. \*The agent can be installed on both Windows and Linux VMs.

To fulfill the requirement of no non-proxied outbound internet access, we need to send OMS communication through an OMS Gateway server. We have separate OMS Gateway servers configured for NonProd and Prod.

### Communicating with OMS using an OMS Gateway Server

- NonProd is configured on ENTUTLD31 using the name – http://oms-nonprod-gw.carmax.org:8080 .
- Prod is configured on ENTUTLP31 using the name – http://oms-prod-gw.carmax.org:8082
- The OMS Gateway servers communicates through our Pittsburg proxy server. http://pitbcproxy.carmax.org:8080

![OMS Gateway](/images/OMSGateway.jpg)

### Configure OMS on Windows

The installation of this OMS agent is completed using the Azure ARM template custom script extension, located: [Windows Custom Script Extension](https://kmxprodinfrashared.blob.core.windows.net/scripts/WinExtensionScript.ps1)

Additionally, this code is located in the following [GitHub](https://github.carmax.com/CarMax/enterprise-azure-standards/tree/master/CustomScriptExtension/Windows) repository.

Below is the code within the Custom Script Extension that installs the OMS agent and configures it to use the specified OMS Gateway:

NonProd

```
function Start-KMXInstallers {
    [CmdletBinding()]
    param (
        $ArgumentList,
        $Path,
        $FileName
    )
    $FilePath = $Path + $FileName
    Write-Verbose "Installing $FileName"
    if ($ArgumentList -ne $null) {
        Start-Process `
            -FilePath $FilePath `
            -ArgumentList $ArgumentList `
            -Wait
    }
    else {
        Start-Process `
            -FilePath $FilePath `
            -Wait
    }
}
Write-Verbose "Installing OMS"
$workspaceid = "cfd7b95e-9031-4e98-8ea2-b4928ae68cb0"
$workspacekey = "V2QJI1HLWblzH6XsJ8apLJzKnkCIcgdmwkDWjrV7VMUbHttkUHcQQ20LSOSgFxIAFh9fndmWxvjGUT05qBub5g=="
$omsproxyuri = "http://oms-nonprod-gw.carmax.org:8080"
$switches = "/qn NOAPM=1 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 OPINSIGHTS_WORKSPACE_ID=$workspaceid OPINSIGHTS_WORKSPACE_KEY=$workspacekey OPINSIGHTS_PROXY_URL=$omsproxyuri AcceptEndUserLicenseAgreement=1"
$OMSDownloadPath = "C:\WindowsAzure\Installers\"
$OMSSetupFile = "Setup.exe"

if ($OMSDownloadPath + $OMSSetupFile) {
    Start-KMXInstallers -FileName $OMSSetupFile -Path $OMSDownloadPath -ArgumentList $switches
    $Results = "OMS Successfully Installed"
    Write-Host $Results
}
else {
    Write-Host "OMS Setup does not exist."
}
```

Prod

```
function Start-KMXInstallers {
    [CmdletBinding()]
    param (
        $ArgumentList,
        $Path,
        $FileName
    )
    $FilePath = $Path + $FileName
    Write-Verbose "Installing $FileName"
    if ($ArgumentList -ne $null) {
        Start-Process `
            -FilePath $FilePath `
            -ArgumentList $ArgumentList `
            -Wait
    }
    else {
        Start-Process `
            -FilePath $FilePath `
            -Wait
    }
}
Write-Verbose "Installing OMS"
$workspaceid = "9aeb1588-b15d-416d-a5a5-de7f5dacdfd3"
$workspacekey = "YQCYfd0chlQ1XX/rkfBiSJliBZEQJjhlIJBmcIkteKdKpEGCJN6UueiOJypFMLM4MJGv7DUMftW943UTnDi00A=="
$omsproxyuri = "http://oms-prod-gw.carmax.org:8082"
$switches = "/qn NOAPM=1 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 OPINSIGHTS_WORKSPACE_ID=$workspaceid OPINSIGHTS_WORKSPACE_KEY=$workspacekey OPINSIGHTS_PROXY_URL=$omsproxyuri AcceptEndUserLicenseAgreement=1"
$OMSDownloadPath = "C:\WindowsAzure\Installers\"
$OMSSetupFile = "Setup.exe"

if ($OMSDownloadPath + $OMSSetupFile) {
    Start-KMXInstallers -FileName $OMSSetupFile -Path $OMSDownloadPath -ArgumentList $switches
    $Results = "OMS Successfully Installed"
    Write-Host $Results
}
else {
    Write-Host "OMS Setup does not exist."
}
```

Note - The above code is run after the "MMASetup-AMD64.exe" file has been extracted to "C:\WindowsAzure\Installers\". The Setup.exe file will be available once this file has been extracted.

In summary, if the ‘WinExtensionScript’ is used during deployment of the VM, the OMS fill will be extracted, installed and configured correctly to communicate using the appropriate OMS gateway. Additionally, the custom script extension will also install the OMS Dependency Agent which is needed to utilize the Service Map feature within OMS.

### Configure OMS on Linux

The OMS Agent and OMS Dependency agent is configured in the ARM template for Linux systems. Below are the details.

```
{
    "type": "extensions",
    "name": "Microsoft.EnterpriseCloud.Monitoring",
    "apiVersion": "2017-03-30",
    "location": "[parameters('Location')]",
    "dependsOn": [
        "[parameters('virtualMachineName')]"
    ],
    "properties": {
        "publisher": "Microsoft.EnterpriseCloud.Monitoring",
        "type": "OmsAgentForLinux",
        "typeHandlerVersion": "1.0",
        "autoUpgradeMinorVersion": true,
        "settings": {
            "workspaceId": "[parameters('workspaceId')]"
        },
        "protectedSettings": {
            "workspaceKey": "[parameters('workspaceKey')]"
        }
    }
},
{
    "type": "extensions",
    "name": "DependencyAgent",
    "apiVersion": "2017-03-30",
    "location": "[parameters('Location')]",
    "dependsOn": [
        "[parameters('virtualMachineName')]"
    ],
    "properties": {
        "publisher": "Microsoft.Azure.Monitoring.DependencyAgent",
        "type": "DependencyAgentLinux",
        "typeHandlerVersion": "9.1",
        "autoUpgradeMinorVersion": true
    }
}
```

### OMS Gateway Administration

PowerShell commands to switch proxy from Pittsburg to Irving. The OMSGateway PowerShell cmdlets are added to the system when the agent is installed.

1. To import the module, run: `Import-Module OMSGateway`
2. If no error occurs, then run: `Get-Module OMSGateway`
3. To change the OMS Gateway server, run: `Set-OMSGatewayRelayProxy -Address http://oms-nonprod-gw.carmax.org:8080`
4. To validate the current OMS Gateway Proxy, run: `Get-OMSGatewayRelayProxy`
   Additional details regarding this PowerShell cmdlet can be found https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-oms-gateway#useful-powershell-cmdlets

Additional reference links:

- Connect computers without Internet access using the OMS Gateway - https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-oms-gateway
- Managing and maintaining the Log Analytics agent for Windows and Linux - https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-agent-manage
