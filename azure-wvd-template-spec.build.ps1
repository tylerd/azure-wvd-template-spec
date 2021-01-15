<#
.Synopsis
	Build script <https://github.com/nightroman/Invoke-Build>
#>

param(
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Release',
	[string]$SpecResourceGroupName = "TemplateSpecs-RG",
	[string]$Location = "westus2",
	[string]$Version = "0.1",
	[string]$VersionSuffix = "local",
	[bool]$OverwiteIfExists = $true
)

# Synopsis: Build project.
task deploy {
	exec { 
		$SpecVersion = 

		New-AzTemplateSpec -ResourceGroupName $SpecResourceGroupName -Location $Location -Name "NetApp" -Version $SpecVersion -TemplateFile ".\arm-templates\NetApp\New-NetApp-Account.json" -Force:$OverwiteIfExists
	
		New-AzTemplateSpec -ResourceGroupName $SpecResourceGroupName -Location $Location -Name "wvd-pod" -Version $SpecVersion -TemplateFile ".\arm-templates\wvd-pod\mainTemplate.json" -Force:$OverwiteIfExists

		New-AzTemplateSpec -ResourceGroupName $SpecResourceGroupName -Location $Location -Name "wvd-hosts" -Version $SpecVersion -TemplateFile ".\arm-templates\wvd-hosts\mainTemplate.json" -Force:$OverwiteIfExists
	}

}

task . {}

