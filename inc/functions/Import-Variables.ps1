function Import-Variables {
    <#
    .SYNOPSIS
        Summary of the script
    .DESCRIPTION
        Script description
    .PARAMETER param1
        Parameter description
    .INPUTS
        Pipeline input data
    .OUTPUTS
        Output data
    .EXAMPLE
        .\template.ps1 param1
    .NOTES
        Name           : Script-Name
        Version        : 1.0.0
        Created by     : Chucky2401
        Date Created   : 11/04/2023
        Modify by      : Chucky2401
        Date modified  : 11/04/2023
        Change         : Creation
        Copy           : Copy-Item .\Script-Name.ps1 \Final\Path\Script-Name.ps1 -Force
    .LINK
        http://github.com/UserName/RepoName
    #>

    #------------------------------------------------------------ [Parameters] ------------------------------------------------------------

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
    Param (
        [Parameter(Mandatory = $True)]
        [String]$FilePath,
        [Parameter(Mandatory = $False)]
        [String]$Scope = "Script"
    )

    #---------------------------------------------------------- [Initialisation] ----------------------------------------------------------

    #------------------------------------------------------------ [Functions] -------------------------------------------------------------

    #----------------------------------------------------------- [Declaration] ------------------------------------------------------------

    $prefix = (Split-Path -Leaf D:\Utilisateurs\TheBlackWizard\Logiciels\Git\PowerShell\hass-powershell\inc\vars\mqtt).ToUpper()

    #------------------------------------------------------------ [Execution] -------------------------------------------------------------

    Get-Content $FilePath | Foreach-Object {
        $variable = $PSItem.Split('=')
        New-Variable -Name "$($prefix)_$($variable[0])" -Value $variable[1] -Scope $Scope
    }
}
