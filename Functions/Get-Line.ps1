function Get-Line
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$DirectoryNumber
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
        foreach ($number in $DirectoryNumber)
        {
            try
            {
                $getlinereq = [AXLSharp.GetLineReq]::new()
                $getlinereq.Items += $number
                $getlinereq.ItemsElementName += [AXLSharp.ItemsChoiceType57]::pattern
                $result = $Script:service.getLine($getlinereq)
                Write-Output $result.return.line
            }
            catch
            {
                Write-Output $_.Exception.Message
            }
        }
    }
}