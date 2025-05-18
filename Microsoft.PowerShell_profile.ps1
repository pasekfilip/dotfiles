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

Set-Alias godot4 "C:\Filip\Game_Projects\Godot_v4.3-stable_win64.exe\Godot_v4.3-stable_win64.exe"
Set-Alias vi nvim
Set-Alias ls betterLS
function betterLS{
	eza -a --group-directories-first --icons
}

function fo(){
	$f = "$(fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:30%)"
	if ($f){
		nvim $f
	}
}
