; Setup:
; 1920x1080 full screen
; Move the HAP pop-up (pinned) to the top left corner of the screen.
; Place the cursor over the center of any unarchived (red) page and start the script.
; The script will iterate left to right, and then go down a row.
; Need to monitor the script. Pop-up ads and viruses (wavy screen) may mess up the script.
; Will need to reinitiate for each time/date snapshot.

Coordmode,Mouse,Client
Coordmode,Pixel,Client
Coordmode,ToolTip,Client

^!r::Reload
#MaxThreadsPerHotkey 2

Esc::ExitApp

^!c::
Loop {
Sleep 100
MouseGetPos, mx, my
mx += 48
If (mx > 1850)
{
	mx = 40
	my += 60
}
Send {Shift Down}
Sleep 100
Send {LButton}
Sleep 4000
Send {F5}
ClickDelay(190, 292, 2000)
Sleep 100
Send {Shift Up}
Sleep 1000
MouseMove, mx, my
}

ClickDelay(x, y, delay:=500) {
	Sleep, delay
	Click, %x%, %y%
}
