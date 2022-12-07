### 使用
1. 下载并安装1.1版本的[AutoHotKey](https://www.autohotkey.com/download/)
2. 将此项目下载到本地
3. 队长执行`captain.ahk`，队员执行`member.ahk`
4. 进入合作主界面后按`ctrl + shift + r`开始执行脚本，按`Esc`结束执行

### 注意
1. 脚本中所有像素值均为3840*2160分辨率下的坐标, 然后通过CP函数转换为其他分辨率的对应坐标

### 待解决的问题
- [ ] 不同分辨率DPI下的图像识别、点击偏移量
- [ ] 进入游戏时绿点识别偏早的问题
- [ ] 胜利时偶尔无法退出(可能是按S太快导致的)
- [ ] 极性退出的处理(进行中/失败)
- [ ] 返回大厅时各种状况, 等待按钮亮, 等待成就跳完
- [ ] 激活威望

### 过程中遇到的坑
- Photoshop默认色彩空间不一致导致色彩不匹配
- Windows高分屏开启缩放后查看图片变模糊
- 游戏自带截图和ShareX默认设置均使用了压缩导致图片劣化

### [MM图的一些指令](https://www.bilibili.com/read/cv6498177)
- `-info`（显示/隐藏练习图可用命令）
- `-pai`（暂停/取消暂停所有AI的刷新）
- `-pause`（暂停/取消暂停所有单位）
- `-cdr`（技能无冷却时间）
- `-fastbuild`（启用/禁用快速建造）
- `-money`（show me the money！）
- `-vision`（图全亮）
- `-god` （无敌）
- `-speed X`（将游戏速度更改为X =`slower/slow/normal/fast/faster`）
- `-ally` （给予/取消对队友的控制以及资源共享）
- `-pvp`（使玩家之间敌对/盟友）
- `-caster`（把合作模式施法者放进地图里，让玩家可以操控部分队友的面板技能，有些不可以）
- `-control X`（让您控制所有敌方单位；同盟状态不受影响；如果X = other，则控制同盟）
- `-toprefresh`（刷新顶部栏；如果在重播恢复后遇到问题，请使用）


### 要用到的命令
- [ImageSearch](https://wyagd001.github.io/zh-cn/docs/commands/ImageSearch.htm)
- [PixelGetColor](https://wyagd001.github.io/zh-cn/docs/commands/PixelGetColor.htm)

### 调试脚本
- [ListVars、Pause](https://wyagd001.github.io/zh-cn/docs/Scripts.htm#debug)