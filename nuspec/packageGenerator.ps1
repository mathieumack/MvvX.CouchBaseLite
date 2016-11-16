$location  = $env:APPVEYOR_BUILD_FOLDER

"Packaging to nuget..."
"Build folder : " + $location

$strPath = $location + '\MvvX.CouchBaseLite\MvvX.Plugins.CouchBaseLite\bin\Release\MvvX.Plugins.CouchBaseLite.dll'

$VersionInfos = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($strPath)
$ProductVersion = $VersionInfos.ProductVersion
"Product version : " + $ProductVersion

"Update nuspec versions ..."
	
$nuSpecFile =  $location + '\nuspec\MvvX.Plugins.CouchBaseLite.nuspec'
(Get-Content $nuSpecFile) | 
Foreach-Object {$_ -replace "(<version>([0-9.]+)<\/version>)", "<version>$ProductVersion</version>" } | 
Set-Content $nuSpecFile

$nuSpecFile =  $location + '\nuspec\MvvX.Plugins.CouchBaseLite.ForestDB.nuspec'
(Get-Content $nuSpecFile) | 
Foreach-Object {$_ -replace "(<version>([0-9.]+)<\/version>)", "<version>$ProductVersion</version>" } | 
Set-Content $nuSpecFile

$nuSpecFile =  $location + '\nuspec\MvvX.Plugins.CouchBaseLite.SQLCipher.nuspec'
(Get-Content $nuSpecFile) | 
Foreach-Object {$_ -replace "(<version>([0-9.]+)<\/version>)", "<version>$ProductVersion</version>" } | 
Set-Content $nuSpecFile

"Generate nuget packages ..."
.\NuGet.exe pack MvvX.Plugins.CouchBaseLite.nuspec
.\NuGet.exe pack MvvX.Plugins.CouchBaseLite.ForestDB.nuspec
.\NuGet.exe pack MvvX.Plugins.CouchBaseLite.SQLCipher.nuspec

$apiKey = $env:NuGetApiKey
	
"Publish packages ..."
	
#.\NuGet push MvvX.Plugins.CouchBaseLite.$ProductVersion.nupkg -Source https://www.nuget.org/api/v2/package -ApiKey $apiKey
#.\NuGet push MvvX.Plugins.CouchBaseLite.ForestDB.$ProductVersion.nupkg -Source https://www.nuget.org/api/v2/package -ApiKey $apiKey
#.\NuGet push MvvX.Plugins.CouchBaseLite.SQLCipher.$ProductVersion.nupkg -Source https://www.nuget.org/api/v2/package -ApiKey $apiKey