$Test = git branch

foreach ($Branch in $Test) {
    if ( $Branch -ne "* master") {
        $BranchName = $Branch.Replace(" ", "")
        Write-Host "Deleting Branch $BranchName"
        git branch -d $BranchName
    }
}
git fetch --prune