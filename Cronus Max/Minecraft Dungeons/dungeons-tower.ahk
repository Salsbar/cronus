; Setup 
; Monitor resolution: any > 1024x768
; Game resolution: 1024x768
; Game Brightness: +10
; Game HUD Size: 100%
;
; Instructions
; Ctrl-Alt-B: Backs up your game
; Ctrl-Alt-M: start/stop running the main script loop

if not a_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

hwndMCD:=0
pidMCD:=0

^!r::Reload

#MaxThreadsPerHotkey 2
^!m::
global pidMCD
global hwndMCD
mActive:=!mActive
if mActive {
	if (checkBackups() = 0 ) {
		msgbox,Some backups were missing.`r`nPlease back up using Ctrl+Alt+B
		mActive=0
		return
	}
} else {
	Reload
}
While mActive {
	if !LaunchGame() return

	tooltip,AutoTower: Waiting for "Press Any Button",400,7
	startTime:=A_TickCount
	Loop
	{
		If checkPAK() {
			;press any and wait 1s
			Send,{Enter}
			break
		}
		If checkMain() {
			break
		}
		If ((A_TickCount-startTime)>60000) {
			Msgbox, Timed out waiting for "Press Any Button"
			return
		}
		Sleep,250
	}

	tooltip,AutoTower: Waiting for Main Menu,400,7
	startTime:=A_TickCount
	Loop
	{
		If checkMain() {
			Send,{Enter}
			break
		}
		If ((A_TickCount-startTime)>30000) {
			Msgbox, Timed out waiting for Main Menu
			return
		}
		Sleep,250
	}

	tooltip,AutoTower: Waiting for Town,400,7
	startTime:=A_TickCount
	Loop
	{
		If checkTown() {
			break
		}
		If ((A_TickCount-startTime)>60000) {
			Msgbox, Timed out waiting for Town
			return
		}
		Sleep,250
	}

	tooltip,AutoTower: Walking to tower,400,7
	sleep,2000
	coordmode,mouse,client
	sendevent, {click down 291,24}
	sleep,50
	sendevent, {click up}
	sleep,4000
	sendevent, {click down 73,38}
	sleep,50
	sendevent, {click up}

	tooltip,AutoTower: Waiting for Tower Start,400,7
	startTime:=A_TickCount
	Loop
	{
		If checkTowerStart() {
			sendevent, {click down 265,695}
			sleep,50
			sendevent, {click up}
			break
		}
		If ((A_TickCount-startTime)>10000) {
			Msgbox, Timed out waiting for Tower Start
			return
		}
		Sleep,250
	}

	tooltip,AutoTower: Waiting for Tower Load,400,7
	startTime:=A_TickCount
	Loop
	{
		If checkTowerLoad() {
			break
		}
		If ((A_TickCount-startTime)>20000) {
			Msgbox, Timed out waiting for Tower Load
			return
		}
		Sleep,250
	}

	tooltip,AutoTower: Walking to exit,400,7
	sleep,2000
	coordmode,mouse,client
	sendevent, {click down 20,500}
	sleep,50
	sendevent, {click up}
	sleep,3000
	sendevent, {click down 20,270}
	sleep,50
	sendevent, {click up}
	
	tooltip,AutoTower: Waiting for Reward,400,7
	startTime:=A_TickCount
	Loop
	{
		If checkReward() {
			break
		}
		If ((A_TickCount-startTime)>20000) {
			Msgbox, Timed out waiting for Reward
			return
		}
		Sleep,250
	}

	tooltip,AutoTower: Quitting Minecraft Dungeons,400,7

	Sleep,1000
	process,close,%pidMCD%
	process,waitclose,%pidMCD%,10
	if (ErrorLevel != 0) {
		Msgbox, Failed to quit Minecraft Dungeons
		return
	}
	
	tooltip,AutoTower: Restoring Backup,400,7
	restoreBackups()
}
return

^!b::
	EnvGet,homepath,homepath
	EnvGet,homedrive,homedrive
	origpath:=homedrive . homepath . "\Saved Games\Mojang Studios\Dungeons"
	backpath:=homedrive . homepath . "\Saved Games\Mojang Studios\Dungeons Backup"
	Loop, Files, %origpath%\* , D
	{
		ifexist,%backpath%\%A_LoopFileName% 
		{
			FileRemoveDir,%backpath%\%A_LoopFileName%,1
		}
		FileCopyDir,%origpath%\%A_LoopFileName%,%backpath%\%A_LoopFileName%
	}
	msgbox,Backups Created
return

restoreBackups()
{
	EnvGet,homepath,homepath
	EnvGet,homedrive,homedrive
	origpath:=homedrive . homepath . "\Saved Games\Mojang Studios\Dungeons"
	backpath:=homedrive . homepath . "\Saved Games\Mojang Studios\Dungeons Backup"
	Loop, Files, %backpath%\* , D
	{
		ifexist,%origpath%\%A_LoopFileName% 
		{
			FileRemoveDir,%origpath%\%A_LoopFileName%,1
		}
		FileCopyDir,%backpath%\%A_LoopFileName%,%origpath%\%A_LoopFileName%
	}
}

