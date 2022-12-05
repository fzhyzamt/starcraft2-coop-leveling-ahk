#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


^r::
   MouseMove, 0, 0
return

Esc::
ExitApp
return

^e::
ImageSearch, FoundX, FoundY, A_ScreenWidth * 0.9, A_ScreenHeight * 0.2, A_ScreenWidth, A_ScreenHeight * 0.8, *10 Mutator_polarity.png
;MsgBox % FoundX
if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
else if (ErrorLevel = 1)
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
return
