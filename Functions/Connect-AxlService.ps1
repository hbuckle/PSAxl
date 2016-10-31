function Connect-AxlService
{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [string]$Username,
        [ValidateNotNullOrEmpty()]
        [string]$Password
    )
    $ErrorActionPreference = "Stop"
    Set-StrictMode -Version Latest

    $axlservice = New-Object AXLSharp.AXLPortClient
    $axlservice.ClientCredentials.UserName.UserName = $Username
    $axlservice.ClientCredentials.UserName.Password = $Password

    $versionreq = [AXLSharp.GetCCMVersionReq]::new()
    Write-Information "Testing connection to server"
    $response = $axlservice.getCCMVersion($versionreq)
    Write-Output "Connected to CCM Version $($response.return.componentVersion.version)"
    $Script:service = $axlservice
}