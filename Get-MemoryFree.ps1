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
$scriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path

#------------------------------------------------------------ [Functions] -------------------------------------------------------------

#----------------------------------------------------------- [Declaration] ------------------------------------------------------------

$freeMemory  = (Get-CimInstance -Class Win32_OperatingSystem | Select-Object FreePhysicalMemory).FreePhysicalMemory
$totalMemory = (Get-CimInstance -Class Win32_ComputerSystem | Select-Object TotalPhysicalMemory).TotalPhysicalMemory
$useMemory   = ($totalMemory/1GB)-($freeMemory/1MB)

#------------------------------------------------------------ [Execution] -------------------------------------------------------------

Write-Output ([Math]::Round($freeMemory/1MB, 2) -replace ",", ".")
