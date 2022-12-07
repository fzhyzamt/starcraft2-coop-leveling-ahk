#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;CoordMode, Pixel, Screen

^r::
; https://www.autohotkey.com/docs/misc/DPIScaling.htm
;MsgBox % A_ScreenWidth " " A_ScreenHeight
;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 Mutator_polarity_2.png
;img := Mutator_polarity_%rate%.png
rate := 2
img := "Mutator_polarity_" rate ".png"
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 %img%
if (ErrorLevel = 2)
    MsgBox 错误
else if (ErrorLevel = 1)
    MsgBox 未找到
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
return

^e::
mx := 300
my := 1000
Send ^z
Sleep 100
Click %mx% %my%
return

PixelRate() {
    if (A_ScreenWidth = 3840) {
        return 1
    } else if (A_ScreenWidth = 1920) {
        return 2
    } else {
        MsgBox 不支持的屏幕分辨率
        ExitApp
    }
}

; 转换像素值
CP(p) {
    return p / PixelRate()
}