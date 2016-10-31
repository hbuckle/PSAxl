$parentfolder = Split-Path $PSScriptRoot -Parent
$manifest = Test-ModuleManifest "$parentfolder\PSAxl.psd1"
foreach ($requiredModule in $manifest.RequiredModules)
{
    Import-Module -Name $requiredModule.Name
}
Remove-Module "PSAxl" -Force -ErrorAction SilentlyContinue
Import-Module "$parentfolder\PSAxl.psd1" -Force

InModuleScope PSAxl {
    Describe "Test-ServiceConnected" {
        It "Throws if the Connect-AxlServiceFunction has not been run" {
            { Test-ServiceConnected } | Should Throw "You must run Connect-AxlService first"
        }
    }
}