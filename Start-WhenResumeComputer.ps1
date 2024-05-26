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
    #Script parameters go here
)

#---------------------------------------------------------- [Initialisation] ----------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"
If ($PSBoundParameters['Debug']) {
    $DebugPreference = "Continue"
} Else {
    $DebugPreference = "SilentlyContinue"
}

Add-Type -Assembly System.Windows.Forms
Add-Type -Path "D:\Utilisateurs\TheBlackWizard\Logiciels\Git\PowerShell\hass-powershell\lib\M2Mqtt.4.3.0.0\lib\net45\M2Mqtt.Net.dll"

$scriptRoot = Split-Path $Script:MyInvocation.MyCommand.Path

#------------------------------------------------------------ [Functions] -------------------------------------------------------------

. $scriptRoot\inc\functions\Import-Variables.ps1

#----------------------------------------------------------- [Declaration] ------------------------------------------------------------

Import-Variables -FilePath $scriptRoot\inc\vars\mqtt

$initialSleep = 5
$stepSleep    = 1
$mouseSteps   = 5
$mouseStep    = 0

$mqttClient = [uPLibrary.Networking.M2Mqtt.MqttClient]($MQTT_SERVER)

#------------------------------------------------------------ [Execution] -------------------------------------------------------------

Start-Sleep -Seconds $initialSleep

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Start-Sleep -Seconds $stepSleep

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Start-Sleep -Seconds $stepSleep

do {
    $movementSizeX = Get-Random -Minimum -30 -Maximum 30
    $movementSizeY = Get-Random -Minimum -30 -Maximum 30

    $position = [Windows.Forms.Cursor]::Position
    $position.x += $movementSizeX
    $position.y += $movementSizeY
    [Windows.Forms.Cursor]::Position = $position
    Start-Sleep -Seconds $stepSleep

    $mouseStep++
} while ($mouseStep -lt $mouseSteps)

$mqttClient.Connect([guid]::NewGuid(), $MQTT_USERNAME, $MQTT_PASSWORD)
$mqttClient.Publish("M2MQTTPowershell/Zoukzouk/message", [System.Text.Encoding]::UTF8.GetBytes("RGB On"))
$mqttClient.Disconnect()
