function Test-ServiceConnected
{
    [CmdletBinding()]
    $ErrorActionPreference = "Stop"
    Set-StrictMode -Version Latest
    try
    {
        $test = $Script:service
    }
    catch
    {
        Throw "You must run Connect-AxlService first"
    }
}