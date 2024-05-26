function Import-Variables {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    Param (
        [Parameter(Mandatory = $True)]
        [String]$FilePath,
        [Parameter(Mandatory = $False)]
        [String]$Scope = "Script"
    )

    $prefix = (Split-Path -Leaf D:\Utilisateurs\TheBlackWizard\Logiciels\Git\PowerShell\hass-powershell\inc\vars\mqtt).ToUpper()

    Get-Content $FilePath | Foreach-Object {
        $variable = $PSItem.Split('=')
        New-Variable -Name "$($prefix)_$($variable[0])" -Value $variable[1] -Scope $Scope
    }
}
