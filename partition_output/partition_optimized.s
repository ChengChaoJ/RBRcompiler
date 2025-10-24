	.text
	.file	"test_partition.c"
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
	ldr	w10, [x0, w2, sxtw #2]
	mov	x8, x0
	sxtw	x9, w2
	sub	w11, w1, #1
	cmp	w1, w2
	b.ge	.LBB1_6
// %bb.1:
	add	x12, x8, w1, sxtw #2
	sub	x13, x9, w1, sxtw
	b	.LBB1_3
.LBB1_2:                                //   in Loop: Header=BB1_3 Depth=1
	add	x12, x12, #4
	subs	x13, x13, #1
	b.eq	.LBB1_5
.LBB1_3:                                // =>This Inner Loop Header: Depth=1
	ldr	w14, [x12]
	cmp	w14, w10
	b.gt	.LBB1_2
// %bb.4:                               //   in Loop: Header=BB1_3 Depth=1
	add	w11, w11, #1
	sbfiz	x15, x11, #2, #32
	ldr	w16, [x8, x15]
	str	w14, [x8, x15]
	str	w16, [x12]
	b	.LBB1_2
.LBB1_5:
	ldr	w10, [x8, x9, lsl #2]
.LBB1_6:
	add	w0, w11, #1
	sbfiz	x11, x0, #2, #32
                                        // kill: def $w0 killed $w0 killed $x0
	ldr	w12, [x8, x11]
	str	w10, [x8, x11]
	str	w12, [x8, x9, lsl #2]
	ret
.Lfunc_end1:
	.size	partition, .Lfunc_end1-partition
	.cfi_endproc
                                        // -- End function
	.globl	print_array                     // -- Begin function print_array
	.p2align	2
	.type	print_array,@function
print_array:                            // @print_array
	.cfi_startproc
// %bb.0:
	cmp	w1, #1
	b.lt	.LBB2_4
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
.LBB2_2:                                // =>This Inner Loop Header: Depth=1
	ldr	w1, [x19], #4
	mov	x0, x20
	bl	printf
	subs	x21, x21, #1
	b.ne	.LBB2_2
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
.LBB2_4:
	mov	w0, #10                         // =0xa
	b	putchar
.Lfunc_end2:
	.size	print_array, .Lfunc_end2-print_array
	.cfi_endproc
                                        // -- End function
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	str	x19, [sp, #16]                  // 8-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	adrp	x0, .Lstr
	add	x0, x0, :lo12:.Lstr
	bl	puts
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	printf
	adrp	x19, .L.str
	add	x19, x19, :lo12:.L.str
	mov	x0, x19
	mov	w1, #3                          // =0x3
	bl	printf
	mov	x0, x19
	mov	w1, #1                          // =0x1
	bl	printf
	mov	x0, x19
	mov	w1, #4                          // =0x4
	bl	printf
	mov	x0, x19
	mov	w1, #1                          // =0x1
	bl	printf
	mov	x0, x19
	mov	w1, #5                          // =0x5
	bl	printf
	mov	x0, x19
	mov	w1, #9                          // =0x9
	bl	printf
	mov	x0, x19
	mov	w1, #2                          // =0x2
	bl	printf
	mov	x0, x19
	mov	w1, #6                          // =0x6
	bl	printf
	mov	w0, #10                         // =0xa
	bl	putchar
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	bl	printf
	mov	x0, x19
	mov	w1, #3                          // =0x3
	bl	printf
	mov	x0, x19
	mov	w1, #1                          // =0x1
	bl	printf
	mov	x0, x19
	mov	w1, #4                          // =0x4
	bl	printf
	mov	x0, x19
	mov	w1, #1                          // =0x1
	bl	printf
	mov	x0, x19
	mov	w1, #5                          // =0x5
	bl	printf
	mov	x0, x19
	mov	w1, #2                          // =0x2
	bl	printf
	mov	x0, x19
	mov	w1, #6                          // =0x6
	bl	printf
	mov	x0, x19
	mov	w1, #9                          // =0x9
	bl	printf
	mov	w0, #10                         // =0xa
	bl	putchar
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	mov	w1, #6                          // =0x6
	mov	w2, #6                          // =0x6
	bl	printf
	adrp	x0, .Lstr.9
	add	x0, x0, :lo12:.Lstr.9
	bl	puts
	adrp	x19, .L.str.7
	add	x19, x19, :lo12:.L.str.7
	mov	x0, x19
	mov	w1, wzr
	mov	w2, #3                          // =0x3
	mov	w3, #6                          // =0x6
	bl	printf
	mov	x0, x19
	mov	w1, #1                          // =0x1
	mov	w2, #1                          // =0x1
	mov	w3, #6                          // =0x6
	bl	printf
	mov	x0, x19
	mov	w1, #2                          // =0x2
	mov	w2, #4                          // =0x4
	mov	w3, #6                          // =0x6
	bl	printf
	mov	x0, x19
	mov	w1, #3                          // =0x3
	mov	w2, #1                          // =0x1
	mov	w3, #6                          // =0x6
	bl	printf
	mov	x0, x19
	mov	w1, #4                          // =0x4
	mov	w2, #5                          // =0x5
	mov	w3, #6                          // =0x6
	bl	printf
	mov	x0, x19
	mov	w1, #5                          // =0x5
	mov	w2, #2                          // =0x2
	mov	w3, #6                          // =0x6
	bl	printf
	adrp	x0, .L.str.8
	add	x0, x0, :lo12:.L.str.8
	mov	w1, #7                          // =0x7
	mov	w2, #9                          // =0x9
	mov	w3, #6                          // =0x6
	bl	printf
	mov	w0, wzr
	.cfi_def_cfa wsp, 32
	ldr	x19, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d "
	.size	.L.str, 4

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"\345\216\237\345\247\213\346\225\260\347\273\204: "
	.size	.L.str.3, 15

	.type	.L.str.4,@object                // @.str.4
.L.str.4:
	.asciz	"\345\210\206\345\214\272\345\220\216\346\225\260\347\273\204: "
	.size	.L.str.4, 18

	.type	.L.str.5,@object                // @.str.5
.L.str.5:
	.asciz	"\345\237\272\345\207\206\347\264\242\345\274\225: %d, \345\237\272\345\207\206\345\200\274: %d\n"
	.size	.L.str.5, 33

	.type	.L.str.7,@object                // @.str.7
.L.str.7:
	.asciz	"arr[%d] = %d <= %d \342\234\223\n"
	.size	.L.str.7, 24

	.type	.L.str.8,@object                // @.str.8
.L.str.8:
	.asciz	"arr[%d] = %d > %d \342\234\223\n"
	.size	.L.str.8, 23

	.type	.Lstr,@object                   // @str
.Lstr:
	.asciz	"=== \345\210\206\345\214\272\345\207\275\346\225\260\346\265\213\350\257\225 ==="
	.size	.Lstr, 27

	.type	.Lstr.9,@object                 // @str.9
.Lstr.9:
	.asciz	"\351\252\214\350\257\201\345\210\206\345\214\272\347\273\223\346\236\234:"
	.size	.Lstr.9, 20

	.ident	"BiSheng Enterprise 4.2.0.2.B002 clang version 17.0.6 (2261d9fde4e0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
