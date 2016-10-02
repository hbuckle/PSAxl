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

    $Script:service = New-Object AXLSharp.AXLPortClient
    $Script:service.ClientCredentials.UserName.UserName = $Username
    $Script:service.ClientCredentials.UserName.Password = $Password
}