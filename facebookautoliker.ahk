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

likefinder:
	sendinput, ^f ;find
	sleep, 3000
	sendinput, like ;type like
	sleep, 1500
	Sendinput, {Tab 2}{Enter %tt%} ;goes to 2nd result and so on
	Sleep, 2000
	tt+=1
	Sendinput, {Tab}{Enter} ;closes finder
	sleep, 1000
return

pixelcheck:
	click, 0,0,0
	sleep, 200
	PixelGetColor, color, 374, 425
	sleep, 500
	PixelGetColor, highlight, 393, 422
	;msgbox, %highlight% %color%
	sleep, 500
	If (highlight=0xFF9033) and (color=0xFFFFFF) ;if it highlighted the right one
	{
		click, 374,424,0
		sleep, 3500
		PixelGetColor, pop, 253, 376
		sleep, 500
		;msgbox, %pop% ;checker
		If pop=0xFFFFFF ;if it pops up
		{
			sleep, 500
			If not color=0xFF8437 ;if it aint blue...
			{
				sleep, 500
				;click, 374,424,1
				sendinput, {enter} ;like it
				sleep, 1000
			}
			else
			{
				sleep, 1000
				err += 1 ;mission failure already blue
			}
		}
		else
		{
			err+=1 ;we'll get them next time
		}
	}
	else
	{
	sendinput, ^f ;find
	sleep, 1000
	sendinput, like ;type like
	sleep, 500
	Sendinput, {Tab 2}{Enter}
	Sleep, 500
	tt+=1
	Sendinput, {Tab}{Enter} ;closes finder
	sleep, 500
	gosub, pixelcheck
	err+=1
	resett+=1 ;to be used to cross check against new posts
	If resett>20
	{	
		tt=0
	}
	else
	{
		sleep, 50
	}
	}
return

postreset:
	
return

NumpadUP::
	gosub, randomtime
return

NumpadPGUP::
	gosub, pixelcheck
return

NumpadHOME::
	gosub, likefinder
return

NumpadDOWN::
	msgbox, %err% %pop% %color%

return

F10::
global err=0

While (err < 600) ;100 per 10 minutes
{
	gosub, randomtime
	gosub, refreshpage
	gosub, likefinder
	gosub, pixelcheck
	click, 0,0,0
}
return

