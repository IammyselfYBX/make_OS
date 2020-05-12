;主引导程序
;
;LOADER_BASE_ADDR equ 0xA000 
;LOADER_START_SECTOR equ 0x2
;------------------------------------------------------------
SECTION MBR vstart=0x7c00         
   mov ax,cs      
   mov ds,ax
   mov es,ax
   mov ss,ax
   mov fs,ax
   mov sp,0x7c00
   mov ax,0xb800
   mov gs,ax

; 清屏
; 利用 Ox06 号功能，上卷全部行，则可清屏
; -----------------------------------------------------------
;INT 0x10   功能号:0x06	   功能描述:上卷窗口
;------------------------------------------------------
;输入：
;AH 功能号= 0x06
;AL = 上卷行数(如果为0， 表示全部)
;BH = 上卷行属性
;(CL,CH) = 窗口左上角的(X,Y)位置
;(DL,DH) = 窗口右下角的(X,Y)位置
;无返回值
   mov     ax, 0x600
   mov     bx, 0x700
   mov     cx, 0           ; 左上角: (0, 0)
   mov     dx, 0x184f	   ; 右下角: (80,25),即(0x4f,0x18)
			   ; VGA文本模式中，一行只能容纳80个字符，共25行。
			   ; 下标从0开始,所以 0x18=24,0x4f=79
   int     0x10            ; int 0x10

 ; 输出背景色绿色，前景色红色，并且跳动的字符串"1 MBR"
   mov byte [gs:0x00],'Y'
   mov byte [gs:0x01],0xAC     ; A 表示绿色背景闪烁，C表示前景色为红色并且高亮 AC表示1010 1100

   mov byte [gs:0x02],'B'
   mov byte [gs:0x03],0xAC

   mov byte [gs:0x04],'X'
   mov byte [gs:0x05],0xAC

   mov byte [gs:0x06],' '
   mov byte [gs:0x07],0xA4    ;; A 表示绿色背景闪烁，4 表示前景色为红色

   mov byte [gs:0x08],'i'
   mov byte [gs:0x09],0xA4

   mov byte [gs:0x0a],'s'
   mov byte [gs:0x0b],0xA4

   mov byte [gs:0x0c],' '
   mov byte [gs:0x0d],0xA4

   mov byte [gs:0x0e],'t'
   mov byte [gs:0x0f],0xA4

   mov byte [gs:0x10],'h'
   mov byte [gs:0x11],0xA4

   mov byte [gs:0x12],'e'
   mov byte [gs:0x13],0xA4

   mov byte [gs:0x14],' '
   mov byte [gs:0x15],0xA4


   mov byte [gs:0x16],'m'
   mov byte [gs:0x17],0xA4

   mov byte [gs:0x18],'o'
   mov byte [gs:0x19],0xA4

   mov byte [gs:0x1a],'s'
   mov byte [gs:0x1b],0xA4

   mov byte [gs:0x1c],'t'
   mov byte [gs:0x1d],0xA4

   mov byte [gs:0x1e],' '
   mov byte [gs:0x1f],0xA4

   mov byte [gs:0x20],'h'
   mov byte [gs:0x21],0xA4

   mov byte [gs:0x22],'a'
   mov byte [gs:0x23],0xA4

   mov byte [gs:0x24],'n'
   mov byte [gs:0x25],0xA4

   mov byte [gs:0x26],'d'
   mov byte [gs:0x27],0xA4

   mov byte [gs:0x28],'s'
   mov byte [gs:0x29],0xA4

   mov byte [gs:0x2a],'o'
   mov byte [gs:0x2b],0xA4

   mov byte [gs:0x2c],'m'
   mov byte [gs:0x2d],0xA4

   mov byte [gs:0x2e],'e'
   mov byte [gs:0x2f],0xA4

   mov byte [gs:0x30],' '
   mov byte [gs:0x31],0xA4

   mov byte [gs:0x32],'m'
   mov byte [gs:0x33],0xA4

   mov byte [gs:0x34],'a'
   mov byte [gs:0x35],0xA4

   mov byte [gs:0x36],'n'
   mov byte [gs:0x37],0xA4

   mov byte [gs:0x38],' '
   mov byte [gs:0x39],0xA4

   mov byte [gs:0x3a],'i'
   mov byte [gs:0x3b],0xA4

   mov byte [gs:0x3c],'n'
   mov byte [gs:0x3d],0xA4

   mov byte [gs:0x3e],' '
   mov byte [gs:0x3f],0xA4

   ;第二行是160即0xa1
   mov byte [gs:0xa0],'N'
   mov byte [gs:0xa1],0xA4

   mov byte [gs:0x140],'C'
   mov byte [gs:0x141],0xA4

   mov byte [gs:0x1e0],'E'
   mov byte [gs:0x1e1],0xA4

   mov byte [gs:0x280],'P'
   mov byte [gs:0x281],0xA4

   mov byte [gs:0x320],'U'
   mov byte [gs:0x321],0xA4
   
   mov byte [gs:0x3c0],' '
   mov byte [gs:0x3c1],0xA4

   jmp $		       ; 通过死循环使程序悬停在此

   times 510-($-$$) db 0
   db 0x55,0xaa

