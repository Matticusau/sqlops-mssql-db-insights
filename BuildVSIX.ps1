#
# Author:  Matt Lavery
# Date:    03/07/2018
# Purpose: Build VSIX package for project
#
# When         Who         What
# ------------------------------------------------------------------------------------------
# 03/07/2018   MLavery     Updated for new project structure
# 23/07/2018   MLavery     Added exclusion for node_modules directory for issue #20

[CmdLetBinding()]
Param (
    [Parameter()]
    [string]$BuildDir
)

[string]$scriptPath = $PSScriptRoot;

# set the location history 
Push-Location;

# make sure the releases folder exists
if ($null -eq $BuildDir -or $BuildDir.Length -eq 0)
{
    $BuildDir = Join-Path -Path $scriptPath -ChildPath '_vsix';
}
if (-not(Test-Path -Path $BuildDir))
{
    New-Item -Path $BuildDir -ItemType Directory -Force | Out-Null;
}

# Get the packages to build in this repo (ignore the node_modules though)
$packageFiles = Get-ChildItem -Path $scriptPath -Recurse -Filter 'package.json' -File | Where-Object DirectoryName -NotLike "$(Join-Path -Path $($scriptPath) -ChildPath 'node_modules')\*";

if ($packageFiles.Count -eq 0)
{
    Write-Error -Message 'No Extensions found to package'
    Exit
}

# set our working location to the build folder
Set-Location -Path $BuildDir;

# process each package found
foreach ($package in $packageFiles)
{
    Write-Verbose -Message "Processing $($package.fullname)";

    # try
    # {
        Set-Location -Path $package.DirectoryName;
        vsce.cmd package;
        Get-ChildItem -Path $package.DirectoryName -Filter '*.vsix' | Move-Item -Destination $BuildDir -Force;
    # }
    # catch 
    # {
        
    # }

    Write-Verbose -Message ('Finished processing package {0}' -f $packageJson.name);

}

# return to the previous user location
Pop-Location;

Write-Verbose -Message 'Extension Packaging Complete';