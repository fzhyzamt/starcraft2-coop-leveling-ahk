#include utils.ahk
#NoEnv
#SingleInstance force
FileInstall, img/Mutator_polarity_1.png, img/Mutator_polarity_1.png
FileInstall, img/Mutator_polarity_2.png, img/Mutator_polarity_2.png

^+r::
MainLoop()
return

MainLoop()
{
SC_HWND := WinExist("ahk_exe SC2_x64.exe")
if not SC_HWND
{
    MsgBox % "星际2未运行"
    return
}
; 主循环
; TODO https://www.autohotkey.com/boards/viewtopic.php?t=57152 切出时暂停
Loop {
    WaitReadyButton()
    ; TODO 判断是否要激活威望、切换指挥官
    StartGame()

    ; 等待进入游戏
    WaitEnteringGame()

    ; 使用面板
    OnEnteringGame()

; TODO 固定因子不用检测极性
    ; 判断极性
    if HasPolarity() {
        F10Q()
    } else {
        OnGameEndingSuccess()
    }
;    Sleep 8000
    WaitToLeaveReportPage()
}
}

; 离开回到大厅的小计页面
WaitToLeaveReportPage() {
    WaitToImageMatch("likai", A_ScreenWidth * 0.04, A_ScreenHeight * 0.74, A_ScreenWidth * 0.2, A_ScreenHeight * 0.83)
    x := CP(500)
    y := CP(1700)
    Click %x% %y%
}

; 等待准备就绪按钮
WaitReadyButton() {
    WaitToImageMatch("zhunbeijiuxu", A_ScreenWidth * 0.04, A_ScreenHeight * 0.8, A_ScreenWidth * 0.2, A_ScreenHeight * 0.92)
}


StartGame()
{
;WinWaitActive
if CheckMemberInvalid() {
    MsgBox 队伍人数不正确
    reload
}
; TODO 检查按钮亮没亮, 比如队友还没出来
x := CP(500)
y := CP(1900)
Click, %x% %y%
Sleep 500
MouseMove, 20, 20
}

; 检查队伍是否有人,防止匹到野队去
CheckMemberInvalid() {
    x := CP(3585)
    y := CP(35)
    PixelGetColor, BGRColor, %x%, %y%
    if not IsLikeColor(BGRColor, 0x0F141B, 10)
        return 0

    x := CP(3555)
    y := CP(89)
    PixelGetColor, BGRColor2, %x%, %y%
    if not IsLikeColor(BGRColor2, 0x0E1925, 10)
        return 0

    x := CP(3578)
    y := CP(55)
    PixelGetColor, BGRColor3, %x%, %y%
    if not IsLikeColor(BGRColor3, 0x6192B8, 10)
        return 0

    return 1
}

TargetPixel() {
    ; 左上 中上 左下 中下 右下
    return [{x:142,y:1763},{x:342,y:1774},{x:140,y:1945},{x:310,y:2002},{x:464,y:1934}]
}

; 等待倒计时、读条等，直到进入游戏UI加载完毕
WaitEnteringGame()
{
    WaitToColorAllMatch(TargetPixel(), 0x00FF00, 10)
;    WaitToImageMatch("jingkuang", A_ScreenWidth * 0.78, 0, A_ScreenWidth * 0.85, A_ScreenHeight * 0.06, "Black")
;    Sleep 5000
}

; 等待结束按钮并点退出
OnGameEndingSuccess()
{
MsgBox 开始检查得分画面
    WaitToImageMatch("defenhuamian", A_ScreenWidth * 0.46, A_ScreenHeight * 0.58, A_ScreenWidth * 0.54, A_ScreenHeight * 0.64, "0x333333")
    Sleep 1000
    Send s
}

; 检查是否有极性不定因子
HasPolarity()
{
img := CI("Mutator_polarity")
ImageSearch, FoundX, FoundY, A_ScreenWidth * 0.9, A_ScreenHeight * 0.2, A_ScreenWidth, A_ScreenHeight * 0.8, *10 %img%
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
    reload
}