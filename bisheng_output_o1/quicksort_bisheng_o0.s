	.text
	.file	"quicksort.c"
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
	.globl	quicksort                       // -- Begin function quicksort
	.p2align	2
	.type	quicksort,@function
quicksort:                              // @quicksort
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
	ldur	w8, [x29, #-12]
	ldr	w9, [sp, #16]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB2_2
	b	.LBB2_1
.LBB2_1:
	ldur	x0, [x29, #-8]
	ldur	w1, [x29, #-12]
	ldr	w2, [sp, #16]
	bl	partition
	str	w0, [sp, #12]
	ldur	x0, [x29, #-8]
	ldur	w1, [x29, #-12]
	ldr	w8, [sp, #12]
	subs	w2, w8, #1
	bl	quicksort
	ldur	x0, [x29, #-8]
	ldr	w8, [sp, #12]
	add	w1, w8, #1
	ldr	w2, [sp, #16]
	bl	quicksort
	b	.LBB2_2
.LBB2_2:
	.cfi_def_cfa wsp, 48
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	add	sp, sp, #48
	.cfi_def_cfa_offset 0
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
	b	.LBB3_1
.LBB3_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp]
	ldr	w9, [sp, #4]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB3_4
	b	.LBB3_2
.LBB3_2:                                //   in Loop: Header=BB3_1 Depth=1
	ldr	x8, [sp, #8]
	ldrsw	x9, [sp]
	ldr	w1, [x8, x9, lsl #2]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printf
	b	.LBB3_3
.LBB3_3:                                //   in Loop: Header=BB3_1 Depth=1
	ldr	w8, [sp]
	add	w8, w8, #1
	str	w8, [sp]
	b	.LBB3_1
.LBB3_4:
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
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	w1, [sp, #4]
	mov	x0, xzr
	bl	time
                                        // kill: def $w0 killed $w0 killed $x0
	bl	srand
	str	wzr, [sp]
	b	.LBB4_1
.LBB4_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp]
	ldr	w9, [sp, #4]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB4_4
	b	.LBB4_2
.LBB4_2:                                //   in Loop: Header=BB4_1 Depth=1
	bl	rand
	mov	w9, #1000                       // =0x3e8
	sdiv	w8, w0, w9
	mul	w8, w8, w9
	subs	w8, w0, w8
	ldr	x9, [sp, #8]
	ldrsw	x10, [sp]
	str	w8, [x9, x10, lsl #2]
	b	.LBB4_3
.LBB4_3:                                //   in Loop: Header=BB4_1 Depth=1
	ldr	w8, [sp]
	add	w8, w8, #1
	str	w8, [sp]
	b	.LBB4_1
.LBB4_4:
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
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
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #16]
	str	w1, [sp, #12]
	mov	w8, #1                          // =0x1
	str	w8, [sp, #8]
	b	.LBB5_1
.LBB5_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #8]
	ldr	w9, [sp, #12]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB5_6
	b	.LBB5_2
.LBB5_2:                                //   in Loop: Header=BB5_1 Depth=1
	ldr	x8, [sp, #16]
	ldrsw	x9, [sp, #8]
	ldr	w8, [x8, x9, lsl #2]
	ldr	x9, [sp, #16]
	ldr	w10, [sp, #8]
	subs	w10, w10, #1
	ldr	w9, [x9, w10, sxtw #2]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB5_4
	b	.LBB5_3
.LBB5_3:
	str	wzr, [sp, #28]
	b	.LBB5_7
.LBB5_4:                                //   in Loop: Header=BB5_1 Depth=1
	b	.LBB5_5
.LBB5_5:                                //   in Loop: Header=BB5_1 Depth=1
	ldr	w8, [sp, #8]
	add	w8, w8, #1
	str	w8, [sp, #8]
	b	.LBB5_1
.LBB5_6:
	mov	w8, #1                          // =0x1
	str	w8, [sp, #28]
	b	.LBB5_7
.LBB5_7:
	ldr	w0, [sp, #28]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	is_sorted, .Lfunc_end5-is_sorted
	.cfi_endproc
                                        // -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          // -- Begin function main
.LCPI6_0:
	.xword	0x408f400000000000              // double 1000
.LCPI6_1:
	.xword	0x412e848000000000              // double 1.0E+6
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	str	x28, [sp, #16]                  // 8-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w28, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	sub	sp, sp, #9, lsl #12             // =36864
	sub	sp, sp, #3232
	sub	x9, x29, #60
	str	x9, [sp, #24]                   // 8-byte Folded Spill
	str	wzr, [x9, #56]
	mov	w8, #10000                      // =0x2710
	str	w8, [sp, #20]                   // 4-byte Folded Spill
	str	w8, [x9, #52]
	mov	x8, sp
	stur	x8, [x9, #44]
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	bl	printf
	ldr	w1, [sp, #20]                   // 4-byte Folded Reload
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	printf
	ldr	w1, [sp, #20]                   // 4-byte Folded Reload
	add	x0, sp, #36
	bl	generate_random_array
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	bl	printf
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	bl	printf
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	str	wzr, [x8, #40]
	b	.LBB6_1
.LBB6_1:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldr	w8, [x8, #40]
	subs	w8, w8, #10
	cset	w8, ge
	tbnz	w8, #0, .LBB6_4
	b	.LBB6_2
.LBB6_2:                                //   in Loop: Header=BB6_1 Depth=1
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldrsw	x9, [x8, #40]
	add	x8, sp, #36
	ldr	w1, [x8, x9, lsl #2]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printf
	b	.LBB6_3
.LBB6_3:                                //   in Loop: Header=BB6_1 Depth=1
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	ldr	w8, [x9, #40]
	add	w8, w8, #1
	str	w8, [x9, #40]
	b	.LBB6_1
.LBB6_4:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printf
	bl	clock
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	stur	x0, [x8, #28]
	add	x0, sp, #36
	str	x0, [sp, #8]                    // 8-byte Folded Spill
	mov	w1, wzr
	mov	w2, #9999                       // =0x270f
	bl	quicksort
	bl	clock
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	mov	x9, x0
	ldr	x0, [sp, #8]                    // 8-byte Folded Reload
	stur	x9, [x8, #20]
	ldur	x9, [x8, #20]
	ldur	x10, [x8, #28]
	subs	x9, x9, x10
	scvtf	d0, x9
	adrp	x9, .LCPI6_1
	ldr	d1, [x9, :lo12:.LCPI6_1]
	fdiv	d0, d0, d1
	adrp	x9, .LCPI6_0
	ldr	d1, [x9, :lo12:.LCPI6_0]
	fmul	d0, d0, d1
	stur	d0, [x8, #12]
	mov	w1, #10000                      // =0x2710
	bl	is_sorted
	subs	w8, w0, #0
	cset	w8, eq
	tbnz	w8, #0, .LBB6_6
	b	.LBB6_5
.LBB6_5:
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	printf
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldur	d0, [x8, #12]
	adrp	x0, .L.str.7
	add	x0, x0, :lo12:.L.str.7
	bl	printf
	b	.LBB6_7
.LBB6_6:
	adrp	x0, .L.str.8
	add	x0, x0, :lo12:.L.str.8
	bl	printf
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	mov	w8, #1                          // =0x1
	str	w8, [x9, #56]
	str	w8, [x9, #8]
	b	.LBB6_16
.LBB6_7:
	adrp	x0, .L.str.9
	add	x0, x0, :lo12:.L.str.9
	bl	printf
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	str	wzr, [x8, #4]
	b	.LBB6_8
.LBB6_8:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldr	w8, [x8, #4]
	subs	w8, w8, #10
	cset	w8, ge
	tbnz	w8, #0, .LBB6_11
	b	.LBB6_9
.LBB6_9:                                //   in Loop: Header=BB6_8 Depth=1
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldrsw	x9, [x8, #4]
	add	x8, sp, #36
	ldr	w1, [x8, x9, lsl #2]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printf
	b	.LBB6_10
.LBB6_10:                               //   in Loop: Header=BB6_8 Depth=1
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	ldr	w8, [x9, #4]
	add	w8, w8, #1
	str	w8, [x9, #4]
	b	.LBB6_8
.LBB6_11:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printf
	adrp	x0, .L.str.10
	add	x0, x0, :lo12:.L.str.10
	bl	printf
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	mov	w8, #9990                       // =0x2706
	str	w8, [x9]
	b	.LBB6_12
.LBB6_12:                               // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldr	w8, [x8]
	mov	w9, #10000                      // =0x2710
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB6_15
	b	.LBB6_13
.LBB6_13:                               //   in Loop: Header=BB6_12 Depth=1
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldrsw	x9, [x8]
	add	x8, sp, #36
	ldr	w1, [x8, x9, lsl #2]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printf
	b	.LBB6_14
.LBB6_14:                               //   in Loop: Header=BB6_12 Depth=1
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	ldr	w8, [x9]
	add	w8, w8, #1
	str	w8, [x9]
	b	.LBB6_12
.LBB6_15:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printf
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	str	wzr, [x9, #56]
	mov	w8, #1                          // =0x1
	str	w8, [x9, #8]
	b	.LBB6_16
.LBB6_16:
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldur	x9, [x8, #44]
	mov	sp, x9
	ldr	w0, [x8, #56]
	add	sp, sp, #9, lsl #12             // =36864
	add	sp, sp, #3232
	.cfi_def_cfa wsp, 32
	ldr	x28, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
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
	.asciz	"=== \345\277\253\351\200\237\346\216\222\345\272\217\347\256\227\346\263\225\346\265\213\350\257\225 ===\n"
	.size	.L.str.2, 34

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"\346\225\260\347\273\204\345\244\247\345\260\217: %d\n"
	.size	.L.str.3, 18

	.type	.L.str.4,@object                // @.str.4
.L.str.4:
	.asciz	"\345\216\237\345\247\213\346\225\260\347\273\204\345\267\262\347\224\237\346\210\220\n"
	.size	.L.str.4, 23

	.type	.L.str.5,@object                // @.str.5
.L.str.5:
	.asciz	"\346\216\222\345\272\217\345\211\215\345\211\21510\344\270\252\345\205\203\347\264\240: "
	.size	.L.str.5, 26

	.type	.L.str.6,@object                // @.str.6
.L.str.6:
	.asciz	"\342\234\223 \346\216\222\345\272\217\346\210\220\345\212\237\357\274\201\n"
	.size	.L.str.6, 21

	.type	.L.str.7,@object                // @.str.7
.L.str.7:
	.asciz	"\350\277\220\350\241\214\346\227\266\351\227\264: %.2f \346\257\253\347\247\222\n"
	.size	.L.str.7, 27

	.type	.L.str.8,@object                // @.str.8
.L.str.8:
	.asciz	"\342\234\227 \346\216\222\345\272\217\345\244\261\350\264\245\357\274\201\n"
	.size	.L.str.8, 21

	.type	.L.str.9,@object                // @.str.9
.L.str.9:
	.asciz	"\346\216\222\345\272\217\345\220\216\345\211\21510\344\270\252\345\205\203\347\264\240: "
	.size	.L.str.9, 26

	.type	.L.str.10,@object               // @.str.10
.L.str.10:
	.asciz	"\346\216\222\345\272\217\345\220\216\345\220\21610\344\270\252\345\205\203\347\264\240: "
	.size	.L.str.10, 26

	.ident	"BiSheng Enterprise 4.2.0.2.B002 clang version 17.0.6 (2261d9fde4e0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym swap
	.addrsig_sym partition
	.addrsig_sym quicksort
	.addrsig_sym printf
	.addrsig_sym generate_random_array
	.addrsig_sym srand
	.addrsig_sym time
	.addrsig_sym rand
	.addrsig_sym is_sorted
	.addrsig_sym clock
