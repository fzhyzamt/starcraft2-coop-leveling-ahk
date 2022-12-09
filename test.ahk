#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#include common.ahk
; #Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Pixel, Screen

^r::
global P_RATE := 1
if not IsImageMatch("manjibiankuang", A_ScreenWidth * 0.03, A_ScreenHeight * 0.2, A_ScreenWidth * 0.43, A_ScreenHeight * 0.42, "Black") {
    MsgBox 匹配
} else {
    MsgBox 未找到
}
;ImageSearch, FoundX, FoundY, %x1%, %y1%, %x2%, %y2%, %img%
;if (ErrorLevel = 2)
;    MsgBox 错误
;else if (ErrorLevel = 1)
;    MsgBox 未找到
;else
;    MsgBox 找到了, 位于%FoundX%x%FoundY%.
return

^t::
    if IsColorArrayAllMatch(TargetPixel(), 0x00FF00, 30) {
        MsgBox 匹配
    } else {
        MsgBox NO
    }
return

^g::
CheckAndActivePrestiges()
return

OnEnteringGame(){

}