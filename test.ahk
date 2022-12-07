#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Pixel, Screen

^r::
img := "img/likai_1.png"
ImageSearch, FoundX, FoundY, A_ScreenWidth * 0.04, A_ScreenHeight * 0.74, A_ScreenWidth * 0.2, A_ScreenHeight * 0.83, *10 %img%
if (ErrorLevel = 2)
    MsgBox 错误
else if (ErrorLevel = 1)
    MsgBox 未找到
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
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