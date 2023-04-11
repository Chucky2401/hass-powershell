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

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]
Param (
    #Script parameters go here
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"
If ($PSBoundParameters['Debug']) {
    $DebugPreference = "Continue"
} Else {
    $DebugPreference = "SilentlyContinue"
}

Add-Type -Assembly System.Windows.Forms

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#----------------------------------------------------------[Declarations]----------------------------------------------------------

$finalState = [System.Windows.Forms.PowerState]::Suspend

#-----------------------------------------------------------[Execution]------------------------------------------------------------

[System.Windows.Forms.Application]::SetSuspendState($finalState, $false, $false) | Out-Null
