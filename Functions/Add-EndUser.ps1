function Add-EndUser
{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [string]$UserId,
        [ValidateNotNullOrEmpty()]
        [string]$LastName,
        [hashtable]$Properties
    )

    Begin
    {
        $ErrorActionPreference = "Stop"
        Set-StrictMode -Version Latest
        Test-ServiceConnected
    }
    Process
    {
        try
        {
            $request = [AXLSharp.AddUserReq]::new()
            $user = Set-ObjectProperty -Object (New-Object AXLSharp.XUser) -Properties $Properties
            $user.userid = $UserId
            $user.lastName = $LastName
            $request.user = $user
            $result = $Script:service.addUser($request)
            Write-Output $result.return
        }
        catch
        {
            Write-Output $_.Exception.Message
        }
    }
}