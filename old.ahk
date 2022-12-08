; 废弃的部分代码

SendNukes()
{
    Send, ^c
    Click, 1200 1300

    ; 左上
    SendNuke(142, 1763)

    ; 中上
    SendNuke(342, 1774)

    ; 左下
    SendNuke(140, 1945)

    ; 中下
    SendNuke(310, 2002)

    ; 右下(地堡充能不够)
    SendNuke(464, 1934)
}
SendNuke(mx, my)
{
    Click, %mx% %my%
    Send, ^z
    Click, 1950 950
    Send, ^v
    Sleep, 500
    Click, 1950 950
}



SuccessPagePixel() {
    ; 游戏内胜利那两个字
    return [{x:1806, y:473},{x:1878,y:465},{x:1878,y:503},{x:1878,y:543},{x:1964,y:475}]
}
WaitToColorAllMatch(SuccessPagePixel(), 0xFFFFFF, 40)

WaitToColorAllMatch(TargetPixel(), 0x00FF00, 10)