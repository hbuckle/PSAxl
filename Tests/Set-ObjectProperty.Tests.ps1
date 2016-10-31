$parentfolder = Split-Path $PSScriptRoot -Parent
$manifest = Test-ModuleManifest "$parentfolder\PSAxl.psd1"
foreach ($requiredModule in $manifest.RequiredModules)
{
    Import-Module -Name $requiredModule.Name
}
Remove-Module "PSAxl" -Force -ErrorAction SilentlyContinue
Import-Module "$parentfolder\PSAxl.psd1" -Force

InModuleScope PSAxl {
    Describe "Set-ObjectProperty" {
        It "Sets string properties" {
            $phone = New-Object AXLSharp.XPhone
            $props = @{
                name = "name"
                description = "description"
                ctiid = "ctiid"
            }
            $modifiedPhone = Set-ObjectProperty -Object $phone -Properties $props
            $result = $modifiedPhone.name + $modifiedPhone.description + $modifiedPhone.ctiid
            $result | Should BeExactly "namedescriptionctiid"
        }
        It "Sets XFK value properties" {
            $phone = New-Object AXLSharp.XPhone
            $props = @{
                callingSearchSpaceName = "callingSearchSpaceName"
                primaryPhoneName = "primaryPhoneName"
                dialRulesName = "dialRulesName"
            }
            $modifiedPhone = Set-ObjectProperty -Object $phone -Properties $props
            $result = $modifiedPhone.callingSearchSpaceName.Value + $modifiedPhone.primaryPhoneName.Value + $modifiedPhone.dialRulesName.Value
            $result | Should BeExactly "callingSearchSpaceNameprimaryPhoneNamedialRulesName"
        }
        It "Sets XFK guid properties" {
            $phone = New-Object AXLSharp.XPhone
            $props = @{
                callingSearchSpaceName = "2f9da9f6-6c80-4b7e-b646-dc109db37baa"
                primaryPhoneName = "f9d6a997-04a9-4fa8-a73b-45f9c74ac33a"
                dialRulesName = "1482a6b2-2d82-4b6a-bd7b-983ccac5353f"
            }
            $modifiedPhone = Set-ObjectProperty -Object $phone -Properties $props
            $result = $modifiedPhone.callingSearchSpaceName.uuid + $modifiedPhone.primaryPhoneName.uuid + $modifiedPhone.dialRulesName.uuid
            $result | Should BeExactly "2f9da9f6-6c80-4b7e-b646-dc109db37baaf9d6a997-04a9-4fa8-a73b-45f9c74ac33a1482a6b2-2d82-4b6a-bd7b-983ccac5353f"
        }
        It "Sets other AXL types" {
            $phone = New-Object AXLSharp.XPhone
            $confAccess = [AXLSharp.XPhoneConfidentialAccess]::new()
            $confAccess.confidentialAccessLevel = "level"
            $confAccess.confidentialAccessMode = "mode"
            $props = @{
                name = "name"
                confidentialAccess = $confAccess
            }
            $modifiedPhone = Set-ObjectProperty -Object $phone -Properties $props
            $result = $modifiedPhone.confidentialAccess.confidentialAccessLevel + $modifiedPhone.confidentialAccess.confidentialAccessMode
            $result | Should BeExactly "levelmode" 
        }
        It "Throws if the property can not be set" {
            $phone = New-Object AXLSharp.XPhone
            $props = @{
                name = "name"
                primaryPhoneName = "primaryPhoneName"
                vendorConfig = "vendorConfig"
            }
            { Set-ObjectProperty -Object $phone -Properties $props } | Should Throw "Cannot set the property vendorConfig"
        }
    }
}