	.text
	.file	"test_partition.c"
	.globl	swap                            // -- Begin function swap
	.p2align	2
	.type	swap,@function
swap:                                   // @swap
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #24]
	str	x1, [sp, #16]
	ldr	x8, [sp, #24]
	ldr	w8, [x8]
	str	w8, [sp, #12]
	ldr	x8, [sp, #16]
	ldr	w8, [x8]
	ldr	x9, [sp, #24]
	str	w8, [x9]
	ldr	w8, [sp, #12]
	ldr	x9, [sp, #16]
	str	w8, [x9]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
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
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	w1, [x29, #-12]
	str	w2, [sp, #16]
	ldur	x8, [x29, #-8]
	ldrsw	x9, [sp, #16]
	ldr	w8, [x8, x9, lsl #2]
	str	w8, [sp, #12]
	ldur	w8, [x29, #-12]
	subs	w8, w8, #1
	str	w8, [sp, #8]
	ldur	w8, [x29, #-12]
	str	w8, [sp, #4]
	b	.LBB1_1
.LBB1_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #16]
	subs	w9, w9, #1
	subs	w8, w8, w9
	cset	w8, gt
	tbnz	w8, #0, .LBB1_6
	b	.LBB1_2
.LBB1_2:                                //   in Loop: Header=BB1_1 Depth=1
	ldur	x8, [x29, #-8]
	ldrsw	x9, [sp, #4]
	ldr	w8, [x8, x9, lsl #2]
	ldr	w9, [sp, #12]
	subs	w8, w8, w9
	cset	w8, gt
	tbnz	w8, #0, .LBB1_4
	b	.LBB1_3
.LBB1_3:                                //   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #8]
	add	w8, w8, #1
	str	w8, [sp, #8]
	ldur	x8, [x29, #-8]
	ldrsw	x9, [sp, #8]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldrsw	x9, [sp, #4]
	add	x1, x8, x9, lsl #2
	bl	swap
	b	.LBB1_4
.LBB1_4:                                //   in Loop: Header=BB1_1 Depth=1
	b	.LBB1_5
.LBB1_5:                                //   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #4]
	add	w8, w8, #1
	str	w8, [sp, #4]
	b	.LBB1_1
.LBB1_6:
	ldur	x8, [x29, #-8]
	ldr	w9, [sp, #8]
	add	w9, w9, #1
	add	x0, x8, w9, sxtw #2
	ldur	x8, [x29, #-8]
	ldrsw	x9, [sp, #16]
	add	x1, x8, x9, lsl #2
	bl	swap
	ldr	w8, [sp, #8]
	add	w0, w8, #1
	.cfi_def_cfa wsp, 48
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	add	sp, sp, #48
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
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
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	w1, [sp, #4]
	str	wzr, [sp]
	b	.LBB2_1
.LBB2_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp]
	ldr	w9, [sp, #4]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB2_4
	b	.LBB2_2
.LBB2_2:                                //   in Loop: Header=BB2_1 Depth=1
	ldr	x8, [sp, #8]
	ldrsw	x9, [sp]
	ldr	w1, [x8, x9, lsl #2]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printf
	b	.LBB2_3
.LBB2_3:                                //   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp]
	add	w8, w8, #1
	str	w8, [sp]
	b	.LBB2_1
.LBB2_4:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printf
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
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
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             // 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, wzr
	str	w8, [sp, #4]                    // 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	bl	printf
	adrp	x8, .L__const.main.arr
	add	x8, x8, :lo12:.L__const.main.arr
	ldr	q0, [x8]
	add	x9, sp, #32
	str	x9, [sp, #8]                    // 8-byte Folded Spill
	str	q0, [sp, #32]
	ldr	q0, [x8, #16]
	str	q0, [sp, #48]
	mov	w8, #8                          // =0x8
	str	w8, [sp, #28]
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	printf
	ldr	x0, [sp, #8]                    // 8-byte Folded Reload
	ldr	w1, [sp, #28]
	bl	print_array
	ldr	w1, [sp, #4]                    // 4-byte Folded Reload
	ldr	x0, [sp, #8]                    // 8-byte Folded Reload
	ldr	w8, [sp, #28]
	subs	w2, w8, #1
	bl	partition
	str	w0, [sp, #24]
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	bl	printf
	ldr	x0, [sp, #8]                    // 8-byte Folded Reload
	ldr	w1, [sp, #28]
	bl	print_array
	ldr	x8, [sp, #8]                    // 8-byte Folded Reload
	ldr	w1, [sp, #24]
	ldrsw	x9, [sp, #24]
	ldr	w2, [x8, x9, lsl #2]
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	bl	printf
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	printf
	str	wzr, [sp, #20]
	b	.LBB3_1
.LBB3_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #20]
	ldr	w9, [sp, #24]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB3_4
	b	.LBB3_2
.LBB3_2:                                //   in Loop: Header=BB3_1 Depth=1
	ldr	w1, [sp, #20]
	ldrsw	x9, [sp, #20]
	add	x8, sp, #32
	ldr	w2, [x8, x9, lsl #2]
	ldrsw	x9, [sp, #24]
	ldr	w3, [x8, x9, lsl #2]
	adrp	x0, .L.str.7
	add	x0, x0, :lo12:.L.str.7
	bl	printf
	b	.LBB3_3
.LBB3_3:                                //   in Loop: Header=BB3_1 Depth=1
	ldr	w8, [sp, #20]
	add	w8, w8, #1
	str	w8, [sp, #20]
	b	.LBB3_1
.LBB3_4:
	ldr	w8, [sp, #24]
	add	w8, w8, #1
	str	w8, [sp, #16]
	b	.LBB3_5
.LBB3_5:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #16]
	ldr	w9, [sp, #28]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB3_8
	b	.LBB3_6
.LBB3_6:                                //   in Loop: Header=BB3_5 Depth=1
	ldr	w1, [sp, #16]
	ldrsw	x9, [sp, #16]
	add	x8, sp, #32
	ldr	w2, [x8, x9, lsl #2]
	ldrsw	x9, [sp, #24]
	ldr	w3, [x8, x9, lsl #2]
	adrp	x0, .L.str.8
	add	x0, x0, :lo12:.L.str.8
	bl	printf
	b	.LBB3_7
.LBB3_7:                                //   in Loop: Header=BB3_5 Depth=1
	ldr	w8, [sp, #16]
	add	w8, w8, #1
	str	w8, [sp, #16]
	b	.LBB3_5
.LBB3_8:
	mov	w0, wzr
	.cfi_def_cfa wsp, 96
	ldp	x29, x30, [sp, #80]             // 16-byte Folded Reload
	add	sp, sp, #96
	.cfi_def_cfa_offset 0
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

	.type	.L.str.1,@object                // @.str.1
.L.str.1:
	.asciz	"\n"
	.size	.L.str.1, 2

	.type	.L.str.2,@object                // @.str.2
.L.str.2:
	.asciz	"=== \345\210\206\345\214\272\345\207\275\346\225\260\346\265\213\350\257\225 ===\n"
	.size	.L.str.2, 28

	.type	.L__const.main.arr,@object      // @__const.main.arr
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	2, 0x0
.L__const.main.arr:
	.word	3                               // 0x3
	.word	1                               // 0x1
	.word	4                               // 0x4
	.word	1                               // 0x1
	.word	5                               // 0x5
	.word	9                               // 0x9
	.word	2                               // 0x2
	.word	6                               // 0x6
	.size	.L__const.main.arr, 32

	.type	.L.str.3,@object                // @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
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

	.type	.L.str.6,@object                // @.str.6
.L.str.6:
	.asciz	"\351\252\214\350\257\201\345\210\206\345\214\272\347\273\223\346\236\234:\n"
	.size	.L.str.6, 21

	.type	.L.str.7,@object                // @.str.7
.L.str.7:
	.asciz	"arr[%d] = %d <= %d \342\234\223\n"
	.size	.L.str.7, 24

	.type	.L.str.8,@object                // @.str.8
.L.str.8:
	.asciz	"arr[%d] = %d > %d \342\234\223\n"
	.size	.L.str.8, 23

	.ident	"BiSheng Enterprise 4.2.0.2.B002 clang version 17.0.6 (2261d9fde4e0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym swap
	.addrsig_sym partition
	.addrsig_sym print_array
	.addrsig_sym printf
