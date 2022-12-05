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