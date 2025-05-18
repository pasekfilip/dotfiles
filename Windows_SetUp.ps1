# Elevate if not running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

if (-not(Get-Command winget))
{
	Install-Script -Name winget-install
}

function RefreshPath {
	$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" +
				[System.Environment]::GetEnvironmentVariable("PATH", "User")
}

mkdir C:/Filip/

$programs = 
@(
	"Neovim.Neovim",
	"git.git",
	"glazewm",
	"eza-community.eza",
	"btop4win",
	"discord.discord",
	"spotify.spotify",
	"brave.brave",
	"ditto.ditto",
	"ajeetdsouza.zoxide",
	"JanDeDobbeleer.OhMyPosh",
	"junegunn.fzf",
	"BurntSushi.ripgrep.GNU",
	"JesseDuffield.lazygit",
	"Microsoft.PowerShell",
	"Microsoft.PowerToys"
)

foreach ($program in $programs)
{
	winget install $program --silent --accept-package-agreements --accept-source-agreements
}

RefreshPath

git clone https://github.com/pasekfilip/dotfiles.git C:/Filip/Configs/

New-Item -ItemType SymbolicLink -Path "C:/Users/Filip/AppData/Local/nvim/" -Target "C:/Filip/Configs/.nvim"
New-Item -ItemType SymbolicLink -Path "C:/Users/Filip/.config/wezterm" -Target "C:/Filip/Configs/.wezterm"
New-Item -ItemType SymbolicLink -Path "C:/Users/Filip/.glzr" -Target "C:/Filip/Configs/.glzr"


