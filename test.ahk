#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#include common.ahk
; #Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Pixel, Screen

^r::
;img := "img/likai_2.png"
;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 %img%
rate := 1
img := "img/xuanren_" rate ".png"
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *5 *TransBlack %img%
if (ErrorLevel = 2)
    MsgBox 错误
else if (ErrorLevel = 1)
    MsgBox 未找到
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
return


OnEnteringGame(){

}