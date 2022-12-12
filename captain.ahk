global IS_CAPTAIN := 1
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
    rows := 2
    cols := 6
    mx := CP(mx) - CP(cols)
    my := CP(my) - CP(rows)
    Loop %rows% {
        ty := my + A_Index * 2
        Loop %cols% {
            tx := mx + A_Index * 2
            Send ^z
            Sleep 20
            Click %tx% %ty%
            Sleep 20
        }
    }
}