	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.globl	__Z17findMinimumIndexCPfm ## -- Begin function _Z17findMinimumIndexCPfm
	.p2align	4, 0x90
__Z17findMinimumIndexCPfm:              ## @_Z17findMinimumIndexCPfm
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	cmpq	$2, %rsi
	jae	LBB0_2
## %bb.1:
	xorl	%eax, %eax
	popq	%rbp
	retq
LBB0_2:
	movss	(%rdi), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	leal	-1(%rsi), %r8d
	leaq	-2(%rsi), %rax
	andl	$3, %r8d
	cmpq	$3, %rax
	jae	LBB0_10
## %bb.3:
	movl	$1, %edx
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movaps	%xmm0, %xmm1
	testq	%r8, %r8
	jne	LBB0_5
	jmp	LBB0_9
LBB0_10:
	subq	%r8, %rsi
	movl	$1, %edx
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movaps	%xmm0, %xmm1
	.p2align	4, 0x90
LBB0_11:                                ## =>This Inner Loop Header: Depth=1
	testb	$1, %cl
	jne	LBB0_13
## %bb.12:                              ##   in Loop: Header=BB0_11 Depth=1
	movaps	%xmm0, %xmm1
LBB0_13:                                ##   in Loop: Header=BB0_11 Depth=1
	movss	(%rdi,%rdx,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm1
	cmovaq	%rdx, %rax
	movss	4(%rdi,%rdx,4), %xmm2   ## xmm2 = mem[0],zero,zero,zero
	minss	%xmm1, %xmm0
	ucomiss	%xmm2, %xmm0
	leaq	1(%rdx), %rcx
	cmovbeq	%rax, %rcx
	minss	%xmm0, %xmm2
	movss	8(%rdi,%rdx,4), %xmm0   ## xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm2
	leaq	2(%rdx), %r9
	cmovbeq	%rcx, %r9
	minss	%xmm2, %xmm0
	movss	12(%rdi,%rdx,4), %xmm1  ## xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	leaq	3(%rdx), %rax
	cmovbeq	%r9, %rax
	seta	%cl
	addq	$4, %rdx
	cmpq	%rdx, %rsi
	jne	LBB0_11
## %bb.4:
	testq	%r8, %r8
	je	LBB0_9
LBB0_5:
	negq	%r8
	.p2align	4, 0x90
LBB0_6:                                 ## =>This Inner Loop Header: Depth=1
	testb	$1, %cl
	jne	LBB0_8
## %bb.7:                               ##   in Loop: Header=BB0_6 Depth=1
	movaps	%xmm0, %xmm1
LBB0_8:                                 ##   in Loop: Header=BB0_6 Depth=1
	movss	(%rdi,%rdx,4), %xmm2    ## xmm2 = mem[0],zero,zero,zero
	ucomiss	%xmm2, %xmm1
	cmovaq	%rdx, %rax
	seta	%cl
	addq	$1, %rdx
	movaps	%xmm1, %xmm0
	movaps	%xmm2, %xmm1
	incq	%r8
	jne	LBB0_6
LBB0_9:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__Z19findMinimumIndexCPPPfm ## -- Begin function _Z19findMinimumIndexCPPPfm
	.p2align	4, 0x90
__Z19findMinimumIndexCPPPfm:            ## @_Z19findMinimumIndexCPPPfm
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, %rax
	cmpq	$2, %rsi
	jb	LBB1_18
## %bb.1:
	leaq	4(%rdi), %rcx
	leaq	-8(,%rsi,4), %r8
	movl	%r8d, %eax
	shrl	$2, %eax
	addl	$1, %eax
	andq	$3, %rax
	je	LBB1_2
## %bb.3:
	negq	%rax
	movq	%rdi, %rdx
	.p2align	4, 0x90
LBB1_4:                                 ## =>This Inner Loop Header: Depth=1
	movss	(%rdx), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	(%rcx), %xmm0
	movq	%rcx, %r9
	ja	LBB1_6
## %bb.5:                               ##   in Loop: Header=BB1_4 Depth=1
	movq	%rdx, %r9
LBB1_6:                                 ##   in Loop: Header=BB1_4 Depth=1
	addq	$4, %rcx
	movq	%r9, %rdx
	incq	%rax
	jne	LBB1_4
	jmp	LBB1_7
LBB1_2:
	movq	%rdi, %r9
LBB1_7:
	movq	%r9, %rax
	cmpq	$12, %r8
	jb	LBB1_18
## %bb.8:
	leaq	(%rdi,%rsi,4), %rsi
	.p2align	4, 0x90
LBB1_9:                                 ## =>This Inner Loop Header: Depth=1
	movss	(%r9), %xmm0            ## xmm0 = mem[0],zero,zero,zero
	ucomiss	(%rcx), %xmm0
	movq	%rcx, %rax
	ja	LBB1_11
## %bb.10:                              ##   in Loop: Header=BB1_9 Depth=1
	movq	%r9, %rax
LBB1_11:                                ##   in Loop: Header=BB1_9 Depth=1
	movss	(%rax), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	4(%rcx), %xmm0
	jbe	LBB1_13
## %bb.12:                              ##   in Loop: Header=BB1_9 Depth=1
	leaq	4(%rcx), %rax
LBB1_13:                                ##   in Loop: Header=BB1_9 Depth=1
	movss	(%rax), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rcx), %xmm0
	jbe	LBB1_15
## %bb.14:                              ##   in Loop: Header=BB1_9 Depth=1
	leaq	8(%rcx), %rax
LBB1_15:                                ##   in Loop: Header=BB1_9 Depth=1
	movss	(%rax), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	12(%rcx), %xmm0
	jbe	LBB1_17
## %bb.16:                              ##   in Loop: Header=BB1_9 Depth=1
	leaq	12(%rcx), %rax
LBB1_17:                                ##   in Loop: Header=BB1_9 Depth=1
	addq	$16, %rcx
	movq	%rax, %r9
	cmpq	%rsi, %rcx
	jne	LBB1_9
LBB1_18:
	subq	%rdi, %rax
	sarq	$2, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4               ## -- Begin function _Z25findMinimumIndexSSEUnRollPfm
LCPI2_0:
	.long	0                       ## 0x0
	.long	1                       ## 0x1
	.long	2                       ## 0x2
	.long	3                       ## 0x3
LCPI2_1:
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.long	4                       ## 0x4
LCPI2_2:
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__Z25findMinimumIndexSSEUnRollPfm
	.p2align	4, 0x90
__Z25findMinimumIndexSSEUnRollPfm:      ## @_Z25findMinimumIndexSSEUnRollPfm
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movaps	(%rdi), %xmm0
	testq	%rsi, %rsi
	je	LBB2_1
## %bb.4:
	movdqa	LCPI2_0(%rip), %xmm1    ## xmm1 = [0,1,2,3]
	movaps	LCPI2_0(%rip), %xmm6    ## xmm6 = [0,1,2,3]
	movl	$8, %eax
	movdqa	LCPI2_1(%rip), %xmm3    ## xmm3 = [4,4,4,4]
	movdqa	LCPI2_2(%rip), %xmm4    ## xmm4 = [8,8,8,8]
	movaps	%xmm6, %xmm5
	movaps	%xmm0, %xmm2
	jmp	LBB2_5
	.p2align	4, 0x90
LBB2_6:                                 ##   in Loop: Header=BB2_5 Depth=1
	paddd	%xmm4, %xmm1
	movaps	(%rdi,%rax,4), %xmm0
	addq	$8, %rax
	movdqa	%xmm1, %xmm6
LBB2_5:                                 ## =>This Inner Loop Header: Depth=1
	movaps	%xmm0, %xmm7
	cmpltps	%xmm2, %xmm7
	andps	%xmm7, %xmm6
	andnps	%xmm5, %xmm7
	orps	%xmm6, %xmm7
	minps	%xmm2, %xmm0
	movdqa	%xmm1, %xmm6
	paddd	%xmm3, %xmm6
	movaps	-16(%rdi,%rax,4), %xmm2
	movaps	%xmm2, %xmm5
	cmpltps	%xmm0, %xmm5
	pand	%xmm5, %xmm6
	andnps	%xmm7, %xmm5
	orps	%xmm6, %xmm5
	minps	%xmm0, %xmm2
	cmpq	%rsi, %rax
	jb	LBB2_6
