#SingleInstance force

^+r::
MainLoop()
return

MainLoop()
{
;SC_HWND := WinExist("星际争霸2")
SC_HWND := WinExist("ahk_exe Taskmgr.exe")
if not SC_HWND
{
    MsgBox % "星际2未运行"
    return
}
; 主循环
; TODO https://www.autohotkey.com/boards/viewtopic.php?t=57152 切出时暂停
Loop {
    ; TODO 判断是否要激活威望、切换指挥官
    StartGame()
    WaitEnteringGame()
    OnEnteringGame()
    if HasPolarity() {
        F10Q()
    } else {
        ; TODO 是否可以直接F10Q？
        OnGameEnding()
    }
}
}

StartGame()
{
;WinWaitActive
; 检查队伍是否正确，防止缺人的情况
; 检查队伍二号位是否有人即可
; 在大厅时，点击开始
; 检查当前是否已经进入游戏中
; 待选择标志物
; 点击开始按钮
}

; 等待倒计时、读条等，直到进入游戏UI加载完毕
WaitEnteringGame()
{
}

; 等待结束按钮并点退出
OnGameEnding()
{
}

; 检查是否有极性不定因子
HasPolarity()
{
; https://www.autohotkey.com/docs/misc/DPIScaling.htm
ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, *10 ss.png
;MsgBox % FoundX
if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
else if (ErrorLevel = 1)
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
return 0
}

F10Q()
{
    Send F10
    Sleep 100
    Send q
}


; 按ESC时停止脚本
Esc::
{
;    Gui, Test:New
;    InputBox, OutputVar
    MsgBox % "终止脚本"
    ExitApp
;    DllCall("LockWorkStation")
}