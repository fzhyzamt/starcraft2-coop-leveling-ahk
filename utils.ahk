global P_RATE := PixelRate()
global LAST_IMAGE_X := 0
global LAST_IMAGE_Y := 0

#include pixel.ahk

WaitToImageMatch(img, x1, y1, x2, y2, color:="", n:=20) {
    Loop {
        if IsImageMatch(img, x1, y1, x2, y2, color, n) {
            return
        }
        Sleep 1000
    }
}

IsImageMatch(img, x1, y1, x2, y2, color:="", n:=20) {
    img := "*" n " " CI(img)
    if (color != "") {
        img := "*Trans" color " " img
    }
    ;MsgBox % "开始查找 " x1 " " y1 " " x2 " " y2 " " img
    ImageSearch, FoundX, FoundY, %x1%, %y1%, %x2%, %y2%, %img%
    if (ErrorLevel = 2)
        MsgBox Could not conduct the search.
    else if (ErrorLevel = 1)
        return 0
    else {
        LAST_IMAGE_X := FoundX
        LAST_IMAGE_Y := FoundY
        return 1
    }
}

WaitToColorAllMatch(pixelArray, color, limit:=20) {
    Loop {
        if IsColorArrayAllMatch(pixelArray, color, limit) {
            return
        }
        Sleep 3000
    }
}

IsColorArrayAllMatch(pixelArray, color, limit:=20) {
    for k,v in pixelArray {
        x := CP(v.x)
        y := CP(v.y)
        PixelGetColor, BGRColor, %x%, %y%
        if not IsLikeColor(BGRColor, color, limit) {
            ;MsgBox % "不匹配:(" x "," y ") " BGRColor
            return 0
        }
    }
    return 1
}

; 检查颜色是否相像
IsLikeColor(c1, c2, limit:=0) {
    return (Abs(((c1 & 0xFF0000) >> 16) - ((c2 & 0xFF0000) >> 16)) < limit)
       and (Abs(((c1 & 0x00FF00) >> 8)  - ((c2 & 0x00FF00) >> 8))  < limit)
       and (Abs((c1 & 0x0000FF)         - (c2 & 0x0000FF))             < limit)
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
    return p / P_RATE
}

; 设置图片名
CI(f) {
    return "img/" f "_" P_RATE ".png"
}