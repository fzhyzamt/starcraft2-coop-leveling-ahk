
WaitToColorAllMatch(pixelArray, color, limit:=20) {
    Loop {
        anyNo := 0
        for k,v in pixelArray {
            x := CP(v.x)
            y := CP(v.y)
            PixelGetColor, BGRColor, %x%, %y%
            if not IsLikeColor(BGRColor, color, limit) {
                anyNo = 1
                break
            }
        }
        if (anyNo = 0) {
            return
        }
        Sleep 3000
    }
}

; 检查颜色是否相像
IsLikeColor(c1, c2, limit:=0) {
    return (Abs((c1 & 0xFF0000 >> 16) - (c2 & 0xFF0000 >> 16)) < limit)
    and (Abs((c1 & 0xFF00 >> 8) - (c2 & 0xFF00 >> 8)) < limit)
    and (Abs((c1 & 0xFF) - (c2 & 0xFF)) < limit)
}

PixelRate() {
    if (A_ScreenWidth = 3840) {
        return 1
    } else if (A_ScreenWidth = 1920) {
        return 2
    } else {
        MsgBox 不支持的屏幕分辨率
        ExitApp
    }
}

; 转换像素值
CP(p) {
    return p / PixelRate()
}