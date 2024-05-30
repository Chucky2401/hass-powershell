function Start-ClearMemory {
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

    [CmdletBinding()]
    Param (
    )

    #---------------------------------------------------------- [Initialisation] ----------------------------------------------------------

    #------------------------------------------------------------ [Functions] -------------------------------------------------------------

    #----------------------------------------------------------- [Declaration] ------------------------------------------------------------

    $sleepTime = 2
    $timeout   = 60

    #------------------------------------------------------------ [Execution] -------------------------------------------------------------
    
    Start-ScheduledTask -TaskPath "\Automation\Standby\" -TaskName "Emptying Memory"
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    While ((Get-ScheduledTask -TaskPath "\Automation\Standby\" -TaskName "Emptying Memory").State -ne "Ready" -and $stopwatch.Elapsed.TotalSeconds -lt $timeout) {
        Write-Host "Waiting task to end..."
        Start-Sleep -Seconds $sleepTime
    }
    
    $stopwatch.Stop()
}
