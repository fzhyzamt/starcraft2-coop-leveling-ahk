#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#include common.ahk
; #Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Pixel, Screen

^r::
WaitToImageMatch("zhunbeijiuxu", 0, 0, A_ScreenWidth, A_ScreenHeight, "0x333333")
;ImageSearch, FoundX, FoundY, %x1%, %y1%, %x2%, %y2%, %img%
MsgBox zzzzzz
if (ErrorLevel = 2)
    MsgBox 错误
else if (ErrorLevel = 1)
    MsgBox 未找到
else
    MsgBox 找到了, 位于%FoundX%x%FoundY%.
return

^t::
    if IsColorArrayAllMatch(TargetPixel(), 0x00FF00, 10) {
        MsgBox 匹配
    } else {
        MsgBox NO
    }
return

OnEnteringGame(){

}