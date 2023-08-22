.memorymap
defaultslot 0
slotsize $2000
slot 0 $8000
slot 1 $a000
slot 2 $c000
slot 3 $e000
.endme

.rombankmap
bankstotal 49
banksize $0010
banks 1
banksize $2000
banks 32
banksize $2000
banks 16
.endro

.background "castlevania3.nes"

.equ    POINTER_ADDRESS                 $00
.equ    CURRENT_BLOCK                   $32
.equ    BLOCK_SYPHA                     2
.equ    SCREEN_WHAT_WILL_YOU_DO         4


.bank 3 slot 0
.orga $8944
            jmp     my_code

.bank 4 slot 1
.orga $be00
my_code:
            cpy     #SCREEN_WHAT_WILL_YOU_DO
            bne     @normal
            lda     CURRENT_BLOCK
            cmp     #BLOCK_SYPHA
            bne     @normal
@what_will_you_do_dialogue
            lda     #<pointer_table
            sta     POINTER_ADDRESS+0
            lda     #>pointer_table
            sta     POINTER_ADDRESS+1
            jmp     $894e
@normal
            ; replace original instruction
            lda     $8a26, y
            jmp     $8947

pointer_table:
            .dw     $8b24               ; "What will you do?"
            .dw     take_her_with_you   ; original: $8b36
            .dw     leave_her_behind    ; original: $8b4b
            .dw     $ffff
take_her_with_you:
            .db     $00, $00
            ; Take
            .db     $d3, $e0, $ea, $e4, $00
            ; her
            .db     $e7, $e4, $f1, $00
            ; with
            .db     $f6, $e8, $f3, $e7, $00
            ; you?
            .db     $f8, $ee, $f4, $fb, $ff
leave_her_behind:
            .db     $00, $00
            ; Leave
            .db     $cb, $e4, $e0, $f5, $e4, $00
            ; her
            .db     $e7, $e4, $f1, $00
            ; behind?
            .db     $e1, $e4, $e7, $e8, $ed, $e3, $fb, $ff
