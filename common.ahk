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
    ; 等待准备游戏按钮亮起
    WaitReadyButton()

    ; 检查激活威望
    CheckAndActivePrestiges()

    ; 开始游戏
    StartGame()

    ; 等待进入游戏
    WaitEnteringGame()

    ; 使用面板
    OnEnteringGame()

    ; 判断极性
    if HasPolarity() {
        F10Q()
    } else {
        OnGameEndingSuccess()
    }

    ; 等待离开得分界面
    WaitToLeaveReportPage()

    ; 等待后续弹框等
    WaitFullClearLoop()
}
}

; 检查并激活威望
CheckAndActivePrestiges() {
    if (NEED_ACTIVE_PRESTIGES != 1) {
        return
    }
    if not IsImageMatch("manjibiankuang", P_CTM, P_CLM, P_CRM, P_CBM2, "Black") {
        return
    }
    ; 当前选择的指挥官已满级
    x := CP(450)
    y := CP(1640)
    Click %x% %y% ; 点击自定义按钮
    Sleep 3000
    ; 检查激活威望按钮, 亮着就激活, 没亮就是满了换到下一个指挥官
    if IsImageMatch("jihuoweiwang", A_ScreenWidth * 0.6, A_ScreenHeight * 0.25, A_ScreenWidth * 0.76, A_ScreenHeight * 0.3) {
        ActivePrestiges()
        ClosePrestigesWindow()
    } else {
        ClosePrestigesWindow()
        Sleep 1000
        ChangeToNextCommander()
    }

    WaitReadyButton()
}

; 激活当前指挥官的威望
ActivePrestiges() {
    x := CP(2700)
    y := CP(605)
    Click %x% %y% ; 点击激活威望按钮
    Sleep 2000

    x := CP(1600)
    y := CP(1226)
    Click %x% %y% ; 点击确定
    Sleep 2000

    x := CP(1600)
    y := CP(1200)
    Click %x% %y% ; 点击第二次确定
    Sleep 2000
}

; 切换到下一个指挥官
ChangeToNextCommander() {
    if IsImageMatch("manjibiankuang", P_CLM, P_CTM, CP(1500), P_CBM1, "Black") {
        ; 当前指挥官是第一排的(除了诺娃), 向右选
        x := LAST_IMAGE_X + CP(210)
        y := LAST_IMAGE_Y + CP(100)
        Click %x% %y%
        return
    }
    if IsImageMatch("manjibiankuang", CP(1480), P_CTM, P_CRM, P_CBM1, "Black") {
        ; 当前是诺瓦, 选第二排第一个
        x := CP(780)
        y := CP(260)
        Click %x% %y%
        return
    }
    if IsImageMatch("manjibiankuang", P_CLM, P_CBM1, P_CRM, P_CBM2, "Black") {
         ; 当前是第二排的, 向右选
         x := LAST_IMAGE_X + CP(210)
         y := LAST_IMAGE_Y + CP(100)
         Click %x% %y%
         return
     }
}

; 离开回到大厅的小计页面
WaitToLeaveReportPage() {
    WaitToImageMatch("likai", A_ScreenWidth * 0.04, A_ScreenHeight * 0.74, A_ScreenWidth * 0.2, A_ScreenHeight * 0.83)
    x := CP(500)
    y := CP(1700)
    Click %x% %y%
}

WaitFullClearLoop() {
    Loop {
        if IsImageMatch("zhunbeijiuxu", A_ScreenWidth * 0.04, A_ScreenHeight * 0.8, A_ScreenWidth * 0.2, A_ScreenHeight * 0.92) {
            return
        }
        if IsImageMatch("level15_queding", A_ScreenWidth * 0.44, A_ScreenHeight * 0.6, A_ScreenWidth * 0.57, A_ScreenHeight * 0.66) {
            x := CP(1920)
            y := CP(1367)
            Click %x% %y%
            return
        }
        Sleep 2000
    }
}


; 等待准备就绪按钮
WaitReadyButton() {
    WaitToImageMatch("zhunbeijiuxu", A_ScreenWidth * 0.04, A_ScreenHeight * 0.8, A_ScreenWidth * 0.2, A_ScreenHeight * 0.92)
}


StartGame()
{
    if CheckMemberInvalid() {
        MsgBox 队伍人数不正确
        reload
    }
    x := CP(500)
    y := CP(1900)
    Click, %x% %y%
    Sleep 500
    MouseMoveToMargin()
}

MouseMoveToMargin() {
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
    return [{x:142,y:1764},{x:342,y:1774},{x:140,y:1946},{x:310,y:2002},{x:464,y:1934}]
}

; 等待倒计时、读条等，直到进入游戏UI加载完毕
WaitEnteringGame()
{
    WaitToImageMatch("jingkuang", A_ScreenWidth * 0.78, 0, A_ScreenWidth * 0.85, A_ScreenHeight * 0.06, "Black")
    Sleep 5000
}

; 等待结束按钮并点退出
OnGameEndingSuccess()
{
    ;MsgBox 开始检查得分画面
    WaitToImageMatch("defenhuamian", A_ScreenWidth * 0.46, A_ScreenHeight * 0.58, A_ScreenWidth * 0.54, A_ScreenHeight * 0.64, "0x333333", 40)
    ;MsgBox 结束检查得分画面
    Sleep 1000
    Send s
}

; 检查是否有极性不定因子
HasPolarity()
{
    if IsImageMatch("Mutator_polarity", A_ScreenWidth * 0.9, A_ScreenHeight * 0.2, A_ScreenWidth, A_ScreenHeight * 0.8) {
        return 1
    }
    return 0
}

ClosePrestigesWindow() {
    x := CP(1660)
    y := CP(1762)
    Click %x% %y% ; 点击确定关闭威望窗口
    MouseMoveToMargin()
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