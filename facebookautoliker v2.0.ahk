#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;global variables
global timer=10000
global waiter=5000
global err = 0
global errr = 0
global tt := 1
global pop=0
global color=0
global highlight=0
global resett=0

;like button blue 475,416 0xFB8236

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

esc::pause



randomtime:
	Random, timer, 11000, 20000 ;time between 10 and 20 minutes?
	Random, waiter, 2000, 10000 ;time for others
return

refreshpage:
	Sendinput, {F5} ;refreshes page
	Sleep, %timer% ;waits random time to load page
return

nexter:
	Sendinput, {tab 3}
	Sleep, 2500
	Sendinput, l
	Sleep, 2000
	Sendinput, l
	sleep, 6000
	gosub, pixelcheck
return

pixelcheck:
	sleep, 200
	PixelGetColor, color, 475, 416 
	sleep, 500
	;msgbox, %color%
	sleep, 500
	If (color=0xFFFFFF) ;if it white then like it else dont like it 
	{
		sleep, 500
		sendinput, {enter}
		sleep, 2000
	}
	else
	{
		sleep, 500
		err+=1
		sleep, 2500
	}
return


NumpadUP::
	gosub, randomtime
return

NumpadPGUP::
	gosub, pixelcheck
return

NumpadHOME::
	sleep, 10
return

NumpadDOWN::
	msgbox,  %color%

return

NumpadRIGHT::
	
return

f10::
	
	;plan to make a if winactive then start and when not then dont initiate to lower chance of error.
	
	tine=0
	while (tine<9999 or err>50)
	{
		gosub, nexter
		tine+=1
	}
return



;rsl