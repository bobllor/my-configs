<#
    .DESCRIPTION
        Adds the repository PowerShell profile to the default profiles location for 
        the current user. If an existing profile exists, it will create a backup of the 
        original.

        By default it will append to the existing profile. If the overwrite flag is given,
        then it will overwrite the original file.

    .PARAMETER Overwrite
        Flag used to overwrite the profile file if it exists.
#>

param(
    [switch] $Overwrite
)

$url = "https://raw.githubusercontent.com/bobllor/my-configs/refs/heads/main/powershell/Microsoft.PowerShell_profile.ps1"
$scriptContent = invoke-webrequest "$url" -usebasicparsing | select-object -expandproperty content

$date = get-date -format "MM.dd.yyyy-THH.mm.ss"
$fileName = "Microsoft.PowerShell_profile.ps1"
$profileRoot = split-path "$profile" -parent

if(test-path "$profile"){
    cp "$profile" "$profileRoot\BACKUP_${date}.${fileName}"
}

if(-not $overwrite -and (test-path "$profile")){
    add-content -path "$profile" -value "`n$scriptContent"
}else{
    new-item -path "$profile" -type file -value "$scriptContent" -force
}