#for each subscription in our tenant, find every custom role created
#iteratively append new custom roles to output file
$Subs = Get-AzSubscription
ForEach($Sub in $Subs){
Set-AzContext $Sub.ID
Write-Host "Subscription: $($Sub.Name)"

#to get only custom role names and descriptions and write to file
"Subscription: $($Sub.Name)" | Out-File .\customRolesPerSub -Append 
Get-AzRoleDefinition -Custom | FT Name, Description | Out-File .\customRolesPerSub -Append

<#to get assignable scopes for each custom roles
$customRole = Get-AzRoleDefinition -Custom
ForEach($cr in $customRole){
    $cr.Name | Out-File .\roleDefinitions -Append
    $cr.AssignableScopes | Out-File .\roleDefinitions -Append
}#>

Write-Host "==================================================================================================================================================" 
"==================================================================================================================================================" | Out-File .\customRolesPerSub -Append 
}
