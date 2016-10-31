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
        elseif ($Object.PSObject.Properties[$propName].TypeNameOfValue -eq $propValue.GetType().FullName)
        {
            $Object.${propName} = $propValue
        }
        else
        {
            Throw "Cannot set the property $propName"
        }
    }
    return $Object
}