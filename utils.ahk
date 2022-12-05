
WaitToColorAllMatch(pixelArray, color, limit:=20) {
    Loop {
        anyNo := 0
        for k,v in pixelArray {
            PixelGetColor, BGRColor, v.x, v.y
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