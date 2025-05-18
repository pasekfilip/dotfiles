param (
    [string]$Direction
)

$focued_window = glazewm.exe query focused | ConvertFrom-Json
$focused_monitor = (glazewm.exe query monitors | ConvertFrom-Json).data.monitors | Where-Object { $_.hasFocus -eq $true }

$half_of_widnow_x = $focused_monitor.width / 2
$is_window_left_side = $focued_window.x -lt $half_of_widnow_x

switch ($Direction) {
	"right" 
	{
		if ($is_window_left_side)
		{
			glazewm.exe command resize --width +2%
			return
		}
		glazewm.exe command resize --width -2%
	}
	"left" 
	{
		if ($is_window_left_side)
		{
			glazewm.exe command resize --width -2%
			return
		}
		glazewm.exe command resize --width +2%
	}
	Default {}
}

