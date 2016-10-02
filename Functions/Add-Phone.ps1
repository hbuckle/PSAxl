function Add-Phone
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$TemplateFile
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
        foreach ($template in $TemplateFile)
        {
            try
            {
                if (-not(Test-Path $template))
                {
                    Throw "Template $template not found"
                }
                $templateContent = Get-Content $template -Raw | ConvertFrom-Json
                $phoneProps = @{}
                $templateContent.phoneProperties.PSObject.Properties |
                    ForEach-Object { $phoneProps[$_.Name] = $_.Value }
                $newPhone = Set-ObjectProperty -Object (New-Object AXLSharp.XPhone) -Properties $phoneProps
                if ($templateContent.lines.Count -gt 0)
                {
                    $lines = New-Object AXLSharp.XPhoneLines
                    foreach ($lineProps in $templateContent.lines)
                    {
                        
                    }
                }
                
                
                $request = New-Object AXLSharp.AddPhoneReq
                $request.phone = $newPhone
                $result = $Script:service.addPhone($request)
                Write-Output $result.return
            }
            catch
            {
                Write-Output $_.Exception.Message
            }
        }
    }
}