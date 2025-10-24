	.text
	.file	"quicksort.c"
	.globl	swap                            // -- Begin function swap
	.p2align	2
	.type	swap,@function
swap:                                   // @swap
	.cfi_startproc
// %bb.0:
	ldr	w8, [x1]
	ldr	w9, [x0]
	str	w8, [x0]
	str	w9, [x1]
	ret
.Lfunc_end0:
	.size	swap, .Lfunc_end0-swap
	.cfi_endproc
                                        // -- End function
	.globl	partition                       // -- Begin function partition
	.p2align	2
	.type	partition,@function
partition:                              // @partition
	.cfi_startproc
// %bb.0:
                                        // kill: def $w2 killed $w2 def $x2
	mov	x8, x0
	sxtw	x9, w2
	sub	w10, w1, #1
	cmp	w1, w2
	b.ge	.LBB1_5
// %bb.1:
	mov	w12, w2
	ldr	w11, [x8, w2, sxtw #2]
	sxtw	x13, w12
	add	x12, x8, w1, sxtw #2
	sub	x13, x13, w1, sxtw
	b	.LBB1_3
.LBB1_2:                                //   in Loop: Header=BB1_3 Depth=1
	add	x12, x12, #4
	subs	x13, x13, #1
	b.eq	.LBB1_5
.LBB1_3:                                // =>This Inner Loop Header: Depth=1
	ldr	w14, [x12]
	cmp	w14, w11
	b.gt	.LBB1_2
// %bb.4:                               //   in Loop: Header=BB1_3 Depth=1
	add	w10, w10, #1
	sbfiz	x15, x10, #2, #32
	ldr	w16, [x8, x15]
	str	w14, [x8, x15]
	str	w16, [x12]
	b	.LBB1_2
.LBB1_5:
	add	w0, w10, #1
	lsl	x9, x9, #2
	sbfiz	x10, x0, #2, #32
                                        // kill: def $w0 killed $w0 killed $x0
	ldr	w11, [x8, x9]
	ldr	w12, [x8, x10]
	str	w11, [x8, x10]
	str	w12, [x8, x9]
	ret
.Lfunc_end1:
	.size	partition, .Lfunc_end1-partition
	.cfi_endproc
                                        // -- End function
	.globl	quicksort                       // -- Begin function quicksort
	.p2align	2
	.type	quicksort,@function
quicksort:                              // @quicksort
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	mov	w8, w2
	mov	w19, w2
	sxtw	x8, w8
	mov	x20, x0
	sxtw	x22, w19
	lsl	x23, x8, #2
                                        // kill: def $w1 killed $w1 def $x1
	b	.LBB2_2
.LBB2_1:                                //   in Loop: Header=BB2_2 Depth=1
	add	w8, w21, #1
	ldr	w9, [x20, x23]
	sbfiz	x8, x8, #2, #32
	mov	x0, x20
	mov	w2, w21
                                        // kill: def $w1 killed $w1 killed $x1
	ldr	w10, [x20, x8]
	str	w9, [x20, x8]
	str	w10, [x20, x23]
	bl	quicksort
	add	w1, w21, #2
.LBB2_2:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_5 Depth 2
	cmp	w1, w19
	b.ge	.LBB2_7
// %bb.3:                               //   in Loop: Header=BB2_2 Depth=1
	ldr	w8, [x20, w19, sxtw #2]
	sub	w21, w1, #1
	sxtw	x9, w1
	b	.LBB2_5
.LBB2_4:                                //   in Loop: Header=BB2_5 Depth=2
	add	x9, x9, #1
	cmp	x22, x9
	b.eq	.LBB2_1
.LBB2_5:                                //   Parent Loop BB2_2 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	w10, [x20, x9, lsl #2]
	cmp	w10, w8
	b.gt	.LBB2_4
// %bb.6:                               //   in Loop: Header=BB2_5 Depth=2
	add	w21, w21, #1
	sbfiz	x11, x21, #2, #32
	ldr	w12, [x20, x11]
	str	w10, [x20, x11]
	str	w12, [x20, x9, lsl #2]
	b	.LBB2_4
.LBB2_7:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end2:
	.size	quicksort, .Lfunc_end2-quicksort
	.cfi_endproc
                                        // -- End function
	.globl	print_array                     // -- Begin function print_array
	.p2align	2
	.type	print_array,@function
print_array:                            // @print_array
	.cfi_startproc
// %bb.0:
	cmp	w1, #1
	b.lt	.LBB3_4
// %bb.1:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	mov	x19, x0
	mov	w21, w1
	adrp	x20, .L.str
	add	x20, x20, :lo12:.L.str
.LBB3_2:                                // =>This Inner Loop Header: Depth=1
	ldr	w1, [x19], #4
	mov	x0, x20
	bl	printf
	subs	x21, x21, #1
	b.ne	.LBB3_2
// %bb.3:
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
.LBB3_4:
	mov	w0, #10                         // =0xa
	b	putchar
.Lfunc_end3:
	.size	print_array, .Lfunc_end3-print_array
	.cfi_endproc
                                        // -- End function
	.globl	generate_random_array           // -- Begin function generate_random_array
	.p2align	2
	.type	generate_random_array,@function
generate_random_array:                  // @generate_random_array
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	mov	x19, x0
	mov	x0, xzr
	mov	w20, w1
	bl	time
                                        // kill: def $w0 killed $w0 killed $x0
	bl	srand
	cmp	w20, #1
	b.lt	.LBB4_3
// %bb.1:
	mov	w21, #19923                     // =0x4dd3
	mov	w20, w20
	movk	w21, #4194, lsl #16
	mov	w22, #1000                      // =0x3e8
.LBB4_2:                                // =>This Inner Loop Header: Depth=1
	bl	rand
	smull	x8, w0, w21
	subs	x20, x20, #1
	lsr	x9, x8, #63
	asr	x8, x8, #38
	add	w8, w8, w9
	msub	w8, w8, w22, w0
	str	w8, [x19], #4
	b.ne	.LBB4_2
.LBB4_3:
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end4:
	.size	generate_random_array, .Lfunc_end4-generate_random_array
	.cfi_endproc
                                        // -- End function
	.globl	is_sorted                       // -- Begin function is_sorted
	.p2align	2
	.type	is_sorted,@function
is_sorted:                              // @is_sorted
	.cfi_startproc
// %bb.0:
                                        // kill: def $w1 killed $w1 def $x1
	cmp	w1, #2
	mov	x8, x0
	cset	w0, lt
	b.ge	.LBB5_2
.LBB5_1:
	ret
.LBB5_2:
	ldp	w10, w9, [x8]
	cmp	w9, w10
	b.lt	.LBB5_1
// %bb.3:
	sxtw	x9, w1
	mov	w10, w1
	add	x8, x8, #8
	mov	w12, #2                         // =0x2
.LBB5_4:                                // =>This Inner Loop Header: Depth=1
	mov	x11, x12
	cmp	x10, x12
	b.eq	.LBB5_6
// %bb.5:                               //   in Loop: Header=BB5_4 Depth=1
	ldp	w14, w13, [x8, #-4]
	add	x8, x8, #4
	add	x12, x11, #1
	cmp	w13, w14
	b.ge	.LBB5_4
.LBB5_6:
	cmp	x11, x9
	cset	w0, ge
	ret
.Lfunc_end5:
	.size	is_sorted, .Lfunc_end5-is_sorted
	.cfi_endproc
                                        // -- End function
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	str	d8, [sp, #-80]!                 // 8-byte Folded Spill
	.cfi_def_cfa_offset 80
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	stp	x28, x23, [sp, #32]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w28, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_offset b8, -80
	.cfi_remember_state
	sub	sp, sp, #9, lsl #12             // =36864
	sub	sp, sp, #3136
	adrp	x0, .Lstr
	add	x0, x0, :lo12:.Lstr
	bl	puts
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	mov	w1, #10000                      // =0x2710
	bl	printf
	mov	x0, xzr
	bl	time
                                        // kill: def $w0 killed $w0 killed $x0
	bl	srand
	mov	w20, #19923                     // =0x4dd3
	mov	x19, xzr
	movk	w20, #4194, lsl #16
	mov	w21, #1000                      // =0x3e8
	mov	x22, sp
	mov	w23, #40000                     // =0x9c40
.LBB6_1:                                // =>This Inner Loop Header: Depth=1
	bl	rand
	smull	x8, w0, w20
	lsr	x9, x8, #63
	asr	x8, x8, #38
	add	w8, w8, w9
	msub	w8, w8, w21, w0
	str	w8, [x22, x19]
	add	x19, x19, #4
	cmp	x19, x23
	b.ne	.LBB6_1
// %bb.2:
	adrp	x0, .Lstr.11
	add	x0, x0, :lo12:.Lstr.11
	bl	puts
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	bl	printf
	mov	x20, xzr
	mov	x21, sp
	adrp	x19, .L.str
	add	x19, x19, :lo12:.L.str
.LBB6_3:                                // =>This Inner Loop Header: Depth=1
	ldr	w1, [x21, x20]
	mov	x0, x19
	bl	printf
	add	x20, x20, #4
	cmp	x20, #40
	b.ne	.LBB6_3
// %bb.4:
	mov	w0, #10                         // =0xa
	bl	putchar
	bl	clock
	mov	x19, x0
	mov	x0, sp
	mov	w1, wzr
	mov	w2, #9999                       // =0x270f
	mov	x20, sp
	bl	quicksort
	bl	clock
	ldp	w9, w8, [sp]
	cmp	w8, w9
	b.lt	.LBB6_9
// %bb.5:
	add	x8, x20, #8
	mov	x11, #-1                        // =0xffffffffffffffff
	mov	x9, #-9999                      // =0xffffffffffffd8f1
.LBB6_6:                                // =>This Inner Loop Header: Depth=1
	mov	x10, x11
	cmp	x11, x9
	b.eq	.LBB6_8
// %bb.7:                               //   in Loop: Header=BB6_6 Depth=1
	ldp	w13, w12, [x8, #-4]
	sub	x11, x10, #1
	add	x8, x8, #4
	cmp	w12, w13
	b.ge	.LBB6_6
.LBB6_8:
	neg	x8, x10
	mov	w9, #9998                       // =0x270e
	cmp	x8, x9
	b.hi	.LBB6_11
.LBB6_9:
	adrp	x0, .Lstr.12
	add	x0, x0, :lo12:.Lstr.12
	bl	puts
	mov	w0, #1                          // =0x1
.LBB6_10:
	add	sp, sp, #9, lsl #12             // =36864
	add	sp, sp, #3136
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x28, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	ldr	d8, [sp], #80                   // 8-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	ret
.LBB6_11:
	.cfi_restore_state
	sub	x8, x0, x19
	mov	x9, #145685290680320            // =0x848000000000
	movk	x9, #16686, lsl #48
	adrp	x0, .Lstr.13
	add	x0, x0, :lo12:.Lstr.13
	scvtf	d0, x8
	mov	x8, #70368744177664             // =0x400000000000
	fmov	d1, x9
	movk	x8, #16527, lsl #48
	fdiv	d0, d0, d1
	fmov	d1, x8
	fmul	d8, d0, d1
	bl	puts
	fmov	d0, d8
	adrp	x0, .L.str.7
	add	x0, x0, :lo12:.L.str.7
	bl	printf
	adrp	x0, .L.str.9
	add	x0, x0, :lo12:.L.str.9
	bl	printf
	mov	x20, xzr
	mov	x21, sp
	adrp	x19, .L.str
	add	x19, x19, :lo12:.L.str
.LBB6_12:                               // =>This Inner Loop Header: Depth=1
	ldr	w1, [x21, x20]
	mov	x0, x19
	bl	printf
	add	x20, x20, #4
	cmp	x20, #40
	b.ne	.LBB6_12
// %bb.13:
	mov	w0, #10                         // =0xa
	bl	putchar
	adrp	x0, .L.str.10
	add	x0, x0, :lo12:.L.str.10
	bl	printf
	mov	w8, #39960                      // =0x9c18
	mov	x9, sp
	mov	x20, xzr
	add	x21, x9, x8
	adrp	x19, .L.str
	add	x19, x19, :lo12:.L.str
.LBB6_14:                               // =>This Inner Loop Header: Depth=1
	ldr	w1, [x21, x20]
	mov	x0, x19
	bl	printf
	add	x20, x20, #4
	cmp	x20, #40
	b.ne	.LBB6_14
// %bb.15:
	mov	w0, #10                         // =0xa
	bl	putchar
	mov	w0, wzr
	b	.LBB6_10
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d "
	.size	.L.str, 4

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"\346\225\260\347\273\204\345\244\247\345\260\217: %d\n"
	.size	.L.str.3, 18

	.type	.L.str.5,@object                // @.str.5
.L.str.5:
	.asciz	"\346\216\222\345\272\217\345\211\215\345\211\21510\344\270\252\345\205\203\347\264\240: "
	.size	.L.str.5, 26

	.type	.L.str.7,@object                // @.str.7
.L.str.7:
	.asciz	"\350\277\220\350\241\214\346\227\266\351\227\264: %.2f \346\257\253\347\247\222\n"
	.size	.L.str.7, 27

	.type	.L.str.9,@object                // @.str.9
.L.str.9:
	.asciz	"\346\216\222\345\272\217\345\220\216\345\211\21510\344\270\252\345\205\203\347\264\240: "
	.size	.L.str.9, 26

	.type	.L.str.10,@object               // @.str.10
.L.str.10:
	.asciz	"\346\216\222\345\272\217\345\220\216\345\220\21610\344\270\252\345\205\203\347\264\240: "
	.size	.L.str.10, 26

	.type	.Lstr,@object                   // @str
.Lstr:
	.asciz	"=== \345\277\253\351\200\237\346\216\222\345\272\217\347\256\227\346\263\225\346\265\213\350\257\225 ==="
	.size	.Lstr, 33

	.type	.Lstr.11,@object                // @str.11
.Lstr.11:
	.asciz	"\345\216\237\345\247\213\346\225\260\347\273\204\345\267\262\347\224\237\346\210\220"
	.size	.Lstr.11, 22

	.type	.Lstr.12,@object                // @str.12
.Lstr.12:
	.asciz	"\342\234\227 \346\216\222\345\272\217\345\244\261\350\264\245\357\274\201"
	.size	.Lstr.12, 20

	.type	.Lstr.13,@object                // @str.13
.Lstr.13:
	.asciz	"\342\234\223 \346\216\222\345\272\217\346\210\220\345\212\237\357\274\201"
	.size	.Lstr.13, 20

	.ident	"BiSheng Enterprise 4.2.0.2.B002 clang version 17.0.6 (2261d9fde4e0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