checkBackups() 
{
    EnvGet,homepath,homepath
    EnvGet,homedrive,homedrive
    origpath:=homedrive . homepath . "\Saved Games\Mojang Studios\Dungeons"
    backpath:=homedrive . homepath . "\Saved Games\Mojang Studios\Dungeons Backup"
    ifnotexist,%origpath%
    {
        Msgbox,Can't find your minecraft dungeons save folder.
        return 0
    }
    Loop, Files, %origpath%\* , D
    {
        ifnotexist,%backpath%\%A_LoopFileName%
        {
            return 0
        }
    }
    return 1
}

LaunchGame()
{
	global hwndMCD
	global pidMCD
	tooltip,AutoTower: Waiting for Launcher to Start,400,7
	Run,shell:AppsFolder\Microsoft.Lovika_8wekyb3d8bbwe!Game,,,PID

	if !WinExistWait("Minecraft Dungeons ahk_class GAMINGSERVICESUI_HOSTING_WINDOW_CLASS ahk_exe gamingservicesui.exe",30000) {
		Msgbox, Launcher didn't start in a timely fashion
		return 0
	}

	tooltip,AutoTower: Waiting for Game to Start,400,7
	if !WinExistWait("Minecraft Dungeons ahk_class UnrealWindow ahk_exe dungeons.exe",90000) {
		Msgbox, Game didn't start in a timely fashion
		return 0	
	}
	sleep,1000

	hwndMCD:=WinExist("Minecraft Dungeons ahk_class UnrealWindow ahk_exe dungeons.exe")
	WinGet,pidMCD,PID,ahk_id %hwndMCD%

	VarSetCapacity(RECT, 16, 0)
	DllCall("user32\GetClientRect", Ptr, hwndMCD , Ptr,&RECT)
	mcdWidth := NumGet(&RECT, 8, "Int")
	mcdHeight := NumGet(&RECT, 12, "Int")
	if (mcdWidth != 1024 or mcdHeight != 768) {
		Msgbox, Current resolution of game is %mcdWidth%x%mcdHeight%, please set your game to 1024x768 windowed to use this script.
		return 0
	}

	return 1
}

WinExistWait(filter,timeout)
{
	start:=A_TickCount
	loop
	{
		if WinExist(filter)
			return 1
		if (A_TickCount-start > timeout)
			return 0
		sleep,100
	}
}

checkPAK()
{
	coordmode,pixel,client
	PixelSearch,,,329,645,329,645,0xd2d6e5,2,Fast
	ps1:=errorlevel
	PixelSearch,,,473,657,473,657,0xd2d6e5,2,Fast
	ps2:=errorlevel
	PixelSearch,,,690,645,690,645,0xd2d6e5,2,Fast
	ps3:=errorlevel
	result:= ps1=0 and ps2=0 and ps3=0
	return result
}

checkMain()
{
	coordmode,pixel,client
	PixelSearch,,,38,731,38,731,0x689f59,2,Fast
	ps1:=errorlevel
	PixelSearch,,,38,653,38,653,0x689f59,2,Fast
	ps2:=errorlevel
	PixelSearch,,,330,731,330,731,0x689f59,2,Fast
	ps3:=errorlevel
	PixelSearch,,,330,653,330,653,0x689f59,2,Fast
	ps4:=errorlevel
	result:= ps1=0 and ps2=0 and ps3=0 and ps4=0
	return result
}

checkTown()
{
	coordmode,pixel,client
	PixelSearch,,,487,675,487,675,0x4e4fce,3,Fast
	ps1:=errorlevel
	PixelSearch,,,536,675,536,675,0x4e4fce,3,Fast
	ps2:=errorlevel
	PixelSearch,,,511,730,511,730,0x4937bd,3,Fast
	ps3:=errorlevel
	result:=ps1=0 and ps2=0 and ps3=0
	return result
}

checkTowerStart()
{
	coordmode,pixel,client
	PixelSearch,,,53,662,53,662,0x689f59,2,Fast
	ps1:=errorlevel
	PixelSearch,,,497,727,497,727,0x689f59,2,Fast
	ps2:=errorlevel
	PixelSearch,,,616,727,616,727,0x5c32f2,2,Fast
	ps3:=errorlevel
	PixelSearch,,,970,662,970,662,0x5c32f2,2,Fast
	ps4:=errorlevel
	result:= ps1=0 and ps2=0 and ps3=0 and ps4=0
	return result
}

checkTowerLoad()
{
	if !checkTown() return 0
	coordmode,pixel,client
	PixelSearch,,,838,51,838,51,0xffffff,2,Fast
	ps1:=errorlevel
	PixelSearch,,,984,45,984,45,0xffffff,2,Fast
	ps2:=errorlevel
	PixelSearch,,,977,58,977,58,0xffffff,2,Fast
	ps3:=errorlevel
	result:= ps1=0 and ps2=0 and ps3=0
	return result
}

checkReward()
{
	coordmode,pixel,client
	PixelSearch,,,98,86,98,86,0x65e8ff,2,Fast
	ps1:=errorlevel
	PixelSearch,,,563,58,563,58,0x65e8ff,2,Fast
	ps2:=errorlevel
	PixelSearch,,,733,685,733,685,0x689f59,2,Fast
	ps3:=errorlevel
	PixelSearch,,,973,731,973,731,0x689f59,2,Fast
	ps4:=errorlevel
	result:= ps1=0 and ps2=0 and ps3=0 and ps4=0
	return result
}
