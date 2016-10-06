function Get-EndUser
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$UserId
    )

    Begin
    {
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
    Process
    {
        foreach ($user in $UserId)
        {
            try
            {
                $request = [AXLSharp.GetUserReq]::new()
                $request.ItemElementName = [AXLSharp.ItemChoiceType100]::userid
                $request.Item = $user
                $result = $Script:service.getUser($request)
                Write-Output $result.return.user
            }
            catch
            {
                Write-Output $_.Exception.Message
            }
        }
    }
}