## %bb.2:
	movd	%xmm5, %eax
	pshufd	$229, %xmm5, %xmm0      ## xmm0 = xmm5[1,1,2,3]
	movd	%xmm0, %esi
	pshufd	$78, %xmm5, %xmm0       ## xmm0 = xmm5[2,3,0,1]
	movd	%xmm0, %edx
	pshufd	$231, %xmm5, %xmm0      ## xmm0 = xmm5[3,1,2,3]
	movd	%xmm0, %ecx
	cltq
	movslq	%ecx, %rcx
	movslq	%edx, %rdx
	movslq	%esi, %rsi
	movaps	%xmm2, %xmm0
	jmp	LBB2_3
LBB2_1:
	movl	$3, %ecx
	movl	$2, %edx
	movl	$1, %esi
	xorl	%eax, %eax
LBB2_3:
	movaps	%xmm0, %xmm1
	shufps	$229, %xmm0, %xmm1      ## xmm1 = xmm1[1,1],xmm0[2,3]
	ucomiss	%xmm1, %xmm0
	movaps	%xmm0, %xmm2
	cmovaq	%rsi, %rax
	unpckhpd	%xmm0, %xmm2    ## xmm2 = xmm2[1],xmm0[1]
	minss	%xmm0, %xmm1
	ucomiss	%xmm2, %xmm1
	cmovaq	%rdx, %rax
	shufps	$231, %xmm0, %xmm0      ## xmm0 = xmm0[3,1,2,3]
	minss	%xmm1, %xmm2
	ucomiss	%xmm0, %xmm2
	cmovaq	%rcx, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4               ## -- Begin function _Z19findMinimumIndexSSEPfm
LCPI3_0:
	.quad	4294967296              ## 0x100000000
	.quad	12884901890             ## 0x300000002
LCPI3_1:
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__Z19findMinimumIndexSSEPfm
	.p2align	4, 0x90
__Z19findMinimumIndexSSEPfm:            ## @_Z19findMinimumIndexSSEPfm
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movaps	(%rdi), %xmm0
	cmpq	$5, %rsi
	jb	LBB3_1
## %bb.4:
	movl	$4, %eax
	movdqa	LCPI3_0(%rip), %xmm1    ## xmm1 = [4294967296,12884901890]
	movdqa	LCPI3_0(%rip), %xmm2    ## xmm2 = [4294967296,12884901890]
	movdqa	LCPI3_1(%rip), %xmm3    ## xmm3 = [4,4,4,4]
	.p2align	4, 0x90
LBB3_5:                                 ## =>This Inner Loop Header: Depth=1
	movaps	%xmm0, %xmm4
	paddd	%xmm3, %xmm2
	movaps	(%rdi,%rax,4), %xmm0
	movaps	%xmm0, %xmm5
	cmpltps	%xmm4, %xmm5
	movdqa	%xmm2, %xmm6
	pand	%xmm5, %xmm6
	pandn	%xmm1, %xmm5
	movdqa	%xmm5, %xmm1
	por	%xmm6, %xmm1
	minps	%xmm4, %xmm0
	addq	$4, %rax
	cmpq	%rsi, %rax
	jb	LBB3_5
## %bb.2:
	movd	%xmm1, %eax
	pshufd	$229, %xmm1, %xmm2      ## xmm2 = xmm1[1,1,2,3]
	movd	%xmm2, %esi
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %edx
	pshufd	$231, %xmm1, %xmm1      ## xmm1 = xmm1[3,1,2,3]
	movd	%xmm1, %ecx
	cltq
	movslq	%ecx, %rcx
	movslq	%edx, %rdx
	movslq	%esi, %rsi
	jmp	LBB3_3
LBB3_1:
	movl	$3, %ecx
	movl	$2, %edx
	movl	$1, %esi
	xorl	%eax, %eax
LBB3_3:
	movaps	%xmm0, %xmm1
	shufps	$229, %xmm0, %xmm1      ## xmm1 = xmm1[1,1],xmm0[2,3]
	ucomiss	%xmm1, %xmm0
	movaps	%xmm0, %xmm2
	cmovaq	%rsi, %rax
	unpckhpd	%xmm0, %xmm2    ## xmm2 = xmm2[1],xmm0[1]
	minss	%xmm0, %xmm1
	ucomiss	%xmm2, %xmm1
	cmovaq	%rdx, %rax
	shufps	$231, %xmm0, %xmm0      ## xmm0 = xmm0[3,1,2,3]
	minss	%xmm1, %xmm2
	ucomiss	%xmm0, %xmm2
	cmovaq	%rcx, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function main
LCPI4_0:
	.quad	4593671619917905920     ## double 0.125
LCPI4_1:
	.quad	4620693217682128896     ## double 8
LCPI4_2:
	.quad	4890909195324358656     ## double 9.2233720368547758E+18
LCPI4_3:
	.quad	4751297606875873280     ## double 4294967296
LCPI4_4:
	.quad	4318952042648305664     ## double 5.4210108624275222E-20
LCPI4_5:
	.quad	4621256167635550208     ## double 9
LCPI4_6:
	.quad	4607182418800017408     ## double 1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI4_7:
	.quad	4294967296              ## 0x100000000
	.quad	12884901890             ## 0x300000002
LCPI4_8:
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.long	4                       ## 0x4
	.long	4                       ## 0x4
LCPI4_9:
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$2552, %rsp             ## imm = 0x9F8
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	$5489, -2592(%rbp)      ## imm = 0x1571
	movl	$1, %eax
	movl	$5489, %edx             ## imm = 0x1571
	movl	$2, %ecx
	jmp	LBB4_1
	.p2align	4, 0x90
LBB4_144:                               ##   in Loop: Header=BB4_1 Depth=1
	leaq	1(%rax), %rdx
	movl	%esi, %edi
	shrl	$30, %edi
	xorl	%esi, %edi
	imull	$1812433253, %edi, %esi ## imm = 0x6C078965
	addl	%esi, %edx
	addl	%ecx, %esi
	movl	%esi, -2592(%rbp,%rcx,4)
	addq	$2, %rax
	addq	$2, %rcx
LBB4_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	%edx, %esi
	shrl	$30, %esi
	xorl	%edx, %esi
	imull	$1812433253, %esi, %esi ## imm = 0x6C078965
	addl	%eax, %esi
	movl	%esi, -2596(%rbp,%rcx,4)
	cmpq	$624, %rcx              ## imm = 0x270
	jne	LBB4_144
## %bb.2:
	movq	$0, -96(%rbp)
	movabsq	$343597383750, %rax     ## imm = 0x5000000046
	movq	%rax, -88(%rbp)
	leaq	-2592(%rbp), %rsi
	leaq	-88(%rbp), %rdi
	movq	%rdi, %rdx
	callq	__ZNSt3__124uniform_int_distributionIiEclINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEEEiRT_RKNS1_10param_typeE
	cltq
	leaq	-1(%rax), %rcx
	imulq	%rax, %rcx
	shrq	%rcx
	cvtsi2sdq	%rcx, %xmm0
	mulsd	LCPI4_0(%rip), %xmm0
	callq	_round
	mulsd	LCPI4_1(%rip), %xmm0
	movsd	LCPI4_2(%rip), %xmm1    ## xmm1 = mem[0],zero
	movapd	%xmm0, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx ## imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rbx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rbx
	leaq	-72(%rbp), %rdi
	xorpd	%xmm0, %xmm0
	movapd	%xmm0, -80(%rbp)
	movq	%rbx, -64(%rbp)
	leaq	4(,%rbx,4), %rdx
	movl	$32, %esi
	callq	_posix_memalign
	movq	-72(%rbp), %r9
	movq	%r9, -80(%rbp)
	movq	%rbx, -56(%rbp)         ## 8-byte Spill
	testq	%rbx, %rbx
	je	LBB4_6
