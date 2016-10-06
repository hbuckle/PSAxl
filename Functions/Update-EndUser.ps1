function Update-EndUser
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$UserId,
        [hashtable]$Properties
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
                $request = Set-ObjectProperty -Object (New-Object AXLSharp.UpdateUserReq) -Properties $Properties
                $request.ItemElementName = [AXLSharp.ItemChoiceType6]::userid
                $request.Item = $user
                $result = $Script:service.updateUser($request)
                Write-Output $result.return
            }
            catch
            {
                Write-Output $_.Exception.Message
            }
        }
    }
}