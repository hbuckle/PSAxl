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
                $newPhone = New-Object AXLSharp.XPhone
                $newPhone.ctiid = "?"
                $templateContent = Get-Content $template -Raw | ConvertFrom-Json
                foreach ($stringProp in $templateContent.stringProperties)
                {
                    $propName = $stringProp.PSObject.Properties.Name
                    $newPhone.${propName} = $stringProp.PSObject.Properties.Value
                }
                foreach ($xfkType in $templateContent.xfkTypes)
                {
                    $xfk = New-Object AXLSharp.XFkType
                    $xfk.Value = $xfkType.PSObject.Properties.Value
                    $propName = $xfkType.PSObject.Properties.Name
                    $newPhone.${propName} = $xfk
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