function Clear-Memory {
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
    )

    #---------------------------------------------------------- [Initialisation] ----------------------------------------------------------

    $scriptFilePath = $Script:MyInvocation.MyCommand.Path
    # $scriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path
    $isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

    $powershellExe = "powershell.exe"
    If ($PSVersionTable.PSVersion.Major -gt 5) {
        $powershellExe = "pwsh.exe"
    }
    $powershellFilePath = "$($PSHOME)\$powershellExe"

    If (-not $isAdmin) {
        Start-Process -FilePath $powershellFilePath -ArgumentList $scriptFilePath -Verb RunAs
        exit
    }

    #------------------------------------------------------------ [Functions] -------------------------------------------------------------

    #----------------------------------------------------------- [Declaration] ------------------------------------------------------------

    $freeMemory  = (Get-CimInstance -Class Win32_OperatingSystem | Select-Object FreePhysicalMemory).FreePhysicalMemory
    $totalMemory = (Get-CimInstance -Class Win32_ComputerSystem | Select-Object TotalPhysicalMemory).TotalPhysicalMemory
    $useMemory   = ($totalMemory/1GB)-($freeMemory/1MB)
    $percentUse  = $useMemory/($totalMemory/1GB)*100

    $rammapExe                 = "rammap.exe"
    # $rammapCleanWorkingSets    = "-Ew"
    # $rammapCleanSysWorkingSets = "-Es"
    # $rammapCleanStandby        = "-Et"
    $rammapArguments           = @("-Ew", "-Es", "-Et")

    #------------------------------------------------------------ [Execution] -------------------------------------------------------------

    If ($percentUse -gt 50) {
        foreach($argument in $rammapArguments) {
            Start-Process -FilePath $rammapExe -ArgumentList $argument -Wait
        }
    }
}
