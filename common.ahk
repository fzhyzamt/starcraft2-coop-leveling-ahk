#include utils.ahk
#SingleInstance force
FileInstall, Mutator_polarity.png, Mutator_polarity.png

^+r::
MainLoop()
return

MainLoop()
{
SC_HWND := WinExist("ahk_exe SC2_x64.exe")
;SC_HWND := WinExist("ahk_exe Taskmgr.exe")
if not SC_HWND
{
    MsgBox % "星际2未运行"
    return
}
; 主循环
; TODO https://www.autohotkey.com/boards/viewtopic.php?t=57152 切出时暂停
Loop {
    ; TODO 等待页面按钮
    ; TODO 判断是否要激活威望、切换指挥官
    StartGame()

    ; 等待进入游戏
    WaitEnteringGame()

    ; 使用面板
    OnEnteringGame()

    ; 判断极性
    if HasPolarity() {
        F10Q()
    } else {
        OnGameEnding()
    }
    Sleep 8000
}
}

HallPixel() {
    ;大厅里"合作任务"那几个字
    return [{x:225,y:301},{x:237,y:337},{x:285,y:319},{x:285,y:333},{x:341,y:322}]
}

TargetPixel() {
    ; 左上 中上 左下 中下 右下
    return [{x:142,y:1763},{x:342,y:1774},{x:140,y:1945},{x:310,y:2002},{x:464,y:1934}]
}

SuccessPagePixel() {
    ; 游戏内胜利那两个字
    return [{x:1806, y:473},{x:1878,y:465},{x:1878,y:503},{x:1878,y:543},{x:1964,y:475}]
}

SuccessPage2Pixel() {
    ; 退出到大厅的胜利那两个字
    return [{x:221, y:391},{x:327,y:373},{x:269,y:385},{x:269,y:437},{x:405,y:429}]
}

StartGame()
{
;WinWaitActive
if CheckMemberInvalid() {
    MsgBox 队伍人数不正确
    ExitApp
}
Click 500 1900
Sleep 500
MouseMove, 1, 1
}

; 检查队伍是否有人,防止匹到野队去
CheckMemberInvalid() {
    PixelGetColor, BGRColor, 3585, 35
    if not IsLikeColor(BGRColor, 0x0F141B, 10)
        return 0

    PixelGetColor, BGRColor2, 3555, 89
    if not IsLikeColor(BGRColor2, 0x0E1925, 10)
        return 0

    PixelGetColor, BGRColor3, 3578, 55
    if not IsLikeColor(BGRColor3, 0x6192B8, 10)
        return 0

    return 1
}

; 等待直到进入大厅
WaitInHall() {
    WaitToColorAllMatch(HallPixel(), 0xFFFFFF)
}

; 等待倒计时、读条等，直到进入游戏UI加载完毕
WaitEnteringGame()
{
    WaitToColorAllMatch(TargetPixel(), 0x00FF00)
}

; 等待结束按钮并点退出
OnGameEnding()
{
    WaitToColorAllMatch(SuccessPagePixel(), 0xEBFCDB)
    Send s
    WaitToColorAllMatch(SuccessPage2Pixel(), 0xFFFFFF, 5)
    Click 500 1700
}

; 检查是否有极性不定因子
HasPolarity()
{
; https://www.autohotkey.com/docs/misc/DPIScaling.htm
ImageSearch, FoundX, FoundY, A_ScreenWidth * 0.9, A_ScreenHeight * 0.2, A_ScreenWidth, A_ScreenHeight * 0.8, *10 Mutator_polarity.png
if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
else if (ErrorLevel = 1)
    return 0
else
    return 1
}


F10Q()
{
    Send {F10}
    Sleep 200
    Send q
}


; 按ESC时停止脚本
Esc::
{
    MsgBox % "终止脚本"
    ExitApp
}