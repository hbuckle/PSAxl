function Set-ObjectProperty
{
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [object]$Object,
        [ValidateNotNullOrEmpty()]
        [hashtable]$Properties
    )
    $ErrorActionPreference = "Stop"
    Set-StrictMode -Version Latest

    foreach ($prop in $Properties.GetEnumerator())
    {
        $propName = $prop.Name
        $propValue = $prop.Value
        if ($Object.PSObject.Properties[$propName].TypeNameOfValue -like "*XFkType")
        {
            $xfk = New-Object AXLSharp.XFkType
            $guid = [guid]::Empty
            if ([guid]::TryParse($propValue, [ref]$guid))
            {
                $xfk.uuid = $propValue
            }
            else
            {
                $xfk.Value = $propValue
            }
            $Object.${propName} = $xfk
        }
        elseif ($Object.PSObject.Properties[$propName].TypeNameOfValue -like "*String")
        {
            $Object.${propName} = $propValue
        }
        else
        {
            $type = $Object.PSObject.Properties[$propName].TypeNameOfValue
            Throw "Cannot set property of type $type"
        }
    }
    return $Object
}