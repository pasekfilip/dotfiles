oh-my-posh init pwsh --config 'C:\Users\Filip\AppData\Local\Programs\oh-my-posh\themes\probua.minimal.omp.json' | Invoke-Expression
Invoke-Expression (zoxide init powershell --cmd cd --hook pwd | Out-String)

if (!(Get-Module PSReadLine))
{
	Import-Module PSReadLine
}
# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# Autocompleteion for Arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -Colors @{
    "Command" = "Cyan";
    "Parameter" = "Yellow";
    "String" = "Magenta";
    "Operator" = "Green";
    "Variable" = "White";
}

Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Location C:/Filip/

Set-Alias godot4 "C:\Filip\Game_Projects\Godot_v4.3-stable_win64.exe\Godot_v4.3-stable_win64.exe"
Set-Alias vi nvim
Set-Alias ls betterLS
function betterLS{
	eza -l
}

function fo(){
	$f = "$(fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:30%)"
	if ($f){
		nvim $f
	}
}

function fsize{
    param (
        [Parameter(Mandatory = $true)]
        [string]$FolderPath,

        [ValidateSet("Bytes", "KB", "MB", "GB")]
        [string]$Unit = "MB"
    )

    if (-Not (Test-Path $FolderPath)) {
        Write-Error "The folder path '$FolderPath' does not exist."
        return
    }

    $sizeInBytes = (Get-ChildItem $FolderPath -Recurse -File | Measure-Object -Property Length -Sum).Sum

    switch ($Unit) {
        "Bytes" { return "$sizeInBytes Bytes" }
        "KB"    { return ("{0:N2} KB" -f ($sizeInBytes / 1KB)) }
        "MB"    { return ("{0:N2} MB" -f ($sizeInBytes / 1MB)) }
        "GB"    { return ("{0:N2} GB" -f ($sizeInBytes / 1GB)) }
    }
}

function Set-JavaHome {
    param (
        [string]$version
    )

    switch ($version) {
        "11" { $env:JAVA_HOME = "C:\Program Files\Amazon Corretto\jdk11.0.27_6\" }
        "21" { $env:JAVA_HOME = "C:\Program Files\Amazon Corretto\jdk21.0.7_6/" }
        "24" { $env:JAVA_HOME = "C:\Program Files\Amazon Corretto\jdk24.0.1_9" }
        default { Write-Error "Unknown JDK version: $version" }
    }

    $env:Path = "$env:JAVA_HOME\bin;" + ((($env:Path -split ";") | Where-Object { $_ -notmatch "jdk" }) -join ";")

    java --version
}
