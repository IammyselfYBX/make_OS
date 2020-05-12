   %include "boot.inc"
   section loader vstart=LOADER_BASE_ADDR
   LOADER_STACK_TOP equ LOADER_BASE_ADDR
   jmp loader_start					; 此处的物理地址是:
   
;构建gdt及其内部的描述符
   GDT_BASE:   dd    0x00000000 
	       dd    0x00000000

   CODE_DESC:  dd    0x0000FFFF 
	       dd    DESC_CODE_HIGH4

   DATA_STACK_DESC:  dd    0x0000FFFF
		     dd    DESC_DATA_HIGH4

   VIDEO_DESC: dd    0x80000007	       ;limit=(0xbffff-0xb8000)/4k=0x7
	       dd    DESC_VIDEO_HIGH4  ; 此时dpl已改为0

   GDT_SIZE   equ   $ - GDT_BASE
   GDT_LIMIT   equ   GDT_SIZE -	1 
   times 60 dq 0					 ; 此处预留60个描述符的slot
   SELECTOR_CODE equ (0x0001<<3) + TI_GDT + RPL0         ; 相当于(CODE_DESC - GDT_BASE)/8 + TI_GDT + RPL0
   SELECTOR_DATA equ (0x0002<<3) + TI_GDT + RPL0	 ; 同上
   SELECTOR_VIDEO equ (0x0003<<3) + TI_GDT + RPL0	 ; 同上 

   ;以下是定义gdt的指针，前2字节是gdt界限，后4字节是gdt起始地址

   gdt_ptr  dw  GDT_LIMIT 
	    dd  GDT_BASE
   loadermsg db 'loader in real.'

   loader_start:

;------------------------------------------------------------
;INT 0x10    功能号:0x13    功能描述:打印字符串
;------------------------------------------------------------
;输入:
;AH 子功能号=13H
;BH = 页码
;BL = 属性(若AL=00H或01H)
;CX＝字符串长度
;(DH、DL)＝坐标(行、列)
;ES:BP＝字符串地址 
;AL＝显示输出方式
;   0——字符串中只含显示字符，其显示属性在BL中。显示后，光标位置不变
;   1——字符串中只含显示字符，其显示属性在BL中。显示后，光标位置改变
;   2——字符串中含显示字符和显示属性。显示后，光标位置不变
;   3——字符串中含显示字符和显示属性。显示后，光标位置改变
;无返回值
   mov	 sp, LOADER_BASE_ADDR
   mov	 bp, loadermsg           ; ES:BP = 字符串地址
   mov	 cx, 15  		 ; CX = 字符串长度
   mov	 ax, 0x1301		 ; AH = 13,  AL = 01h
   mov	 bx, 0x001f		 ; 页号为0(BH = 0) 蓝底粉红字(BL = 1fh)
   mov	 dx, 0x1800		 ;
   int	 0x10                    ; 10h 号中断

;----------------------------------------   准备进入保护模式   ------------------------------------------
									;1 打开A20
									;2 加载gdt
									;3 将cr0的pe位置1


   ;-----------------  打开A20  ----------------
   in al,0x92
   or al,0000_0010B
   out 0x92,al

   ;-----------------  加载GDT  ----------------
   lgdt [gdt_ptr]


   ;-----------------  cr0第0位置1  ----------------
   mov eax, cr0
   or eax, 0x00000001
   mov cr0, eax

   ;jmp dword SELECTOR_CODE:p_mode_start	     ; 刷新流水线，避免分支预测的影响,这种cpu优化策略，最怕jmp跳转，
   jmp  SELECTOR_CODE:p_mode_start	     ; 刷新流水线，避免分支预测的影响,这种cpu优化策略，最怕jmp跳转，
					     ; 这将导致之前做的预测失效，从而起到了刷新的作用。

