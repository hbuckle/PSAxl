$functions = Get-ChildItem "$PSScriptRoot\Functions\*.ps1"
@($functions).ForEach({ . $($_.FullName) })