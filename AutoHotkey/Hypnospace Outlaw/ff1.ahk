#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
;Ctrl-Alt-R: will reload your quick save and walk one space up, handy for retrying monster spawns, since they spawn after a fixed number of steps. 
;	Save, see how many steps before next encounter, then walk one less step and save again
;	If you don't get a desired enemy, keep hitting Ctrl-Alt-R until you don

;Ctrl-Alt-F: I used this in Flying Tower Fortress 5 to find Warmachine, but could be used anywhere. 
;	This will walk back and forth until battle occurs and then wait for it to end. 
;	Be sure "Continue auto-battle" is on
;	Also be sure your last set of auto-battle commands is sustainable
;	I used attack with my warrior and monk, and two items that cast heal with my white and black wizards

Toggle:=false

^F6::Reload()

^!R::{
Send(" {UP}{ENTER}")
Sleep(100)
Send("{LEFT}{ENTER}")
Sleep(4000)
Send("{ENTER}")
Sleep(100)
Send("{ENTER}")
Sleep(100)
Send("{ENTER}")
Sleep(100)
Send("{LEFT}{ENTER}")
Sleep(3000)
Send("{UP}")
}

^!F::{
	coordmode("PIXEL","CLIENT")
	global Toggle
	Toggle:=!Toggle
	While (Toggle) {
		col:=pixelgetcolor(950,100)
		if (col=0x4E2F20) {
			Send("{LEFT}")
			sleep(250)
			Send("{RIGHT}")
			sleep(250)
			tooltip("",,,1)
		} else {
			tooltip("F " . col,0,0,1)
		}
		col:=pixelgetcolor(480,465)
		if (col=0xFFFFFF) {
			Send("{ENTER}")
			sleep(250)
			tooltip("",,,2)
		} else {
			tooltip("V " . col,100,0,2)
		}
		sleep(100)
	}
	tooltip("",,,1)
	tooltip("",,,2)
}