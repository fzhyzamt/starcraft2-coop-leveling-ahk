#include common.ahk

OnEnteringGame()
{
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
    i := 5
    while i > 0
    {
        mx++
        Send ^z
        Click %mx% %my%
        Sleep 100
        i--
    }
}