## %bb.3:
	movq	-96(%rbp), %r14
	xorl	%r11d, %r11d
	movabsq	$945986875574848801, %r10 ## imm = 0xD20D20D20D20D21
	movl	$-2147483648, %r8d      ## imm = 0x80000000
	movsd	LCPI4_3(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	LCPI4_4(%rip), %xmm1    ## xmm1 = mem[0],zero
	movsd	LCPI4_5(%rip), %xmm2    ## xmm2 = mem[0],zero
	movsd	LCPI4_6(%rip), %xmm3    ## xmm3 = mem[0],zero
	.p2align	4, 0x90
LBB4_4:                                 ## =>This Inner Loop Header: Depth=1
	leaq	1(%r14), %r15
	movq	%r15, %rax
	shrq	$4, %rax
	mulq	%r10
	shrq	%rdx
	imulq	$624, %rdx, %rsi        ## imm = 0x270
	movl	-2592(%rbp,%r14,4), %edi
	leaq	397(%r14), %rax
	andl	%r8d, %edi
	shrq	$4, %rax
	mulq	%r10
	subq	%rsi, %r15
	movl	-2592(%rbp,%r15,4), %eax
	movl	%eax, %esi
	shrq	%rdx
	imulq	$624, %rdx, %rdx        ## imm = 0x270
	andl	$2147483646, %esi       ## imm = 0x7FFFFFFE
	negq	%rdx
	addq	%r14, %rdx
	addq	$397, %rdx              ## imm = 0x18D
	andl	$1, %eax
	orl	%edi, %esi
	imull	$-1727483681, %eax, %eax ## imm = 0x9908B0DF
	xorl	-2592(%rbp,%rdx,4), %eax
	shrl	%esi
	xorl	%esi, %eax
	movl	%eax, -2592(%rbp,%r14,4)
	movl	%eax, %ecx
	shrl	$11, %ecx
	xorl	%eax, %ecx
	movl	%ecx, %esi
	shll	$7, %esi
	andl	$-1658038656, %esi      ## imm = 0x9D2C5680
	leaq	1(%r15), %rax
	xorl	%ecx, %esi
	movl	%esi, %edi
	shrq	$4, %rax
	mulq	%r10
	shll	$15, %edi
	shrq	%rdx
	imulq	$624, %rdx, %rax        ## imm = 0x270
	negq	%rax
	andl	$-272236544, %edi       ## imm = 0xEFC60000
	leaq	(%r15,%rax), %r14
	addq	$1, %r14
	movl	-2592(%rbp,%r15,4), %r13d
	movl	-2592(%rbp,%r14,4), %ecx
	andl	%r8d, %r13d
	movl	%ecx, %ebx
	andl	$2147483646, %ebx       ## imm = 0x7FFFFFFE
	leaq	397(%r15), %r12
	movq	%r12, %rax
	shrq	$4, %rax
	xorl	%esi, %edi
	mulq	%r10
	shrq	%rdx
	orl	%r13d, %ebx
	imulq	$624, %rdx, %rax        ## imm = 0x270
	subq	%rax, %r12
	movl	%edi, %edx
	andl	$1, %ecx
	shrl	$18, %edx
	imull	$-1727483681, %ecx, %eax ## imm = 0x9908B0DF
	xorl	-2592(%rbp,%r12,4), %eax
	xorl	%edi, %edx
	shrl	%ebx
	xorl	%ebx, %eax
	movl	%eax, %ecx
	shrl	$11, %ecx
	xorl	%eax, %ecx
	movl	%ecx, %esi
	shll	$7, %esi
	andl	$-1658038656, %esi      ## imm = 0x9D2C5680
	xorl	%ecx, %esi
	movl	%esi, %ecx
	shll	$15, %ecx
	andl	$-272236544, %ecx       ## imm = 0xEFC60000
	xorl	%esi, %ecx
	movl	%ecx, %esi
	shrl	$18, %esi
	xorl	%ecx, %esi
	cvtsi2sdq	%rsi, %xmm4
	cvtsi2sdq	%rdx, %xmm5
	mulsd	%xmm0, %xmm4
	addsd	%xmm5, %xmm4
	mulsd	%xmm1, %xmm4
	mulsd	%xmm2, %xmm4
	addsd	%xmm3, %xmm4
	cvtsd2ss	%xmm4, %xmm4
	movl	%eax, -2592(%rbp,%r15,4)
	movss	%xmm4, (%r9,%r11,4)
	addq	$1, %r11
	cmpq	%r11, -56(%rbp)         ## 8-byte Folded Reload
	jne	LBB4_4
## %bb.5:
	movq	%r14, -96(%rbp)
LBB4_6:
Ltmp0:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str(%rip), %rsi
	movl	$20, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp1:
## %bb.7:
	movq	-64(%rbp), %rsi
Ltmp2:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp3:
## %bb.8:
	movb	$10, -41(%rbp)
Ltmp4:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp5:
## %bb.9:
Ltmp6:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	movl	$22, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp7:
## %bb.10:
	movq	-80(%rbp), %rsi
	andl	$31, %esi
Ltmp8:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp9:
## %bb.11:
Ltmp10:
	leaq	L_.str.2(%rip), %rsi
	movl	$6, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp11:
## %bb.12:
	movb	$10, -41(%rbp)
Ltmp12:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp13:
## %bb.13:
Ltmp14:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.3(%rip), %rsi
	movl	$9, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp15:
## %bb.14:
	movq	-80(%rbp), %rsi
Ltmp16:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp17:
## %bb.15:
	movb	$10, -41(%rbp)
Ltmp18:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp19:
## %bb.16:
Ltmp20:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.4(%rip), %rsi
	movl	$9, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp21:
## %bb.17:
	movq	-80(%rbp), %rsi
	addq	$4, %rsi
Ltmp22:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp23:
## %bb.18:
	movb	$10, -41(%rbp)
Ltmp24:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp25:
## %bb.19:
Ltmp26:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.5(%rip), %rsi
	movl	$9, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp27:
## %bb.20:
	movq	-80(%rbp), %rsi
	addq	$8, %rsi
Ltmp28:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp29:
## %bb.21:
	movb	$10, -41(%rbp)
Ltmp30:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp31:
## %bb.22:
Ltmp32:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.6(%rip), %rsi
	movl	$9, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp33:
## %bb.23:
	movq	-80(%rbp), %rsi
	addq	$12, %rsi
Ltmp34:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp35:
## %bb.24:
	movb	$10, -41(%rbp)
Ltmp36:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp37:
## %bb.25:
	cmpq	$2, -56(%rbp)           ## 8-byte Folded Reload
	jae	LBB4_27
## %bb.26:
	xorl	%ebx, %ebx
	jmp	LBB4_38
LBB4_27:
	movq	-80(%rbp), %rax
	movss	(%rax), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	movq	-56(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdx
	leal	-1(%rcx), %ecx
	leaq	-2(%rdx), %rdx
	andl	$3, %ecx
	cmpq	$3, %rdx
	jae	LBB4_29
## %bb.28:
	movl	$1, %edx
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	movaps	%xmm0, %xmm1
	testq	%rcx, %rcx
	jne	LBB4_34
	jmp	LBB4_38
LBB4_29:
	movq	-56(%rbp), %r8          ## 8-byte Reload
	subq	%rcx, %r8
	movl	$1, %edx
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	movaps	%xmm0, %xmm1
	.p2align	4, 0x90
LBB4_30:                                ## =>This Inner Loop Header: Depth=1
	testb	$1, %sil
	jne	LBB4_32
## %bb.31:                              ##   in Loop: Header=BB4_30 Depth=1
	movaps	%xmm0, %xmm1
LBB4_32:                                ##   in Loop: Header=BB4_30 Depth=1
	movss	(%rax,%rdx,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm1
	cmovaq	%rdx, %rbx
	movss	4(%rax,%rdx,4), %xmm2   ## xmm2 = mem[0],zero,zero,zero
	minss	%xmm1, %xmm0
	ucomiss	%xmm2, %xmm0
	leaq	1(%rdx), %rsi
	cmovbeq	%rbx, %rsi
	minss	%xmm0, %xmm2
	movss	8(%rax,%rdx,4), %xmm0   ## xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm2
	leaq	2(%rdx), %rdi
	cmovbeq	%rsi, %rdi
	minss	%xmm2, %xmm0
	movss	12(%rax,%rdx,4), %xmm1  ## xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	leaq	3(%rdx), %rbx
	cmovbeq	%rdi, %rbx
	seta	%sil
	addq	$4, %rdx
	cmpq	%rdx, %r8
	jne	LBB4_30
## %bb.33:
	testq	%rcx, %rcx
	je	LBB4_38
LBB4_34:
	negq	%rcx
	.p2align	4, 0x90
LBB4_35:                                ## =>This Inner Loop Header: Depth=1
	testb	$1, %sil
	jne	LBB4_37
## %bb.36:                              ##   in Loop: Header=BB4_35 Depth=1
	movaps	%xmm0, %xmm1
LBB4_37:                                ##   in Loop: Header=BB4_35 Depth=1
	movss	(%rax,%rdx,4), %xmm2    ## xmm2 = mem[0],zero,zero,zero
	ucomiss	%xmm2, %xmm1
	cmovaq	%rdx, %rbx
	seta	%sil
	addq	$1, %rdx
	movaps	%xmm1, %xmm0
	movaps	%xmm2, %xmm1
	incq	%rcx
	jne	LBB4_35
LBB4_38:
Ltmp38:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.7(%rip), %rsi
	movl	$12, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp39:
## %bb.39:
Ltmp40:
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp41:
## %bb.40:
	movb	$10, -41(%rbp)
Ltmp42:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp43:
## %bb.41:
	movb	$10, -41(%rbp)
Ltmp45:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp46:
## %bb.42:
Ltmp47:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.8(%rip), %rsi
	movl	$24, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp48:
## %bb.43:
	movb	$10, -41(%rbp)
Ltmp49:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp50:
## %bb.44:
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r14
	cmpq	$2, -56(%rbp)           ## 8-byte Folded Reload
	jae	LBB4_46
## %bb.45:
	xorl	%ebx, %ebx
	jmp	LBB4_57
LBB4_46:
	movq	-80(%rbp), %rax
	movss	(%rax), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	movq	-56(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdx
	leal	-1(%rcx), %ecx
	leaq	-2(%rdx), %rdx
	andl	$3, %ecx
	cmpq	$3, %rdx
	jae	LBB4_48
## %bb.47:
	movl	$1, %edx
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	movaps	%xmm0, %xmm1
	testq	%rcx, %rcx
	jne	LBB4_53
	jmp	LBB4_57
LBB4_48:
	movq	-56(%rbp), %r8          ## 8-byte Reload
	subq	%rcx, %r8
	movl	$1, %edx
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	movaps	%xmm0, %xmm1
	.p2align	4, 0x90
LBB4_49:                                ## =>This Inner Loop Header: Depth=1
	testb	$1, %sil
	jne	LBB4_51
## %bb.50:                              ##   in Loop: Header=BB4_49 Depth=1
	movaps	%xmm0, %xmm1
LBB4_51:                                ##   in Loop: Header=BB4_49 Depth=1
	movss	(%rax,%rdx,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm1
	cmovaq	%rdx, %rbx
	movss	4(%rax,%rdx,4), %xmm2   ## xmm2 = mem[0],zero,zero,zero
	minss	%xmm1, %xmm0
	ucomiss	%xmm2, %xmm0
	leaq	1(%rdx), %rsi
	cmovbeq	%rbx, %rsi
	minss	%xmm0, %xmm2
	movss	8(%rax,%rdx,4), %xmm0   ## xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm2
	leaq	2(%rdx), %rdi
	cmovbeq	%rsi, %rdi
	minss	%xmm2, %xmm0
	movss	12(%rax,%rdx,4), %xmm1  ## xmm1 = mem[0],zero,zero,zero
	ucomiss	%xmm1, %xmm0
	leaq	3(%rdx), %rbx
	cmovbeq	%rdi, %rbx
	seta	%sil
	addq	$4, %rdx
	cmpq	%rdx, %r8
	jne	LBB4_49
## %bb.52:
	testq	%rcx, %rcx
	je	LBB4_57
LBB4_53:
	negq	%rcx
	.p2align	4, 0x90
LBB4_54:                                ## =>This Inner Loop Header: Depth=1
	testb	$1, %sil
	jne	LBB4_56
## %bb.55:                              ##   in Loop: Header=BB4_54 Depth=1
	movaps	%xmm0, %xmm1
LBB4_56:                                ##   in Loop: Header=BB4_54 Depth=1
	movss	(%rax,%rdx,4), %xmm2    ## xmm2 = mem[0],zero,zero,zero
	ucomiss	%xmm2, %xmm1
	cmovaq	%rdx, %rbx
	seta	%sil
	addq	$1, %rdx
	movaps	%xmm1, %xmm0
	movaps	%xmm2, %xmm1
	incq	%rcx
	jne	LBB4_54
LBB4_57:
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r15
Ltmp51:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.9(%rip), %rsi
	movl	$6, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp52:
## %bb.58:
	subq	%r14, %r15
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%r15, %xmm0
Ltmp53:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
Ltmp54:
## %bb.59:
Ltmp55:
	leaq	L_.str.10(%rip), %rsi
	movl	$2, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp56:
## %bb.60:
	movb	$10, -41(%rbp)
Ltmp57:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp58:
## %bb.61:
Ltmp60:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.11(%rip), %rsi
	movl	$14, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp61:
## %bb.62:
Ltmp62:
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp63:
## %bb.63:
Ltmp64:
	leaq	L_.str.12(%rip), %rsi
	movl	$12, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp65:
## %bb.64:
	movq	-80(%rbp), %rcx
	movss	(%rcx,%rbx,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
Ltmp66:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEf
Ltmp67:
## %bb.65:
	movb	$10, -41(%rbp)
Ltmp68:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp69:
## %bb.66:
	movb	$10, -41(%rbp)
Ltmp71:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp72:
## %bb.67:
Ltmp73:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.13(%rip), %rsi
	movl	$28, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp74:
## %bb.68:
	movb	$10, -41(%rbp)
Ltmp75:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp76:
## %bb.69:
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r14
	movq	-80(%rbp), %r13
	movq	%r13, %rbx
	cmpq	$2, -56(%rbp)           ## 8-byte Folded Reload
	jb	LBB4_87
## %bb.70:
	leaq	4(%r13), %rax
	movq	-56(%rbp), %rcx         ## 8-byte Reload
	leaq	-8(,%rcx,4), %rcx
	movl	%ecx, %esi
	shrl	$2, %esi
	addl	$1, %esi
	andq	$3, %rsi
	je	LBB4_71
## %bb.72:
	negq	%rsi
	movq	%r13, %rdi
	.p2align	4, 0x90
LBB4_73:                                ## =>This Inner Loop Header: Depth=1
	movss	(%rdi), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	(%rax), %xmm0
	movq	%rax, %rdx
	ja	LBB4_75
## %bb.74:                              ##   in Loop: Header=BB4_73 Depth=1
	movq	%rdi, %rdx
LBB4_75:                                ##   in Loop: Header=BB4_73 Depth=1
	addq	$4, %rax
	movq	%rdx, %rdi
	incq	%rsi
	jne	LBB4_73
	jmp	LBB4_76
LBB4_71:
	movq	%r13, %rdx
LBB4_76:
	movq	%rdx, %rbx
	cmpq	$12, %rcx
	jb	LBB4_87
## %bb.77:
	movq	-56(%rbp), %rcx         ## 8-byte Reload
	leaq	(,%rcx,4), %rcx
	addq	%r13, %rcx
	.p2align	4, 0x90
LBB4_78:                                ## =>This Inner Loop Header: Depth=1
	movss	(%rdx), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	(%rax), %xmm0
	movq	%rax, %rbx
	ja	LBB4_80
## %bb.79:                              ##   in Loop: Header=BB4_78 Depth=1
	movq	%rdx, %rbx
LBB4_80:                                ##   in Loop: Header=BB4_78 Depth=1
	movss	(%rbx), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	4(%rax), %xmm0
	jbe	LBB4_82
## %bb.81:                              ##   in Loop: Header=BB4_78 Depth=1
	leaq	4(%rax), %rbx
LBB4_82:                                ##   in Loop: Header=BB4_78 Depth=1
	movss	(%rbx), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	jbe	LBB4_84
## %bb.83:                              ##   in Loop: Header=BB4_78 Depth=1
	leaq	8(%rax), %rbx
LBB4_84:                                ##   in Loop: Header=BB4_78 Depth=1
	movss	(%rbx), %xmm0           ## xmm0 = mem[0],zero,zero,zero
	ucomiss	12(%rax), %xmm0
	jbe	LBB4_86
## %bb.85:                              ##   in Loop: Header=BB4_78 Depth=1
	leaq	12(%rax), %rbx
LBB4_86:                                ##   in Loop: Header=BB4_78 Depth=1
	addq	$16, %rax
	movq	%rbx, %rdx
	cmpq	%rcx, %rax
	jne	LBB4_78
LBB4_87:
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r15
Ltmp77:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.9(%rip), %rsi
	movl	$6, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp78:
## %bb.88:
	subq	%r14, %r15
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%r15, %xmm0
Ltmp79:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
Ltmp80:
## %bb.89:
Ltmp81:
	leaq	L_.str.10(%rip), %rsi
	movl	$2, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp82:
## %bb.90:
	movb	$10, -41(%rbp)
Ltmp83:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp84:
## %bb.91:
Ltmp86:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.11(%rip), %rsi
	movl	$14, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp87:
## %bb.92:
	subq	%r13, %rbx
	sarq	$2, %rbx
Ltmp88:
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp89:
## %bb.93:
Ltmp90:
	leaq	L_.str.12(%rip), %rsi
	movl	$12, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp91:
## %bb.94:
	movq	-80(%rbp), %rcx
	movss	(%rcx,%rbx,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
Ltmp92:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEf
Ltmp93:
## %bb.95:
	movb	$10, -41(%rbp)
Ltmp94:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp95:
## %bb.96:
	movb	$10, -41(%rbp)
Ltmp97:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp98:
## %bb.97:
Ltmp99:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.14(%rip), %rsi
	movl	$26, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp100:
## %bb.98:
	movb	$10, -41(%rbp)
Ltmp101:
	leaq	-41(%rbp), %rsi
	movl	$1, %ebx
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp102:
## %bb.99:
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r14
	movq	-80(%rbp), %rax
	movaps	(%rax), %xmm0
	cmpq	$5, -56(%rbp)           ## 8-byte Folded Reload
	jb	LBB4_100
## %bb.101:
	movl	$4, %ecx
	movdqa	LCPI4_7(%rip), %xmm1    ## xmm1 = [4294967296,12884901890]
	movdqa	LCPI4_7(%rip), %xmm2    ## xmm2 = [4294967296,12884901890]
	movdqa	LCPI4_8(%rip), %xmm3    ## xmm3 = [4,4,4,4]
	.p2align	4, 0x90
LBB4_102:                               ## =>This Inner Loop Header: Depth=1
	movaps	%xmm0, %xmm4
	paddd	%xmm3, %xmm2
	movaps	(%rax,%rcx,4), %xmm0
	movaps	%xmm0, %xmm5
	cmpltps	%xmm4, %xmm5
	movdqa	%xmm2, %xmm6
	pand	%xmm5, %xmm6
	pandn	%xmm1, %xmm5
	movdqa	%xmm5, %xmm1
	por	%xmm6, %xmm1
	minps	%xmm4, %xmm0
	addq	$4, %rcx
	cmpq	-56(%rbp), %rcx         ## 8-byte Folded Reload
	jb	LBB4_102
## %bb.103:
	movd	%xmm1, %eax
	pshufd	$229, %xmm1, %xmm2      ## xmm2 = xmm1[1,1,2,3]
	movd	%xmm2, %edx
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %ecx
	pshufd	$231, %xmm1, %xmm1      ## xmm1 = xmm1[3,1,2,3]
	movd	%xmm1, %esi
	movslq	%eax, %r15
	movslq	%esi, %rax
	movslq	%ecx, %rcx
	movslq	%edx, %rbx
	jmp	LBB4_104
LBB4_100:
	movl	$3, %eax
	movl	$2, %ecx
	xorl	%r15d, %r15d
LBB4_104:
	movaps	%xmm0, %xmm1
	shufps	$229, %xmm0, %xmm1      ## xmm1 = xmm1[1,1],xmm0[2,3]
	ucomiss	%xmm1, %xmm0
	movaps	%xmm0, %xmm2
	cmovaq	%rbx, %r15
	unpckhpd	%xmm0, %xmm2    ## xmm2 = xmm2[1],xmm0[1]
	minss	%xmm0, %xmm1
	ucomiss	%xmm2, %xmm1
	cmovaq	%rcx, %r15
	shufps	$231, %xmm0, %xmm0      ## xmm0 = xmm0[3,1,2,3]
	minss	%xmm1, %xmm2
	ucomiss	%xmm0, %xmm2
	cmovaq	%rax, %r15
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %rbx
Ltmp103:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.9(%rip), %rsi
	movl	$6, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp104:
## %bb.105:
	subq	%r14, %rbx
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rbx, %xmm0
Ltmp105:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
Ltmp106:
## %bb.106:
Ltmp107:
	leaq	L_.str.10(%rip), %rsi
	movl	$2, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp108:
## %bb.107:
	movb	$10, -41(%rbp)
Ltmp109:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp110:
## %bb.108:
Ltmp112:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.11(%rip), %rsi
	movl	$14, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp113:
## %bb.109:
Ltmp114:
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp115:
## %bb.110:
Ltmp116:
	leaq	L_.str.12(%rip), %rsi
	movl	$12, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp117:
## %bb.111:
	movq	-80(%rbp), %rcx
	movss	(%rcx,%r15,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
Ltmp118:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEf
Ltmp119:
## %bb.112:
	movb	$10, -41(%rbp)
Ltmp120:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp121:
## %bb.113:
	movb	$10, -41(%rbp)
Ltmp123:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp124:
## %bb.114:
Ltmp125:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.15(%rip), %rsi
	movl	$32, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp126:
## %bb.115:
	movb	$10, -41(%rbp)
Ltmp127:
	leaq	-41(%rbp), %rsi
	movl	$1, %ebx
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp128:
## %bb.116:
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r14
	movq	-80(%rbp), %rax
	movaps	(%rax), %xmm0
	cmpq	$0, -56(%rbp)           ## 8-byte Folded Reload
	je	LBB4_117
## %bb.118:
	movdqa	LCPI4_7(%rip), %xmm1    ## xmm1 = [4294967296,12884901890]
	movaps	LCPI4_7(%rip), %xmm6    ## xmm6 = [4294967296,12884901890]
	movl	$8, %ecx
	movdqa	LCPI4_8(%rip), %xmm3    ## xmm3 = [4,4,4,4]
	movdqa	LCPI4_9(%rip), %xmm4    ## xmm4 = [8,8,8,8]
	movaps	%xmm6, %xmm5
	movaps	%xmm0, %xmm2
	jmp	LBB4_119
	.p2align	4, 0x90
LBB4_120:                               ##   in Loop: Header=BB4_119 Depth=1
	paddd	%xmm4, %xmm1
	movaps	(%rax,%rcx,4), %xmm0
	addq	$8, %rcx
	movdqa	%xmm1, %xmm6
LBB4_119:                               ## =>This Inner Loop Header: Depth=1
	movaps	%xmm0, %xmm7
	cmpltps	%xmm2, %xmm7
	andps	%xmm7, %xmm6
	andnps	%xmm5, %xmm7
	orps	%xmm6, %xmm7
	minps	%xmm2, %xmm0
	movdqa	%xmm1, %xmm6
	paddd	%xmm3, %xmm6
	movaps	-16(%rax,%rcx,4), %xmm2
	movaps	%xmm2, %xmm5
	cmpltps	%xmm0, %xmm5
	pand	%xmm5, %xmm6
	andnps	%xmm7, %xmm5
	orps	%xmm6, %xmm5
	minps	%xmm0, %xmm2
	cmpq	-56(%rbp), %rcx         ## 8-byte Folded Reload
	jb	LBB4_120
## %bb.121:
	movd	%xmm5, %eax
	pshufd	$229, %xmm5, %xmm0      ## xmm0 = xmm5[1,1,2,3]
	movd	%xmm0, %edx
	pshufd	$78, %xmm5, %xmm0       ## xmm0 = xmm5[2,3,0,1]
	movd	%xmm0, %ecx
	pshufd	$231, %xmm5, %xmm0      ## xmm0 = xmm5[3,1,2,3]
	movd	%xmm0, %esi
	movslq	%eax, %r15
	movslq	%esi, %rax
	movslq	%ecx, %rcx
	movslq	%edx, %rbx
	movaps	%xmm2, %xmm0
	jmp	LBB4_122
LBB4_117:
	xorl	%r15d, %r15d
	movl	$3, %eax
	movl	$2, %ecx
LBB4_122:
	movaps	%xmm0, %xmm1
	shufps	$229, %xmm0, %xmm1      ## xmm1 = xmm1[1,1],xmm0[2,3]
	ucomiss	%xmm1, %xmm0
	movaps	%xmm0, %xmm2
	cmovaq	%rbx, %r15
	unpckhpd	%xmm0, %xmm2    ## xmm2 = xmm2[1],xmm0[1]
	minss	%xmm0, %xmm1
	ucomiss	%xmm2, %xmm1
	cmovaq	%rcx, %r15
	shufps	$231, %xmm0, %xmm0      ## xmm0 = xmm0[3,1,2,3]
	minss	%xmm1, %xmm2
	ucomiss	%xmm0, %xmm2
	cmovaq	%rax, %r15
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %rbx
Ltmp129:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.9(%rip), %rsi
	movl	$6, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp130:
## %bb.123:
	subq	%r14, %rbx
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rbx, %xmm0
Ltmp131:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
Ltmp132:
## %bb.124:
Ltmp133:
	leaq	L_.str.10(%rip), %rsi
	movl	$2, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp134:
## %bb.125:
	movb	$10, -41(%rbp)
Ltmp135:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp136:
## %bb.126:
Ltmp138:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.11(%rip), %rsi
	movl	$14, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp139:
## %bb.127:
Ltmp140:
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp141:
## %bb.128:
Ltmp142:
	leaq	L_.str.12(%rip), %rsi
	movl	$12, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp143:
## %bb.129:
	movq	-80(%rbp), %rcx
	movss	(%rcx,%r15,4), %xmm0    ## xmm0 = mem[0],zero,zero,zero
Ltmp144:
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEf
Ltmp145:
## %bb.130:
	movb	$10, -41(%rbp)
Ltmp146:
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	movq	%rax, %rdi
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp147:
## %bb.131:
	movb	$10, -41(%rbp)
Ltmp149:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	-41(%rbp), %rsi
	movl	$1, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp150:
## %bb.132:
	movq	-80(%rbp), %rdi
	callq	_free
	xorl	%eax, %eax
	addq	$2552, %rsp             ## imm = 0x9F8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB4_142:
Ltmp137:
	jmp	LBB4_143
LBB4_140:
Ltmp111:
	jmp	LBB4_143
LBB4_138:
Ltmp85:
	jmp	LBB4_143
LBB4_136:
Ltmp59:
	jmp	LBB4_143
LBB4_134:
Ltmp44:
	jmp	LBB4_143
LBB4_141:
Ltmp148:
	jmp	LBB4_143
LBB4_139:
Ltmp122:
	jmp	LBB4_143
LBB4_137:
Ltmp96:
	jmp	LBB4_143
LBB4_135:
Ltmp70:
	jmp	LBB4_143
LBB4_133:
Ltmp151:
LBB4_143:
	movq	%rax, %rbx
	movq	-80(%rbp), %rdi
	callq	_free
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table4:
Lexception0:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	255                     ## @TType Encoding = omit
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0 ## >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0     ##   Call between Lfunc_begin0 and Ltmp0
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0     ## >> Call Site 2 <<
	.uleb128 Ltmp37-Ltmp0           ##   Call between Ltmp0 and Ltmp37
	.uleb128 Ltmp151-Lfunc_begin0   ##     jumps to Ltmp151
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp38-Lfunc_begin0    ## >> Call Site 3 <<
	.uleb128 Ltmp43-Ltmp38          ##   Call between Ltmp38 and Ltmp43
	.uleb128 Ltmp44-Lfunc_begin0    ##     jumps to Ltmp44
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp45-Lfunc_begin0    ## >> Call Site 4 <<
	.uleb128 Ltmp50-Ltmp45          ##   Call between Ltmp45 and Ltmp50
	.uleb128 Ltmp151-Lfunc_begin0   ##     jumps to Ltmp151
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp51-Lfunc_begin0    ## >> Call Site 5 <<
	.uleb128 Ltmp52-Ltmp51          ##   Call between Ltmp51 and Ltmp52
	.uleb128 Ltmp70-Lfunc_begin0    ##     jumps to Ltmp70
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp53-Lfunc_begin0    ## >> Call Site 6 <<
	.uleb128 Ltmp58-Ltmp53          ##   Call between Ltmp53 and Ltmp58
	.uleb128 Ltmp59-Lfunc_begin0    ##     jumps to Ltmp59
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp60-Lfunc_begin0    ## >> Call Site 7 <<
	.uleb128 Ltmp69-Ltmp60          ##   Call between Ltmp60 and Ltmp69
	.uleb128 Ltmp70-Lfunc_begin0    ##     jumps to Ltmp70
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp71-Lfunc_begin0    ## >> Call Site 8 <<
	.uleb128 Ltmp76-Ltmp71          ##   Call between Ltmp71 and Ltmp76
	.uleb128 Ltmp151-Lfunc_begin0   ##     jumps to Ltmp151
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp77-Lfunc_begin0    ## >> Call Site 9 <<
	.uleb128 Ltmp78-Ltmp77          ##   Call between Ltmp77 and Ltmp78
	.uleb128 Ltmp96-Lfunc_begin0    ##     jumps to Ltmp96
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp79-Lfunc_begin0    ## >> Call Site 10 <<
	.uleb128 Ltmp84-Ltmp79          ##   Call between Ltmp79 and Ltmp84
	.uleb128 Ltmp85-Lfunc_begin0    ##     jumps to Ltmp85
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp86-Lfunc_begin0    ## >> Call Site 11 <<
	.uleb128 Ltmp95-Ltmp86          ##   Call between Ltmp86 and Ltmp95
	.uleb128 Ltmp96-Lfunc_begin0    ##     jumps to Ltmp96
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp97-Lfunc_begin0    ## >> Call Site 12 <<
	.uleb128 Ltmp102-Ltmp97         ##   Call between Ltmp97 and Ltmp102
	.uleb128 Ltmp151-Lfunc_begin0   ##     jumps to Ltmp151
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp103-Lfunc_begin0   ## >> Call Site 13 <<
	.uleb128 Ltmp104-Ltmp103        ##   Call between Ltmp103 and Ltmp104
	.uleb128 Ltmp122-Lfunc_begin0   ##     jumps to Ltmp122
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp105-Lfunc_begin0   ## >> Call Site 14 <<
	.uleb128 Ltmp110-Ltmp105        ##   Call between Ltmp105 and Ltmp110
	.uleb128 Ltmp111-Lfunc_begin0   ##     jumps to Ltmp111
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp112-Lfunc_begin0   ## >> Call Site 15 <<
	.uleb128 Ltmp121-Ltmp112        ##   Call between Ltmp112 and Ltmp121
	.uleb128 Ltmp122-Lfunc_begin0   ##     jumps to Ltmp122
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp123-Lfunc_begin0   ## >> Call Site 16 <<
	.uleb128 Ltmp128-Ltmp123        ##   Call between Ltmp123 and Ltmp128
	.uleb128 Ltmp151-Lfunc_begin0   ##     jumps to Ltmp151
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp129-Lfunc_begin0   ## >> Call Site 17 <<
	.uleb128 Ltmp130-Ltmp129        ##   Call between Ltmp129 and Ltmp130
	.uleb128 Ltmp148-Lfunc_begin0   ##     jumps to Ltmp148
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp131-Lfunc_begin0   ## >> Call Site 18 <<
	.uleb128 Ltmp136-Ltmp131        ##   Call between Ltmp131 and Ltmp136
	.uleb128 Ltmp137-Lfunc_begin0   ##     jumps to Ltmp137
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp138-Lfunc_begin0   ## >> Call Site 19 <<
	.uleb128 Ltmp147-Ltmp138        ##   Call between Ltmp138 and Ltmp147
	.uleb128 Ltmp148-Lfunc_begin0   ##     jumps to Ltmp148
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp149-Lfunc_begin0   ## >> Call Site 20 <<
	.uleb128 Ltmp150-Ltmp149        ##   Call between Ltmp149 and Ltmp150
	.uleb128 Ltmp151-Lfunc_begin0   ##     jumps to Ltmp151
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp150-Lfunc_begin0   ## >> Call Site 21 <<
	.uleb128 Lfunc_end0-Ltmp150     ##   Call between Ltmp150 and Lfunc_end0
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end0:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZNSt3__124uniform_int_distributionIiEclINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEEEiRT_RKNS1_10param_typeE ## -- Begin function _ZNSt3__124uniform_int_distributionIiEclINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEEEiRT_RKNS1_10param_typeE
	.weak_def_can_be_hidden	__ZNSt3__124uniform_int_distributionIiEclINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEEEiRT_RKNS1_10param_typeE
	.p2align	4, 0x90
__ZNSt3__124uniform_int_distributionIiEclINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEEEiRT_RKNS1_10param_typeE: ## @_ZNSt3__124uniform_int_distributionIiEclINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEEEiRT_RKNS1_10param_typeE
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	(%rdx), %eax
	movl	4(%rdx), %r10d
	subl	%eax, %r10d
	je	LBB5_6
## %bb.1:
	addl	$1, %r10d
	je	LBB5_2
## %bb.3:
	movq	%rdx, %r8
	bsrl	%r10d, %eax
	xorl	$31, %eax
	movl	$32, %r9d
	subq	%rax, %r9
	movb	$33, %cl
	subb	%r9b, %cl
	movl	%r10d, %eax
	shll	%cl, %eax
	shrl	%cl, %eax
	cmpl	$1, %eax
	sbbq	$0, %r9
	movq	%r9, %rbx
	shrq	$5, %rbx
	movl	%r9d, %eax
	andl	$31, %eax
	cmpq	$1, %rax
	sbbq	$-1, %rbx
	xorl	%r11d, %r11d
	movq	%r9, %rax
	xorl	%edx, %edx
	divq	%rbx
	negb	%al
	movl	$-1, %r14d
	movl	%eax, %ecx
	shrl	%cl, %r14d
	cmpq	%r9, %rbx
	cmoval	%r11d, %r14d
	movq	2496(%rsi), %r15
	movabsq	$945986875574848801, %r11 ## imm = 0xD20D20D20D20D21
	movl	$-2147483648, %r9d      ## imm = 0x80000000
	.p2align	4, 0x90
LBB5_4:                                 ## =>This Inner Loop Header: Depth=1
	movq	%r15, %r12
	leaq	1(%r15), %rax
	shrq	$4, %rax
	mulq	%r11
	shrq	%rdx
	imulq	$624, %rdx, %rax        ## imm = 0x270
	negq	%rax
	addq	%rax, %r15
	addq	$1, %r15
	movl	(%rsi,%r12,4), %edi
	andl	%r9d, %edi
	movl	(%rsi,%r15,4), %ebx
	movl	%ebx, %ecx
	andl	$2147483646, %ecx       ## imm = 0x7FFFFFFE
	leaq	397(%r12), %rax
	shrq	$4, %rax
	mulq	%r11
	orl	%edi, %ecx
	shrq	%rdx
	imulq	$624, %rdx, %rax        ## imm = 0x270
	negq	%rax
	addq	%r12, %rax
	addq	$397, %rax              ## imm = 0x18D
	shrl	%ecx
	andl	$1, %ebx
	imull	$-1727483681, %ebx, %edx ## imm = 0x9908B0DF
	xorl	(%rsi,%rax,4), %edx
	xorl	%ecx, %edx
	movl	%edx, (%rsi,%r12,4)
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%edx, %eax
	movl	%eax, %ecx
	shll	$7, %ecx
	andl	$-1658038656, %ecx      ## imm = 0x9D2C5680
	xorl	%eax, %ecx
	movl	%ecx, %edx
	shll	$15, %edx
	andl	$-272236544, %edx       ## imm = 0xEFC60000
	xorl	%ecx, %edx
	movl	%edx, %eax
	shrl	$18, %eax
	xorl	%edx, %eax
	andl	%r14d, %eax
	cmpl	%r10d, %eax
	jae	LBB5_4
## %bb.5:
	movq	%r15, 2496(%rsi)
	addl	(%r8), %eax
	jmp	LBB5_6
LBB5_2:
	movq	2496(%rsi), %rcx
	leaq	1(%rcx), %rax
	shrq	$4, %rax
	movabsq	$945986875574848801, %r8 ## imm = 0xD20D20D20D20D21
	mulq	%r8
	shrq	%rdx
	imulq	$624, %rdx, %rax        ## imm = 0x270
	negq	%rax
	leaq	(%rcx,%rax), %r9
	addq	$1, %r9
	movl	$-2147483648, %eax      ## imm = 0x80000000
	andl	(%rsi,%rcx,4), %eax
	movl	(%rsi,%r9,4), %edi
	movl	%edi, %ebx
	andl	$2147483646, %ebx       ## imm = 0x7FFFFFFE
	orl	%eax, %ebx
	leaq	397(%rcx), %rax
	shrq	$4, %rax
	mulq	%r8
	shrq	%rdx
	imulq	$624, %rdx, %rax        ## imm = 0x270
	negq	%rax
	addq	%rcx, %rax
	addq	$397, %rax              ## imm = 0x18D
	shrl	%ebx
	andl	$1, %edi
	imull	$-1727483681, %edi, %edx ## imm = 0x9908B0DF
	xorl	(%rsi,%rax,4), %edx
	xorl	%ebx, %edx
	movl	%edx, (%rsi,%rcx,4)
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%edx, %eax
	movq	%r9, 2496(%rsi)
	movl	%eax, %ecx
	shll	$7, %ecx
	andl	$-1658038656, %ecx      ## imm = 0x9D2C5680
	xorl	%eax, %ecx
	movl	%ecx, %edx
	shll	$15, %edx
	andl	$-272236544, %edx       ## imm = 0xEFC60000
	xorl	%ecx, %edx
	movl	%edx, %eax
	shrl	$18, %eax
	xorl	%edx, %eax
LBB5_6:
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.private_extern	___clang_call_terminate ## -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_def_can_be_hidden	___clang_call_terminate
	.p2align	4, 0x90
___clang_call_terminate:                ## @__clang_call_terminate
## %bb.0:
	pushq	%rax
	callq	___cxa_begin_catch
	callq	__ZSt9terminatev
                                        ## -- End function
	.globl	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m ## -- Begin function _ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak_def_can_be_hidden	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	4, 0x90
__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: ## @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
Ltmp152:
	leaq	-80(%rbp), %rdi
	movq	%rbx, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp153:
## %bb.1:
	cmpb	$0, -80(%rbp)
	je	LBB7_10
## %bb.2:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %r12
	movq	40(%rbx,%rax), %rdi
	movl	8(%rbx,%rax), %r13d
	movl	144(%rbx,%rax), %eax
	cmpl	$-1, %eax
	jne	LBB7_7
## %bb.3:
Ltmp155:
	movq	%rdi, -64(%rbp)         ## 8-byte Spill
	leaq	-56(%rbp), %rdi
	movq	%r12, %rsi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp156:
## %bb.4:
Ltmp157:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	leaq	-56(%rbp), %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp158:
## %bb.5:
	movq	(%rax), %rcx
Ltmp159:
	movq	%rax, %rdi
	movl	$32, %esi
	callq	*56(%rcx)
	movb	%al, -41(%rbp)          ## 1-byte Spill
Ltmp160:
## %bb.6:
	leaq	-56(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	-41(%rbp), %eax         ## 1-byte Folded Reload
	movl	%eax, 144(%r12)
	movq	-64(%rbp), %rdi         ## 8-byte Reload
LBB7_7:
	addq	%r15, %r14
	andl	$176, %r13d
	cmpl	$32, %r13d
	movq	%r15, %rdx
	cmoveq	%r14, %rdx
Ltmp162:
	movsbl	%al, %r9d
	movq	%r15, %rsi
	movq	%r14, %rcx
	movq	%r12, %r8
	callq	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp163:
## %bb.8:
	testq	%rax, %rax
	jne	LBB7_10
## %bb.9:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %rdi
	movl	32(%rbx,%rax), %esi
	orl	$5, %esi
Ltmp165:
	callq	__ZNSt3__18ios_base5clearEj
Ltmp166:
LBB7_10:
	leaq	-80(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB7_11:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB7_12:
Ltmp167:
	jmp	LBB7_15
LBB7_13:
Ltmp161:
	movq	%rax, %r14
	leaq	-56(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	jmp	LBB7_16
LBB7_14:
Ltmp164:
LBB7_15:
	movq	%rax, %r14
LBB7_16:
	leaq	-80(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
	jmp	LBB7_18
LBB7_17:
Ltmp154:
	movq	%rax, %r14
LBB7_18:
	movq	%r14, %rdi
	callq	___cxa_begin_catch
	movq	(%rbx), %rax
	movq	-24(%rax), %rdi
	addq	%rbx, %rdi
Ltmp168:
	callq	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp169:
## %bb.19:
	callq	___cxa_end_catch
	jmp	LBB7_11
LBB7_20:
Ltmp170:
	movq	%rax, %rbx
Ltmp171:
	callq	___cxa_end_catch
Ltmp172:
## %bb.21:
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
LBB7_22:
Ltmp173:
	movq	%rax, %rdi
	callq	___clang_call_terminate
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table7:
Lexception1:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase0-Lttbaseref0
Lttbaseref0:
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Ltmp152-Lfunc_begin1   ## >> Call Site 1 <<
	.uleb128 Ltmp153-Ltmp152        ##   Call between Ltmp152 and Ltmp153
	.uleb128 Ltmp154-Lfunc_begin1   ##     jumps to Ltmp154
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp155-Lfunc_begin1   ## >> Call Site 2 <<
	.uleb128 Ltmp156-Ltmp155        ##   Call between Ltmp155 and Ltmp156
	.uleb128 Ltmp164-Lfunc_begin1   ##     jumps to Ltmp164
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp157-Lfunc_begin1   ## >> Call Site 3 <<
	.uleb128 Ltmp160-Ltmp157        ##   Call between Ltmp157 and Ltmp160
	.uleb128 Ltmp161-Lfunc_begin1   ##     jumps to Ltmp161
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp162-Lfunc_begin1   ## >> Call Site 4 <<
	.uleb128 Ltmp163-Ltmp162        ##   Call between Ltmp162 and Ltmp163
	.uleb128 Ltmp164-Lfunc_begin1   ##     jumps to Ltmp164
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp165-Lfunc_begin1   ## >> Call Site 5 <<
	.uleb128 Ltmp166-Ltmp165        ##   Call between Ltmp165 and Ltmp166
	.uleb128 Ltmp167-Lfunc_begin1   ##     jumps to Ltmp167
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp166-Lfunc_begin1   ## >> Call Site 6 <<
	.uleb128 Ltmp168-Ltmp166        ##   Call between Ltmp166 and Ltmp168
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp168-Lfunc_begin1   ## >> Call Site 7 <<
	.uleb128 Ltmp169-Ltmp168        ##   Call between Ltmp168 and Ltmp169
	.uleb128 Ltmp170-Lfunc_begin1   ##     jumps to Ltmp170
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp169-Lfunc_begin1   ## >> Call Site 8 <<
	.uleb128 Ltmp171-Ltmp169        ##   Call between Ltmp169 and Ltmp171
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp171-Lfunc_begin1   ## >> Call Site 9 <<
	.uleb128 Ltmp172-Ltmp171        ##   Call between Ltmp171 and Ltmp172
	.uleb128 Ltmp173-Lfunc_begin1   ##     jumps to Ltmp173
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp172-Lfunc_begin1   ## >> Call Site 10 <<
	.uleb128 Lfunc_end1-Ltmp172     ##   Call between Ltmp172 and Lfunc_end1
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end1:
	.byte	1                       ## >> Action Record 1 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
	.p2align	2
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
Lttbase0:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ ## -- Begin function _ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_def_can_be_hidden	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	4, 0x90
__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ## @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	testq	%rdi, %rdi
	je	LBB8_20
## %bb.1:
	movq	%r8, %r12
	movq	%rcx, %r15
	movq	%rdi, %r14
	movl	%r9d, -68(%rbp)         ## 4-byte Spill
	movq	%rcx, %rax
	subq	%rsi, %rax
	movq	24(%r8), %rcx
	xorl	%r13d, %r13d
	subq	%rax, %rcx
	cmovgq	%rcx, %r13
	movq	%rdx, -88(%rbp)         ## 8-byte Spill
	movq	%rdx, %rbx
	subq	%rsi, %rbx
	testq	%rbx, %rbx
	jle	LBB8_3
## %bb.2:
	movq	(%r14), %rax
	movq	%r14, %rdi
	movq	%rbx, %rdx
	callq	*96(%rax)
	cmpq	%rbx, %rax
	jne	LBB8_20
LBB8_3:
	testq	%r13, %r13
	jle	LBB8_16
## %bb.4:
	movq	%r12, -80(%rbp)         ## 8-byte Spill
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -64(%rbp)
	movq	$0, -48(%rbp)
	cmpq	$23, %r13
	jae	LBB8_8
## %bb.5:
	leal	(%r13,%r13), %eax
	movb	%al, -64(%rbp)
	leaq	-64(%rbp), %rbx
	leaq	-63(%rbp), %r12
	jmp	LBB8_9
LBB8_8:
	leaq	16(%r13), %rbx
	andq	$-16, %rbx
	movq	%rbx, %rdi
	callq	__Znwm
	movq	%rax, %r12
	movq	%rax, -48(%rbp)
	orq	$1, %rbx
	movq	%rbx, -64(%rbp)
	movq	%r13, -56(%rbp)
	leaq	-64(%rbp), %rbx
LBB8_9:
	movzbl	-68(%rbp), %esi         ## 1-byte Folded Reload
	movq	%r12, %rdi
	movq	%r13, %rdx
	callq	_memset
	movb	$0, (%r12,%r13)
	testb	$1, -64(%rbp)
	je	LBB8_11
## %bb.10:
	movq	-48(%rbp), %rbx
	jmp	LBB8_12
LBB8_11:
	addq	$1, %rbx
LBB8_12:
	movq	-80(%rbp), %r12         ## 8-byte Reload
	movq	(%r14), %rax
Ltmp174:
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*96(%rax)
Ltmp175:
## %bb.13:
	movq	%rax, %rbx
	testb	$1, -64(%rbp)
	je	LBB8_15
## %bb.14:
	movq	-48(%rbp), %rdi
	callq	__ZdlPv
LBB8_15:
	cmpq	%r13, %rbx
	jne	LBB8_20
LBB8_16:
	movq	-88(%rbp), %rsi         ## 8-byte Reload
	subq	%rsi, %r15
	testq	%r15, %r15
	jle	LBB8_18
## %bb.17:
	movq	(%r14), %rax
	movq	%r14, %rdi
	movq	%r15, %rdx
	callq	*96(%rax)
	cmpq	%r15, %rax
	jne	LBB8_20
LBB8_18:
	movq	$0, 24(%r12)
	jmp	LBB8_21
LBB8_20:
	xorl	%r14d, %r14d
LBB8_21:
	movq	%r14, %rax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB8_22:
Ltmp176:
	movq	%rax, %rbx
	testb	$1, -64(%rbp)
	je	LBB8_24
## %bb.23:
	movq	-48(%rbp), %rdi
	callq	__ZdlPv
LBB8_24:
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table8:
Lexception2:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	255                     ## @TType Encoding = omit
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Lfunc_begin2-Lfunc_begin2 ## >> Call Site 1 <<
	.uleb128 Ltmp174-Lfunc_begin2   ##   Call between Lfunc_begin2 and Ltmp174
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp174-Lfunc_begin2   ## >> Call Site 2 <<
	.uleb128 Ltmp175-Ltmp174        ##   Call between Ltmp174 and Ltmp175
	.uleb128 Ltmp176-Lfunc_begin2   ##     jumps to Ltmp176
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp175-Lfunc_begin2   ## >> Call Site 3 <<
	.uleb128 Lfunc_end2-Ltmp175     ##   Call between Ltmp175 and Lfunc_end2
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end2:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Using array of size "

L_.str.1:                               ## @.str.1
	.asciz	"addr of 0 % alignment "

L_.str.2:                               ## @.str.2
	.asciz	" == 0 "

L_.str.3:                               ## @.str.3
	.asciz	"addr of 0"

L_.str.4:                               ## @.str.4
	.asciz	"addr of 1"

L_.str.5:                               ## @.str.5
	.asciz	"addr of 2"

L_.str.6:                               ## @.str.6
	.asciz	"addr of 3"

L_.str.7:                               ## @.str.7
	.asciz	"position is "

L_.str.8:                               ## @.str.8
	.asciz	"-- findMinimumIndexC ---"

L_.str.9:                               ## @.str.9
	.asciz	"Time: "

L_.str.10:                              ## @.str.10
	.asciz	"ns"

L_.str.11:                              ## @.str.11
	.asciz	"Minimum index "

L_.str.12:                              ## @.str.12
	.asciz	" with value "

L_.str.13:                              ## @.str.13
	.asciz	"--  findMinimumIndexCPP  ---"

L_.str.14:                              ## @.str.14
	.asciz	"-- findMinimumIndexSSE ---"

L_.str.15:                              ## @.str.15
	.asciz	"-- findMinimumIndexSSEUnRoll ---"


.subsections_via_symbols
