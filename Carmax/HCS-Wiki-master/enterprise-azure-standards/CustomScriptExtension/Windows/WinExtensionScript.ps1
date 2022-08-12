# **********************************************************************
# Written By: Jason Cobb
# Created On: 2018-01-31
# Edited By: Mike Messina On: 2019-10-08
#
# This is a base script to run the EPO and Tanium installers along with running the CarMaxification of a Windows 2012r2 server
#
# USE: This script requires the use of the environment parameter. If nothing is entered, it defaults to prod. The valid options are either prod or nonprod.
# EXAMPLE: .\DefaultExtensionScript.ps1 -Environment "prod"
#
# **********************************************************************
param(
    # Parameter help description
    [Parameter(Mandatory = $true)]
    [ValidateSet("prod", "nonprod")]
    [String]
    $Environment,
    # Installs IIS if selected
    [Parameter(Mandatory = $false)]
    [switch]
    $InstallIIS
)
#region: Transcription Stuff
try {
    Write-Verbose "Trying to stop transcript"
    Stop-Transcript -ErrorAction Stop
    Write-Verbose "Transcript Stopped"
}
catch {
    Write-Verbose "Transcript Not Running"
}
$Date = Get-Date
$TranscriptPath = 'C:\Temp'
$LogName = "extension.log"
$TranscriptName = $Date.Year.ToString() `
    + '-' + $Date.Day.ToString() `
    + '-' + $Date.Hour.ToString() `
    + '-' + $Date.Minute.ToString() `
    + '-' + $Date.Second.ToString() `
    + '-' + $LogName
if (Test-Path -Path $TranscriptPath) {
    Write-Verbose "Transcript path exists, continuing"
}
else {
    Write-Verbose "Transcript path does not exist, creating"
    New-Item -Name "Temp" -Path "C:\" -ItemType Directory
}
Start-Transcript -Path "$TranscriptPath\$TranscriptName"
#endregion: Transcription Stuff
#region: Variables
# Download Items FileName, Source, Destination Path
# Update DownloadItems array to support the correct version of EPO
switch ($Environment.ToLower()) {
    "prod" {
        $DownloadItems += @(
            ("CS_WindowsSensor.exe", "https://kmxprodinfrashared.blob.core.windows.net/crowdstrike/CS_WindowsSensor.exe?sv=2018-03-28&ss=b&srt=sco&sp=rwlac&se=2022-01-23T01:30:49Z&st=2019-01-22T17:30:49Z&spr=https&sig=1H1XRjhStSJMvCsX1goejxjvXZ%2Bv1jpCDv5K1%2FPn8xQ%3D", "C:\WindowsAzure\Installers\", "y", "/install /quiet /norestart ProvNoWait=1 CID=9E158345F3D546BBB3493737D31A510D-07 PW='OtOMonDrAGERaPTORPurECT' PACURL=http://pac.carmax.org:8080/wpad.dat"),
            ("InstallDependencyAgent-Windows.exe", "https://kmxprodinfrashared.blob.core.windows.net/oms/InstallDependencyAgent-Windows.exe?sv=2017-07-29&ss=b&srt=sco&sp=rwla&se=2028-04-24T00:30:17Z&st=2018-04-23T16:30:17Z&spr=https&sig=O3s2MQ32rsiUsdMBdLr64vXBIC73RQAL5O%2Fu72nuUsU%3D", "C:\WindowsAzure\Installers\", "y", "/S /Rebootmode:Rebootifneeded"),
            ("splunkforwarder-7.3.1-bd63e13aa157-x64-release.msi", "https://itopsprodsoftwarestorage.blob.core.windows.net/splunk/splunkforwarder-7.3.1-bd63e13aa157-x64-release.msi?sp=r&st=2019-09-04T19:12:20Z&se=2020-09-05T03:12:20Z&spr=https&sv=2018-03-28&sig=JATYahiiu0Gmvfi7oDHoV0gNVPNLrkMtseyvYlGKlm8%3D&sr=b", "C:\WindowsAzure\Installers\", "y", "DEPLOYMENT_SERVER='10.16.204.82:8089' AGREETOLICENSE=Yes /quiet GENRANDOMPASSWORD=1")
        )
        $WorkSpaceID = "9aeb1588-b15d-416d-a5a5-de7f5dacdfd3" 
        $WorkSpaceKey = "YQCYfd0chlQ1XX/rkfBiSJliBZEQJjhlIJBmcIkteKdKpEGCJN6UueiOJypFMLM4MJGv7DUMftW943UTnDi00A==" 
        $OMSProxyServer = "http://oms-prod-gw.carmax.org:8082" 
        $OMSURI = "https://kmxprodinfrashared.blob.core.windows.net/oms/MMASetup-AMD64.exe?sv=2017-07-29&ss=b&srt=sco&sp=rwla&se=2028-04-24T00:30:17Z&st=2018-04-23T16:30:17Z&spr=https&sig=O3s2MQ32rsiUsdMBdLr64vXBIC73RQAL5O%2Fu72nuUsU%3D" 
    }
    "nonprod" {
        $DownloadItems += @(
            ("CS_WindowsSensor.exe", "https://kmxnonprodinfrashared.blob.core.windows.net/crowdstrike/CS_WindowsSensor.exe?sv=2018-03-28&ss=b&srt=sco&sp=rwla&se=2022-01-23T01:32:55Z&st=2019-01-22T17:32:55Z&spr=https&sig=zjJ5RddUEnXgZeNGmE104PUI9WdgyvhUj2IEDerAdQ0%3D", "C:\WindowsAzure\Installers\", "y", "/install /quiet /norestart ProvNoWait=1 CID=9E158345F3D546BBB3493737D31A510D-07 PW='OtOMonDrAGERaPTORPurECT' PACURL=http://pac.carmax.org:8080/wpad.dat"),
            ("InstallDependencyAgent-Windows.exe", "https://kmxnonprodinfrashared.blob.core.windows.net/oms/InstallDependencyAgent-Windows.exe?sv=2017-04-17&ss=bfqt&srt=sco&sp=rwdlacup&se=2099-01-17T22:09:05Z&st=2018-01-17T14:09:05Z&spr=https&sig=PwK8I8K1u1Nk8DV5bqlsClLiBbNo7q1nQCRjNgMzrSQ%3D", "C:\WindowsAzure\Installers\", "y", "/S /Rebootmode:Rebootifneeded"),
            ("splunkforwarder-7.3.1-bd63e13aa157-x64-release.msi", "https://itopsprodsoftwarestorage.blob.core.windows.net/splunk/splunkforwarder-7.3.1-bd63e13aa157-x64-release.msi?sp=r&st=2019-09-04T19:12:20Z&se=2020-09-05T03:12:20Z&spr=https&sv=2018-03-28&sig=JATYahiiu0Gmvfi7oDHoV0gNVPNLrkMtseyvYlGKlm8%3D&sr=b", "C:\WindowsAzure\Installers\", "y", "DEPLOYMENT_SERVER='172.18.120.32:8089' AGREETOLICENSE=Yes /quiet GENRANDOMPASSWORD=1")
        )
        $WorkSpaceID = "cfd7b95e-9031-4e98-8ea2-b4928ae68cb0" 
        $WorkSpaceKey = "V2QJI1HLWblzH6XsJ8apLJzKnkCIcgdmwkDWjrV7VMUbHttkUHcQQ20LSOSgFxIAFh9fndmWxvjGUT05qBub5g==" 
        $OMSProxyServer = "http://oms-nonprod-gw.carmax.org:8080" 
        $OMSURI = "https://kmxnonprodinfrashared.blob.core.windows.net/oms/MMASetup-AMD64.exe?sv=2017-04-17&ss=bfqt&srt=sco&sp=rwdlacup&se=2099-01-17T22:09:05Z&st=2018-01-17T14:09:05Z&spr=https&sig=PwK8I8K1u1Nk8DV5bqlsClLiBbNo7q1nQCRjNgMzrSQ%3D" 
    }
}
$nexposemsifile = "agentInstaller-x86_64.msi"
$nexposezipfile = "Windows_Agent.zip"
$nexposelocation = "C:\WindowsAzure\Installers\"
$nexposeuri = "https://insightagentinstallers.blob.core.windows.net/insight-agent-installers/Windows_Agent.zip?sp=r&st=2019-10-07T15:29:36Z&se=2026-01-01T04:59:00Z&spr=https&sv=2018-03-28&sig=fMNxW7RPBOxTKZHg1M3HhSWPAwidWotdjjYty1iWh%2FM%3D&sr=b"
$nexposeargument = "CUSTOMTOKEN=us:b00928f4-7087-44ee-b3bf-a9bc9c66a586 /quiet /qn HTTPSPROXY=pitbcproxy.carmax.org:8080"

$RegKeys = @(
    ("HKLM", ".\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "EnableLUA", "0", "REG_DWORD" ),
    ("HKLM", ".\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}", "IsInstalled", "00000000", "REG_DWORD"),
    ("HKLM", ".\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer", "NoDriveTypeAutoRun", "0x000000ff", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\Control\Terminal Server", "fDenyTSConnections", "0", "REG_DWORD"),
    ("HKLM", ".\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services", "MaxDisconnectionTime", "0x006DDD00", "REG_DWORD"),
    ("HKLM", ".\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services", "MaxIdleTime", "0x006DDD00", "REG_DWORD"),
    ("HKLM", ".\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services", "fDisableCpm", "1", "REG_DWORD"),
    ("HKLM", ".\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer", "SmartScreenEnabled", "Off", "REG_SZ"),
    ("HKLM", ".\System\CurrentControlSet\Services\wuauserv", "Start", "2", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers", "1", "198.182.130.123", "REG_SZ"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers", "2", "198.182.130.124", "REG_SZ"),
    ("HKLM", ".\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient", "SearchList", "KMX.LOCAL,storescmax.adcmax.carmax.org,cmaxcorp.adcmax.carmax.org,adcmax.carmax.org,carmax.org,kmxqa.local,kmxtest.local", "REG_SZ"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters", "DisabledComponents", "0xFFFFFFFF", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\services\NetBT\Parameters", "EnableLMHOSTS", "0", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters", "DisableIPSourceRouting", "2", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters", "DisableIPSourceRouting", "2", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters", "PerformRouterDiscovery", "0", "REG_DWORD"),
    ("HKLM", ".\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters", "PerformRouterDiscovery", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer", "EnableAutoTray", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers", "DisableAutoplay", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Internet Explorer\Main", "Start Page", "about:blank", "REG_SZ"),
    ("HKCU", ".\Software\Microsoft\Internet Explorer\Main", "First Home Page", "about:blank", "REG_SZ"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "HideFileExt", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects", "VisualFXSetting", "2", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMEnabled", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation", "DefaultApplied", "0", "REG_DWORD"),
    ("HKCU", ".\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TransparentGlass", "DefaultApplied", "0", "REG_DWORD")
)
#endregion: Variables
function Get-KMXFiles {
    [CmdletBinding()]
    param (
        $Source,
        $FileName,
        $DestPath
    )
    begin {
        if (Test-Path $DestPath) {
            Write-Verbose "Destination already exists"
        }
        else {
            Write-Verbose "Creating Destination Path"
            New-Item `
                -Name $($DestPath.SubString(3, $DestPath.Length - 4)) `
                -ItemType Directory `
                -Path $DestPath.SubString(0, 3)
        }
    }
    process {
        # Download Files
        try {
            Invoke-WebRequest `
                -uri $Source `
                -OutFile "$DestPath$FileName" `
                -ErrorAction Stop
            $Results = "File $FileName downloaded Successfully"
        }
        catch {
            $Results = "File $FileName failed to download"
        }
    }
    end {
        Write-Verbose $Results
    }
}
<#  
.Synopsis 
This function will get the offline disk(s) on Windows Server and attempts to bring them online. 
.Description  
The CmdLet would use the diskpart.exe to find the offline disk(s) and enable them. 
The CmdLet would also support Windows 2008, Windows 2008 R2, Server 2012 and Server 2012 R2 with no dependency over the 'Storage Module' 
.Example 
Enable-OfflineDisk 
Following Offline disk(s) found..Trying to bring Online. 
  Disk 1    Offline        3072 MB  1984 KB          
  Disk 2    Offline        4096 MB  1024 KB          
Enabling Disk 1 
Enabling Disk 2 
Disk(s) are now online. 
#>  
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
function Set-DVDDriveLetter {
    [CmdletBinding()]
    param (
        [string]
        [ValidatePattern("^[A-Z]{1}:{1}`$")]
        $DriveLetter
    )
    begin {
        Write-Verbose "Getting current DVD Drive"
        $DVDDrive = Get-WmiObject -Class Win32_Volume -Filter "DriveType=5"
    }
    process {
        if ($DVDDrive -ne $null) {
            try {
                Write-Verbose "Setting Drive Letter to $DriveLetter"
                $DVDDrive | Set-WmiInstance -Arguments @{DriveLetter = "$DriveLetter" }
                $Results = "DVD Drive Letter set to $DriveLetter Successfully"
            }
            catch {
                $Results = "DVD drive was not set to $DriveLetter"
            }
        }
        else {
            $Results = "NO DVD Drive Found"
        }
    }
    end {
        Write-Verbose $Results
    }
}
function Set-KMXTimeZone {
    [CmdletBinding()]
    param (
        [ValidateSet(
            "Pacific Standard Time",
            "Mountain Standard Time",
            "Central Standard Time",
            "Eastern Standard Time"
        )]
        [string]
        $TimeZone = "Eastern Standard Time"
    )
    begin {
        Write-Verbose "Setting Timezone to $TimeZone"
    }
    process {
        try {
            $process = New-Object System.Diagnostics.Process
            $process.StartInfo.WindowStyle = "Hidden"
            $process.StartInfo.FileName = "tzutil.exe"
            $process.StartInfo.Arguments = "/s `"$TimeZone`""
            $process.Start() | Out-Null
            $Results = "Timezone successfully set to $TimeZone"
        }
        catch {
            $Results = "Setting Timezone Failed"
        }
    }
    end {
        Write-Verbose $Results
    }
}
function Set-KMXPageFileSize {
    <#
 	.SYNOPSIS
        Set-OSCVirtualMemory is an advanced function which can be used to adjust virtual memory page file size.
    .DESCRIPTION
        Set-OSCVirtualMemory is an advanced function which can be used to adjust virtual memory page file size.
    .PARAMETER  <InitialSize>
		Setting the paging file's initial size.
	.PARAMETER  <MaximumSize>
		Setting the paging file's maximum size.
	.PARAMETER  <DriveLetter>
		Specifies the drive letter you want to configure.
	.PARAMETER  <SystemManagedSize>
		Allow Windows to manage page files on this computer.
	.PARAMETER  <None>		
		Disable page files setting.
	.PARAMETER  <Reboot>		
		Reboot the computer so that configuration changes take effect.
	.PARAMETER  <AutoConfigure>
		Automatically configure the initial size and maximumsize.
    .EXAMPLE
        C:\PS> Set-OSCVirtualMemory -InitialSize 1024 -MaximumSize 2048 -DriveLetter "C:","D:"
		Execution Results: Set page file size on "C:" successful.
		Execution Results: Set page file size on "D:" successful.
		Name            InitialSize(MB) MaximumSize(MB)
		----            --------------- ---------------
		C:\pagefile.sys            1024            2048
		D:\pagefile.sys            1024            2048
		E:\pagefile.sys            2048            2048
	.LINK
		Get-WmiObject
		http:/-PropertyTypeechnet.microsoft.com/library/hh849824.aspx
    #>
    [cmdletbinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true)]
        [Alias('is')]
        [Int32]$InitialSize,
        [Parameter(Mandatory = $true)]
        [Alias('ms')]
        [Int32]$MaximumSize,
        [Parameter(Mandatory = $true)]
        [Alias('dl')]
        [String[]]$DriveLetter,
        [Parameter(Mandatory = $false)]
        [Switch]$None,
        [Parameter(Mandatory = $false)]
        [Switch]$SystemManagedSize,
        [Parameter(Mandatory = $false)]
        [Switch]$Reboot,
        [Parameter(Mandatory = $false)]
        [Alias('auto')]
        [Switch]$AutoConfigure
    )
    If ($PSCmdlet.ShouldProcess("Setting the virtual memory page file size")) {
        Foreach ($DL in $DriveLetter) {		
            If ($None) {
                $PageFile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name='$DL\\pagefile.sys'" -EnableAllPrivileges
                If ($PageFile -ne $null) {
                    $PageFile.Delete()
                }
                Else {
                    Write-Warning """$DL"" is already set None!"
                }
            }
            ElseIf ($SystemManagedSize) {
                $InitialSize = 0
                $MaximumSize = 0
                Set-PageFileSize -DL $DL -InitialSize $InitialSize -MaximumSize $MaximumSize
            }						
            ElseIf ($AutoConfigure) {
                $InitialSize = 0
                $MaximumSize = 0
            
                #Getting total physical memory size
                Get-WmiObject -Class Win32_PhysicalMemory | Where-Object { $_.DeviceLocator -ne "SYSTEM ROM" } | `
                    ForEach-Object { $TotalPhysicalMemorySize += [Double]($_.Capacity) / 1GB }
            <#
            By default, the minimum size on a 32-bit (x86) system is 1.5 times the amount of physical RAM if physical RAM is less than 1 GB, 
            and equal to the amount of physical RAM plus 300 MB if 1 GB or more is installed. The default maximum size is three times the amount of RAM, 
            regardless of how much physical RAM is installed. 
            #>
            If ($TotalPhysicalMemorySize -lt 1) {
                $InitialSize = 1.5 * 1024
                $MaximumSize = 1024 * 3
                Set-PageFileSize -DL $DL -InitialSize $InitialSize -MaximumSize $MaximumSize
            }
            Else {
                $InitialSize = 1024 + 300
                $MaximumSize = 1024 * 3
                Set-PageFileSize -DL $DL -InitialSize $InitialSize -MaximumSize $MaximumSize
            }
        }
        Else {
            Set-PageFileSize -DL $DL -InitialSize $InitialSize -MaximumSize $MaximumSize
        }
        If ($Reboot) {
            Restart-Computer -ComputerName $Env:COMPUTERNAME -Force
        }
    }
    #get current page file size information
    Get-WmiObject -Class Win32_PageFileSetting -EnableAllPrivileges | Select-Object Name, `
    @{Name = "InitialSize(MB)"; Expression = { if ($_.InitialSize -eq 0) { "System Managed" }else { $_.InitialSize } } }, `
    @{Name = "MaximumSize(MB)"; Expression = { if ($_.MaximumSize -eq 0) { "System Managed" }else { $_.MaximumSize } } } | `
        Format-Table -AutoSize
}
}
function Set-PageFileSize {
    Param($DL, $InitialSize, $MaximumSize)
    #The AutomaticManagedPagefile property determines whether the system managed pagefile is enabled. 
    #This capability is not available on windows server 2003,XP and lower versions.
    #Only if it is NOT managed by the system and will also allow you to change these.
    $IsAutomaticManagedPagefile = Get-WmiObject -Class Win32_ComputerSystem | Foreach-Object { $_.AutomaticManagedPagefile }
    If ($IsAutomaticManagedPagefile) {
        #We must enable all the privileges of the current user before the command makes the WMI call.
        $SystemInfo = Get-WmiObject -Class Win32_ComputerSystem -EnableAllPrivileges
        $SystemInfo.AutomaticManagedPageFile = $false
        [Void]$SystemInfo.Put()
    }
    Write-Verbose "Setting pagefile on $DL"
    #configuring the page file size
    $PageFile = Get-WmiObject -Class Win32_PageFileSetting -Filter "SettingID='pagefile.sys @ $DL'"
    Try {
        If ($PageFile -ne $null) {
            $PageFile.Delete()
        }
        Set-WmiInstance -Class Win32_PageFileSetting -Arguments @{name = "$DL\pagefile.sys"; InitialSize = 0; MaximumSize = 0 } `
            -EnableAllPrivileges | Out-Null
        $PageFile = Get-WmiObject Win32_PageFileSetting -Filter "SettingID='pagefile.sys @ $DL'"
        $PageFile.InitialSize = $InitialSize
        $PageFile.MaximumSize = $MaximumSize
        [Void]$PageFile.Put()
        Write-Verbose  "Execution Results: Set page file size on $DL successful."
        Write-Warning "Pagefile configuration changed on computer '$Env:COMPUTERNAME'. The computer must be restarted for the changes to take effect."
    }
    Catch {
        Write-Verbose "Execution Results: No Permission - Failed to set page file size on $DL"
    }
}
function Set-KMXNetworkSettings {
    [CmdletBinding()]
    param (
    )
    begin {
        Write-Verbose "Changing the following IP settings and setting REG Keys`r"
    }
    process {
        try {
            Write-Verbose "Changing NIC Settings"
            Write-Verbose "Disable Netbios`r"
            $adapter = (Get-WmiObject win32_networkadapterconfiguration -Property *)
            $adapter.settcpipnetbios(2)
            Write-Verbose "Rename Nic`r"
            Rename-NetAdapter -Name "Ethernet*" -NewName "CORE"
            Write-Verbose "Disable IPv6 on NIC"
            Disable-NetAdapterBinding -Name "CORE" -ComponentID ms_tcpip6
            Set-Net6to4Configuration -State Disabled
            Set-NetTeredoConfiguration -Type Disabled
        }
        catch {
            Write-Verbose "NIC Changes Failed"
        }
    }
    end {
    }
}
function Set-KMXGeneralComputerSettings {
    [CmdletBinding()]
    param (
    )
    begin {
        Write-Verbose "Changing settings to set General KMX System Settings"
    }
    process {
        try {
            Write-Verbose "Setting additional System Configurations (Non-Registry)"
            Write-Verbose "Disable Windows Firewall "
            Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False 
            Write-Verbose "OS Timeout "
            & "bcdedit" /timeout 5 
            Write-Verbose " Power Configurations "
            & "Powercfg" /hibernate off 
            & "powercfg" /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
            Write-Verbose "Disable Defrag Taskbar "
            & "schtasks" /Change /TN \Microsoft\Windows\Defrag\ScheduledDefrag /DISABLE
            $TaskParams = @(
                "/Create",
                "/TN", "CleanWinSXSFolder",
                "/SC", "MONTHLY",
                "/M", "*",
                "/D", "SUN",
                "/MO", "LAST",
                "/ST"."23:00",
                "/TR", ("C:\Windows\System32\cleanmgr.exe /sagerun:42"),
                "/F",
                "/RU", "system"
            )
            & "schtasks.exe" $TaskParams
        }
        catch {
            Write-Verbose "Setting System settings Failed"
        }
    }
    end {
    }
}
function Set-KMXInitializeDisk2 {
    <#
    .SYNOPSIS
    Initializes Disk 2
    .DESCRIPTION
    Initializes disk 2
    .EXAMPLE
    .NOTES
    This function will only initilize disk 2.  It will not function for other disks added to the VM.
    #>
    [CmdletBinding()]
    param (   
    )
    begin {
        Write-Verbose "Initializing disk 2"
    }
    process {
        try {
            Initialize-Disk 2 -PartitionStyle MBR `
                -ErrorAction Stop
            $Results = "Disk 2 initialized successfully"
        }
        catch {
            $Results = "Disk 2 did not initialize"
        }    
    }
    end {
        Write-Verbose $Results
    }
}
function Set-KMXFormatDisk2 {
    <#
    .SYNOPSIS
     Formats Disk 2
    
    .DESCRIPTION
    Formats disk 2 as NTFS disk
    
    .EXAMPLE
    
    .NOTES
    This function will not work for other disks that are added.
    #>
    [CmdletBinding()]
    param (                   
    )               
    begin {
        Write-Verbose "Formatting disk 2"
    }
    process {
        try {
            New-Partition -DiskNumber 2 `
                -UseMaximumSize `
                -AssignDriveLetter `
                -ErrorAction Stop | Format-Volume -NewFileSystemLabel "Data" -FileSystem NTFS -Confirm:$False  
            $Results = "Disk 2 formatted successfully"
        }
        catch {
            $Results = "Disk 2 did not format successfully"
        }        
    }
    end {
        Write-Verbose $Results
    }
}
function Set-KMXLocalAdminAccount {
    [CmdletBinding()]
    param(
        $localadmin,
        $newlocaladmin
    )   
    $localuser = (get-localuser)
    $Name = $localuser.Name
    if ($Name -eq 'Administrator') {
        Rename-LocalUser -Name $localadmin -NewName $newlocaladmin
        Write-host "Local admin account has been renamed from $localadmin to $newlocaladmin."
    }
    else {
        write-host "$localadmin does not exist."
    }
}
function Install-KMXOMS {
    param( 
        [parameter(Mandatory = $true, HelpMessage = "The ID of the Log Analytics workspace you want to connect the agent to.")] 
        [ValidateNotNullOrEmpty()] 
        [string]$WorkSpaceID, 
     
        [parameter(Mandatory = $true, HelpMessage = "The primary key of the Log Analytics workspace you want to connect the agent to.")] 
        [ValidateNotNullOrEmpty()] 
        [string]$WorkSpaceKey,
        
        [parameter(Mandatory = $true, HelpMessage = "The OMS Proxy server you want to connect the agent to.")] 
        [ValidateNotNullOrEmpty()] 
        [string]$OMSProxyServer,

        [parameter(Mandatory = $true, HelpMessage = "The URI Location where the OMS Agent can be downloaded from.")] 
        [ValidateNotNullOrEmpty()] 
        [string]$OMSURI
    )
    # Set the parameters 
    $FileName = "MMASetup-AMD64.exe" 
    $OMSFolder = 'C:\WindowsAzure\Installers\OMS' 
    $MMAFile = $OMSFolder + "\" + $FileName 
    $OMSLogName = "OMSAgentInstallLog.log"
    $Date = Get-Date
    $OMSTranscriptName = $Date.Year.ToString() `
        + '-' + $Date.Day.ToString() `
        + '-' + $Date.Hour.ToString() `
        + '-' + $Date.Minute.ToString() `
        + '-' + $Date.Second.ToString() `
        + '-' + $OMSLogName
    # Start logging the actions 
    Start-Transcript -Path $OMSFolder\$OMSTranscriptName  
    # Check if folder exists, if not, create it 
    if (Test-Path $OMSFolder) { 
        Write-Host "The folder $OMSFolder already exists." 
    }  
    else { 
        Write-Host "The folder $OMSFolder does not exist, creating..." -NoNewline 
        New-Item $OMSFolder -type Directory | Out-Null 
        Write-Host "done!" -ForegroundColor Green 
    } 
    # Change the location to the specified folder 
    Set-Location $OMSFolder 
    # Check if file exists, if not, download it 
    if (Test-Path $FileName) { 
        Write-Host "The file $FileName already exists." 
        Start-Process -FilePath $MMAFile -ArgumentList "/c /t:C:\WindowsAzure\Installers\OMS" -Wait
    } 
    else { 
        Write-Host "The file $FileName does not exist, downloading..." -NoNewline 
        Invoke-WebRequest -Uri $OMSURI -OutFile $MMAFile | Out-Null 
        Write-Host "done!" -ForegroundColor Green 
        Start-Process -FilePath $MMAFile -ArgumentList "/c /t:C:\WindowsAzure\Installers\OMS" -Wait
    } 
    Write-Host "Installing Microsoft Monitoring Agent.." -nonewline 
    $SetupFilePath = 'C:\WindowsAzure\Installers\OMS\setup.exe'
    $ArgumentList = '/qn NOAPM=1 ADD_OPINSIGHTS_WORKSPACE=1 ' + "OPINSIGHTS_WORKSPACE_ID=$WorkspaceID " + "OPINSIGHTS_WORKSPACE_KEY=$WorkSpaceKey " + "OPINSIGHTS_PROXY_URL=$OMSProxyServer " + 'AcceptEndUserLicenseAgreement=1' 
    Start-Process -FilePath $SetupFilePath -ArgumentList $ArgumentList -Verbose -ErrorAction Stop -Wait | Out-Null 
    Write-Host "done!" -ForegroundColor Green 
}
function Install-Nexpose {
    [CmdletBinding()]
    param (
        $nexposelocation,
        $nexposeuri,
        $nexposezipfile,
        $nexposemsifile,
        $nexposeargument
    )
    $nexposeinstallpath = $nexposelocation + "nexpose"
    $nexposezip = $nexposelocation + $nexposezipfile

    if (Test-Path $nexposeinstallpath) {
        Write-Verbose "Destination already exists"
    }
    else {
        Write-Verbose "Creating Destination Path"
        New-Item `
            -Name 'nexpose' `
            -ItemType Directory `
            -Path $nexposelocation
    }
    try {
        Invoke-WebRequest `
            -uri $nexposeuri `
            -OutFile $nexposezip `
            -ErrorAction Stop
        $Results = "File $nexposezipfile downloaded Successfully"
    }
    catch {
        $Results = "File $nexposezipfile failed to download"
    }
    $Results
    Test-path $nexposeinstallpath
    try {
        $filePath = $nexposezip
        $shell = New-Object -ComObject Shell.Application
        $zipFile = $shell.NameSpace($filePath)
        $destinationFolder = $shell.NameSpace($nexposeinstallpath)
        $copyFlags = 0x00
        $copyFlags += 0x04 # Hide progress dialogs
        $copyFlags += 0x10 # Overwrite existing files
        $destinationFolder.CopyHere($zipFile.Items(), $copyFlags)
    }
    catch { 
        Write-host "File has already been unzipped."
        Write-Host $_
        Write-Host "Error Details"
        $_.ErrorDetails
        Write-Host "------------"
        $_.CategoryInfo
        Write-Host "------------"
        $_.Exception
        Write-Host "------------"
        Write-Error "Error Details Above"
    }
    Set-Location -Path $nexposeinstallpath
    Start-Sleep -s 5
    Write-Verbose "Installing $nexposemsifile"
    try {
        Start-Process `
            -FilePath $nexposemsifile `
            -ArgumentList $nexposeargument `
            -Wait `
            -ErrorAction Stop
        write-host "$nexposemsifile is installed successfully."
    }
    catch {
        Write-Host "$nexposemsifile did not install."
        Write-Host $_
        Write-Host "Error Details"
        $_.ErrorDetails
        Write-Host "------------"
        $_.CategoryInfo
        Write-Host "------------"
        $_.Exception
        Write-Host "------------"
        Write-Error "Error Details Above"
    }
}

function Set-KMXRegKey {
    <#
        String. Specifies a null-terminated string. Equivalent to REG_SZ.
        ExpandString. Specifies a null-terminated string that contains unexpanded references to environment variables that are expanded when the value is retrieved. Equivalent to REG_EXPAND_SZ.
        Binary. Specifies binary data in any form. Equivalent to REG_BINARY.
        DWord. Specifies a 32-bit binary number. Equivalent to REG_DWORD.
        MultiString. Specifies an array of null-terminated strings terminated by two null characters. Equivalent to REG_MULTI_SZ.
        Qword. Specifies a 64-bit binary number. Equivalent to REG_QWORD.
        Unknown. Indicates an unsupported registry data type, such as REG_RESOURCE_LIST.
    #>
    [CmdletBinding()]
    param (
        $KeyName,
        [ValidateSet(
            "REG_SZ",
            "REG_EXPAND_SZ",
            "REG_DWORD",
            "REG_BINARY",
            "REG_QWORD",
            "REG_MULTI_SZ"
        )]
        $KeyType,
        $KeyValue,
        [ValidateSet(
            "HKCU",
            "HKLM"
        )]
        $KeyRoot,
        $KeyPath
    )
    begin {
        switch ($KeyType) {
            "REG_SZ" { $KeyTypeConverted = "String" }
            "REG_EXPAND_SZ" { $KeyTypeConverted = "ExpandedString" }
            "REG_DWORD" { $KeyTypeConverted = "DWord" }
            "REG_BINARY" { $KeyTypeConverted = "Binary" }
            "REG_QWORD" { $KeyTypeConverted = "Qword" }
            "REG_MULTI_SZ" { $KeyTypeConverted = "MultiString" }
        }
        $RootName = $Key[0] + ":"
    }
    process {
        Write-Verbose "Root: $RootName Path: $KeyPath Name: $KeyName Value: $KeyValue Type: $KeyTypeConverted"
        Push-Location
        Set-Location $RootName
        if (!(Test-Path $KeyPath)) {
            try {
                New-Item `
                    -Path $KeyPath `
                    -Force `
                    -ItemType Directory;
                New-ItemProperty `
                    -Path $KeyPath `
                    -Name $KeyName `
                    -Value $KeyValue `
                    -PropertyType $KeyTypeConverted `
                    -Force
                $Results = "Key written successfully"
            }
            catch {
                $Results = "Key writting failed"
            }
        }
        else {
            try {
                New-ItemProperty `
                    -Path $KeyPath `
                    -Name $KeyName `
                    -Value $KeyValue `
                    -PropertyType $KeyTypeConverted `
                    -Force
                $Results = "Key written successfully"
            }
            catch {
                $Results = "Key writting failed"
            }
        }
        Pop-Location
    }
    end {
        Write-Verbose $Results
    }
}
#region: Function Calls
foreach ($Download in $DownloadItems) {
    Get-KMXFiles `
        -source $Download[1] `
        -FileName $Download[0] `
        -DestPath $Download[2] `
        -Verbose
    if ($Download[3] -eq "y") {
        if ($Download[4] -ne $null) {
            Start-KMXInstallers `
                -FileName $Download[0] `
                -Path $Download[2] `
                -ArgumentList $Download[4] `
                -Verbose
        }
        else {
            Start-KMXInstallers `
                -FileName $Download[0] `
                -Path $Download[2] `
                -Verbose
        }
    }
    else {
        Start-KMXInstallers `
            -FileName $Download[0] `
            -Path $Download[2] `
            -Verbose
    }
}
Install-KMXOMS `
    -WorkSpaceID $WorkSpaceID `
    -WorkSpaceKey $WorkSpaceKey `
    -OMSProxyServer $OMSProxyServer `
    -OMSURI $OMSURI `
    -Verbose

Install-Nexpose `
    -nexposelocation $nexposelocation `
    -nexposeuri $nexposeuri `
    -nexposezipfile $nexposezipfile `
    -nexposemsifile $nexposemsifile `
    -nexposeargument $nexposeargument

#Change DVD drive to X:
Set-DVDDriveLetter `
    -DriveLetter "X:" `
    -Verbose
Set-KMXTimeZone `
    -TimeZone "Eastern Standard Time" `
    -Verbose  
Set-KMXInitializeDisk2 `
    -Verbose
Start-Sleep `
    -Seconds 15
Set-KMXFormatDisk2 `
    -Verbose
Set-KMXPageFileSize `
    -InitialSize 4096 `
    -MaximumSize 4096 `
    -DriveLetter "C:" `
    -Verbose
Set-KMXNetworkSettings `
    -Verbose
Set-KMXGeneralComputerSettings `
    -Verbose
#Rename Local Administrator account
Set-KMXLocalAdminAccount `
    -localadmin 'Administrator' `
    -newlocaladmin 'lpaul' `
    -Verbose
foreach ($Key in $RegKeys) {
    Set-KMXRegKey `
        -KeyRoot $Key[0] `
        -KeyPath $Key[1] `
        -KeyName $Key[2] `
        -KeyValue $Key[3] `
        -KeyType $Key[4] `
        -Verbose
}
#endregion: Function Calls
#region: Easy
Write-Host "                              ......,,,,,,........   .                         "
Write-Host "                         ...,...  .,,******,.  ...,,,......                    "
Write-Host "                 ........ .********////////////////*,..,,,....                 "
Write-Host "               ...... ,*********////////////////////////,.,,,,...              "
Write-Host "           .......******//////*///////////////////(((//////.,,,,,,            "
Write-Host "          ......,****/(((((/(((((((((((((((((######(((#(((////*,,,,,,          "
Write-Host "         .....****/((((((((((((((((((((#((################((/////,,,,,.        "
Write-Host "       .....,***/(((((((##((((((((((((((((((##################(///*,*,,,       "
Write-Host "      .....***/((((((((((((((((((((((((((#(#####################(///*,,,,      "
Write-Host "     ....,***((((((((((((((((((((((((((((#########################///*,,,,     "
Write-Host "   .....***/(((((((((((((((((((####################################////,*,,    "
Write-Host "   ....***/(((((((((((((((#(########################################(///,*,,.  "
Write-Host "   ...***/(((((((((((((((############################################((//,*,,  "
Write-Host "   ...***////(((((((((((##############################################(((/**,, "
Write-Host "   . ***///////((((((((((##############################################(((***, "
Write-Host "  ...**////////.. .*(#((((((/......*######(.......,###(,,,*####,,,,####(((/**,,"
Write-Host "  . ***/////    ,.   .##((*...,#(..../###....(%#/,,,###*,,,####,,,######(((**,*"
Write-Host "  . ****///   .#((*   (#(( ..,###(...,###....%%##*//(##(,,,/%%(,,,%%%###(((***,"
Write-Host "  ..**,****   *((((   .#(((###((/....,%##*.....,(##%%%%%(,,,%%,,,/%%%%##(((****"
Write-Host "   .**,***,           .#(((......#....%####(..,,,,,,#%%%%,,,*%,,,%%%%%%%(((/***"
Write-Host "  . **,,,*,   ,((/(((((((/....%##(....%######%%%#,,,,%%%%#,*,(***%%%%%%%(((*/**"
Write-Host "  . ***,,,*    #(/*   (#(*.../###(....%##...,%%%#,,,,%%%%%*****,#%%%%%%%(((****"
Write-Host "    ,**.,,,.    ..   ,#(((............%##(..,,,,,,,/%%%%%%(****(%%%%%%%##((****"
Write-Host "   . **.,,,***,   .(#(((((((*..*%#((((##########%%%%%%%%%%%****%%%%%%%%(#(/***,"
Write-Host "   . ***.,,***////(((((((((##################%%%%%%%%%%(//****#%%%%%%%####**** "
Write-Host "    . **/,,***////((((((((##################%%%%%%%%%%%(,****%%%%%%%%%###****, "
Write-Host "     . /*/,***////((((((((##################%%%%%%%%%%%%%%%%%%%%%%%%%###/****  "
Write-Host "      ../*/***////(((((((###################%%%%%%%%%%%%%%%%%%%%%%%%###/****   "
Write-Host "       . ///*/////((((((###################%%%%%%%%%%%%%%%%%%%%%%%####*****    "
Write-Host "        . ///*///((((((###################%%%%%%%%%%%%%%%%%%%%%%%####*****     "
Write-Host "         ...///*/((((((####################%%%%%%%%%%%%%%%%%%%%(###/****,      "
Write-Host "          ...,////((((((##################%%%%%%%%%%%%%%%%%%%#####*****        "
Write-Host "            .,.,////((((##################%%%%%%%%%%%%%%%%#####(*****          "
Write-Host "             ..,,./////(#(################%%%%%%%%%%%%######((*****            "
Write-Host "              ....,,.//////((#######################((((((/******              "
Write-Host "                 ....,,,,////////((##########((((((((((/*****/                 "
Write-Host "                    ..,,,,,,,**////((((#/((((((((/******//*                    "
Write-Host "                        .,,,,,,,,******************///,  "
#endregion: Easy
Stop-Transcript