[bits 32]
p_mode_start:
   mov ax, SELECTOR_DATA
   mov ds, ax
   mov es, ax
   mov ss, ax
   mov esp,LOADER_STACK_TOP
   mov ax, SELECTOR_VIDEO
   mov gs, ax

   mov byte [gs:0xa0],'Y'
   mov byte [gs:0xa1],0xA4     ; A 表示绿色背景闪烁，4 表示前景色为红色

   mov byte [gs:0xa2],'B'
   mov byte [gs:0xa3],0xA4

   mov byte [gs:0xa4],'X'
   mov byte [gs:0xa5],0xA4   

   mov byte [gs:0xa6],' '
   mov byte [gs:0xa7],0xA4

   mov byte [gs:0xa8],'i'
   mov byte [gs:0xa9],0xA4

   mov byte [gs:0xaa],'s'
   mov byte [gs:0xab],0xA4

   mov byte [gs:0xac],' '
   mov byte [gs:0xad],0xA4

   mov byte [gs:0xae],'t'
   mov byte [gs:0xaf],0xA4

   mov byte [gs:0xb0],'h'
   mov byte [gs:0xb1],0xA4

   mov byte [gs:0xb2],'e'
   mov byte [gs:0xb3],0xA4

   mov byte [gs:0xb4],' '
   mov byte [gs:0xb5],0xA4


   mov byte [gs:0xb6],'m'
   mov byte [gs:0xb7],0xA4

   mov byte [gs:0xb8],'o'
   mov byte [gs:0xb9],0xA4

   mov byte [gs:0xba],'s'
   mov byte [gs:0xbb],0xA4

   mov byte [gs:0xbc],'t'
   mov byte [gs:0xbd],0xA4

   mov byte [gs:0xbe],' '
   mov byte [gs:0xbf],0xA4

   mov byte [gs:0xc0],'h'
   mov byte [gs:0xc1],0xA4

   mov byte [gs:0xc2],'a'
   mov byte [gs:0xc3],0xA4

   mov byte [gs:0xc4],'n'
   mov byte [gs:0xc5],0xA4

   mov byte [gs:0xc6],'d'
   mov byte [gs:0xc7],0xA4

   mov byte [gs:0xc8],'s'
   mov byte [gs:0xc9],0xA4

   mov byte [gs:0xca],'o'
   mov byte [gs:0xcb],0xA4

   mov byte [gs:0xcc],'m'
   mov byte [gs:0xcd],0xA4

   mov byte [gs:0xce],'e'
   mov byte [gs:0xcf],0xA4

   mov byte [gs:0xd0],' '
   mov byte [gs:0xd1],0xA4

   mov byte [gs:0xd2],'m'
   mov byte [gs:0xd3],0xA4

   mov byte [gs:0xd4],'a'
   mov byte [gs:0xd5],0xA4

   mov byte [gs:0xd6],'n'
   mov byte [gs:0xd7],0xA4

   mov byte [gs:0xd8],' '
   mov byte [gs:0xd9],0xA4

   mov byte [gs:0xda],'i'
   mov byte [gs:0xdb],0xA4

   mov byte [gs:0xdc],'n'
   mov byte [gs:0xdd],0xA4

   mov byte [gs:0xde],' '
   mov byte [gs:0xdf],0xA4

   mov byte [gs:0xe0],'N'
   mov byte [gs:0xe1],0xA4

   mov byte [gs:0xe2],'C'
   mov byte [gs:0xe3],0xA4

   mov byte [gs:0xe4],'E'
   mov byte [gs:0xe5],0xA4

   mov byte [gs:0xe6],'P'
   mov byte [gs:0xe7],0xA4

   mov byte [gs:0xe8],'U'
   mov byte [gs:0xe9],0xA4

   mov byte [gs:330], 'b'
   mov byte [gs:332], 'y'
   mov byte [gs:334], ' '
   mov byte [gs:336], 'Y'
   mov byte [gs:338], 'B'
   mov byte [gs:340], 'X'


   jmp $
