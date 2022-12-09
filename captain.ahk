#include common.ahk

OnEnteringGame()
{
    ;WaitToColorAllMatch(TargetPixel(), 0x00FF00, 30)
    CallHyperions()
}

CallHyperions()
{
    for k,v in TargetPixel() {
        CallHyperion(v.x, v.y)
    }
}
CallHyperion(mx, my)
{
    i:=6
    mx := CP(mx)
    my := CP(my)
    mx-=(i/2)
    while i > 0
    {
        mx++
        Send ^z
        Sleep 100
        Click %mx% %my%
        Sleep 100
        i--
    }
}