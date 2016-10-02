Add-Type -Path "$PSScriptRoot\AXLSharp\AXLSharp.dll"
[System.AppDomain]::CurrentDomain.SetData("APP_CONFIG_FILE", "$PSScriptRoot\AXLSharp\AXLSharp.dll.config")
[Configuration.ConfigurationManager].GetField("s_initState", "NonPublic, Static").SetValue($null, 0)
[Configuration.ConfigurationManager].GetField("s_configSystem", "NonPublic, Static").SetValue($null, $null)
([Configuration.ConfigurationManager].Assembly.GetTypes() |
    Where-Object {$_.FullName -eq "System.Configuration.ClientConfigPaths"})[0].GetField("s_current", "NonPublic, Static").SetValue($null, $null)