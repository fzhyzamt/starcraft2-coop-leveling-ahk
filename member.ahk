#include common.ahk

^z::
Test()
return

Test()
{
Run Notepad
Sleep, 100
Send 1
}


OnEnteringGame()
{
;; 等待游戏结束、极性
}
