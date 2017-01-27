
obj/kernel.full:     file format elf32-i386


Disassembly of section .text:

00040000 <multiboot>:
   40000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
   40006:	00 00                	add    %al,(%eax)
   40008:	fe 4f 52             	decb   0x52(%edi)
   4000b:	e4 bc                	in     $0xbc,%al

0004000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl multiboot_start
multiboot_start:
        movl $0x80000, %esp
   4000c:	bc 00 00 08 00       	mov    $0x80000,%esp
        pushl $0
   40011:	6a 00                	push   $0x0
        popfl
   40013:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   40014:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40019:	75 0d                	jne    40028 <multiboot_start+0x1c>
        testl $4, (%ebx)
   4001b:	f7 03 04 00 00 00    	testl  $0x4,(%ebx)
        je 1f
   40021:	74 05                	je     40028 <multiboot_start+0x1c>
        movl 16(%ebx), %ebx
   40023:	8b 5b 10             	mov    0x10(%ebx),%ebx
        jmp 2f
   40026:	eb 05                	jmp    4002d <multiboot_start+0x21>
1:      movl $0x0, %ebx
   40028:	bb 00 00 00 00       	mov    $0x0,%ebx
2:      pushl %ebx
   4002d:	53                   	push   %ebx
        call kernel
   4002e:	e8 c5 00 00 00       	call   400f8 <kernel>
   40033:	90                   	nop

00040034 <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushl $13               // trap number
   40034:	6a 0d                	push   $0xd
        jmp _generic_int_handler
   40036:	eb 6e                	jmp    400a6 <_generic_int_handler>

00040038 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushl $14
   40038:	6a 0e                	push   $0xe
        jmp _generic_int_handler
   4003a:	eb 6a                	jmp    400a6 <_generic_int_handler>

0004003c <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushl $0                // error code
   4003c:	6a 00                	push   $0x0
        pushl $32
   4003e:	6a 20                	push   $0x20
        jmp _generic_int_handler
   40040:	eb 64                	jmp    400a6 <_generic_int_handler>

00040042 <sys48_int_handler>:

sys48_int_handler:
        pushl $0
   40042:	6a 00                	push   $0x0
        pushl $48
   40044:	6a 30                	push   $0x30
        jmp _generic_int_handler
   40046:	eb 5e                	jmp    400a6 <_generic_int_handler>

00040048 <sys49_int_handler>:

sys49_int_handler:
        pushl $0
   40048:	6a 00                	push   $0x0
        pushl $49
   4004a:	6a 31                	push   $0x31
        jmp _generic_int_handler
   4004c:	eb 58                	jmp    400a6 <_generic_int_handler>

0004004e <sys50_int_handler>:

sys50_int_handler:
        pushl $0
   4004e:	6a 00                	push   $0x0
        pushl $50
   40050:	6a 32                	push   $0x32
        jmp _generic_int_handler
   40052:	eb 52                	jmp    400a6 <_generic_int_handler>

00040054 <sys51_int_handler>:

sys51_int_handler:
        pushl $0
   40054:	6a 00                	push   $0x0
        pushl $51
   40056:	6a 33                	push   $0x33
        jmp _generic_int_handler
   40058:	eb 4c                	jmp    400a6 <_generic_int_handler>

0004005a <sys52_int_handler>:

sys52_int_handler:
        pushl $0
   4005a:	6a 00                	push   $0x0
        pushl $52
   4005c:	6a 34                	push   $0x34
        jmp _generic_int_handler
   4005e:	eb 46                	jmp    400a6 <_generic_int_handler>

00040060 <sys53_int_handler>:

sys53_int_handler:
        pushl $0
   40060:	6a 00                	push   $0x0
        pushl $53
   40062:	6a 35                	push   $0x35
        jmp _generic_int_handler
   40064:	eb 40                	jmp    400a6 <_generic_int_handler>

00040066 <sys54_int_handler>:

sys54_int_handler:
        pushl $0
   40066:	6a 00                	push   $0x0
        pushl $54
   40068:	6a 36                	push   $0x36
        jmp _generic_int_handler
   4006a:	eb 3a                	jmp    400a6 <_generic_int_handler>

0004006c <sys55_int_handler>:

sys55_int_handler:
        pushl $0
   4006c:	6a 00                	push   $0x0
        pushl $55
   4006e:	6a 37                	push   $0x37
        jmp _generic_int_handler
   40070:	eb 34                	jmp    400a6 <_generic_int_handler>

00040072 <sys56_int_handler>:

sys56_int_handler:
        pushl $0
   40072:	6a 00                	push   $0x0
        pushl $56
   40074:	6a 38                	push   $0x38
        jmp _generic_int_handler
   40076:	eb 2e                	jmp    400a6 <_generic_int_handler>

00040078 <sys57_int_handler>:

sys57_int_handler:
        pushl $0
   40078:	6a 00                	push   $0x0
        pushl $57
   4007a:	6a 39                	push   $0x39
        jmp _generic_int_handler
   4007c:	eb 28                	jmp    400a6 <_generic_int_handler>

0004007e <sys58_int_handler>:

sys58_int_handler:
        pushl $0
   4007e:	6a 00                	push   $0x0
        pushl $58
   40080:	6a 3a                	push   $0x3a
        jmp _generic_int_handler
   40082:	eb 22                	jmp    400a6 <_generic_int_handler>

00040084 <sys59_int_handler>:

sys59_int_handler:
        pushl $0
   40084:	6a 00                	push   $0x0
        pushl $59
   40086:	6a 3b                	push   $0x3b
        jmp _generic_int_handler
   40088:	eb 1c                	jmp    400a6 <_generic_int_handler>

0004008a <sys60_int_handler>:

sys60_int_handler:
        pushl $0
   4008a:	6a 00                	push   $0x0
        pushl $60
   4008c:	6a 3c                	push   $0x3c
        jmp _generic_int_handler
   4008e:	eb 16                	jmp    400a6 <_generic_int_handler>

00040090 <sys61_int_handler>:

sys61_int_handler:
        pushl $0
   40090:	6a 00                	push   $0x0
        pushl $61
   40092:	6a 3d                	push   $0x3d
        jmp _generic_int_handler
   40094:	eb 10                	jmp    400a6 <_generic_int_handler>

00040096 <sys62_int_handler>:

sys62_int_handler:
        pushl $0
   40096:	6a 00                	push   $0x0
        pushl $62
   40098:	6a 3e                	push   $0x3e
        jmp _generic_int_handler
   4009a:	eb 0a                	jmp    400a6 <_generic_int_handler>

0004009c <sys63_int_handler>:

sys63_int_handler:
        pushl $0
   4009c:	6a 00                	push   $0x0
        pushl $63
   4009e:	6a 3f                	push   $0x3f
        jmp _generic_int_handler
   400a0:	eb 04                	jmp    400a6 <_generic_int_handler>

000400a2 <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushl $0
   400a2:	6a 00                	push   $0x0
        jmp _generic_int_handler
   400a4:	eb 00                	jmp    400a6 <_generic_int_handler>

000400a6 <_generic_int_handler>:
        # When we get here, the processor's exception mechanism has
        # pushed the old task status and stack registers onto the kernel stack.
        # Then one of the specific handlers pushed the exception number.
        # Now, we complete the `struct x86_registers` by pushing the extra
        # segment definitions and the general CPU registers.
        pushl %ds
   400a6:	1e                   	push   %ds
        pushl %es
   400a7:	06                   	push   %es
        pushal
   400a8:	60                   	pusha  

        # Load the data segments with the kernel's values.
        movl $0x10, %eax                # SEE ALSO k-hardware.c
   400a9:	b8 10 00 00 00       	mov    $0x10,%eax
        movw %ax, %ds
   400ae:	8e d8                	mov    %eax,%ds
        movw %ax, %es
   400b0:	8e c0                	mov    %eax,%es

        # Call the kernel's `exception` function.
        pushl %esp                      # 1st argument points at `registers`
   400b2:	54                   	push   %esp
        call exception
   400b3:	e8 0f 01 00 00       	call   401c7 <exception>

000400b8 <sys_int_handlers>:
   400b8:	42                   	inc    %edx
   400b9:	00 04 00             	add    %al,(%eax,%eax,1)
   400bc:	48                   	dec    %eax
   400bd:	00 04 00             	add    %al,(%eax,%eax,1)
   400c0:	4e                   	dec    %esi
   400c1:	00 04 00             	add    %al,(%eax,%eax,1)
   400c4:	54                   	push   %esp
   400c5:	00 04 00             	add    %al,(%eax,%eax,1)
   400c8:	5a                   	pop    %edx
   400c9:	00 04 00             	add    %al,(%eax,%eax,1)
   400cc:	60                   	pusha  
   400cd:	00 04 00             	add    %al,(%eax,%eax,1)
   400d0:	66                   	data16
   400d1:	00 04 00             	add    %al,(%eax,%eax,1)
   400d4:	6c                   	insb   (%dx),%es:(%edi)
   400d5:	00 04 00             	add    %al,(%eax,%eax,1)
   400d8:	72 00                	jb     400da <sys_int_handlers+0x22>
   400da:	04 00                	add    $0x0,%al
   400dc:	78 00                	js     400de <sys_int_handlers+0x26>
   400de:	04 00                	add    $0x0,%al
   400e0:	7e 00                	jle    400e2 <sys_int_handlers+0x2a>
   400e2:	04 00                	add    $0x0,%al
   400e4:	84 00                	test   %al,(%eax)
   400e6:	04 00                	add    $0x0,%al
   400e8:	8a 00                	mov    (%eax),%al
   400ea:	04 00                	add    $0x0,%al
   400ec:	90                   	nop
   400ed:	00 04 00             	add    %al,(%eax,%eax,1)
   400f0:	96                   	xchg   %eax,%esi
   400f1:	00 04 00             	add    %al,(%eax,%eax,1)
   400f4:	9c                   	pushf  
   400f5:	00 04 00             	add    %al,(%eax,%eax,1)

000400f8 <kernel>:


// kernel
//    Initialize the hardware and processes and start running.

void kernel(void) {
   400f8:	55                   	push   %ebp
   400f9:	89 e5                	mov    %esp,%ebp
   400fb:	83 ec 28             	sub    $0x28,%esp
    hardware_init();
   400fe:	e8 68 02 00 00       	call   4036b <hardware_init>
    console_clear();
   40103:	e8 d4 1a 00 00       	call   41bdc <console_clear>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40108:	c7 44 24 08 c0 04 00 	movl   $0x4c0,0x8(%esp)
   4010f:	00 
   40110:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   40117:	00 
   40118:	c7 04 24 00 60 04 00 	movl   $0x46000,(%esp)
   4011f:	e8 3c 14 00 00       	call   41560 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   40124:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   4012b:	eb 27                	jmp    40154 <kernel+0x5c>
        processes[i].p_pid = i;
   4012d:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40130:	6b c0 4c             	imul   $0x4c,%eax,%eax
   40133:	8d 90 00 60 04 00    	lea    0x46000(%eax),%edx
   40139:	8b 45 f4             	mov    -0xc(%ebp),%eax
   4013c:	89 02                	mov    %eax,(%edx)
        processes[i].p_state = P_FREE;
   4013e:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40141:	6b c0 4c             	imul   $0x4c,%eax,%eax
   40144:	05 40 60 04 00       	add    $0x46040,%eax
   40149:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    hardware_init();
    console_clear();

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
    for (pid_t i = 0; i < NPROC; i++) {
   40150:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
   40154:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
   40158:	7e d3                	jle    4012d <kernel+0x35>
        processes[i].p_state = P_FREE;
    }

    // Load the process application code and data into memory,
    // set up its %eip and %esp, and mark it runnable.
    process_init(&processes[1], PROCINIT_ALLOW_PROGRAMMED_IO);
   4015a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
   40161:	00 
   40162:	c7 04 24 4c 60 04 00 	movl   $0x4604c,(%esp)
   40169:	e8 60 0c 00 00       	call   40dce <process_init>
    int r = program_load(&processes[1], 0);
   4016e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   40175:	00 
   40176:	c7 04 24 4c 60 04 00 	movl   $0x4604c,(%esp)
   4017d:	e8 c0 11 00 00       	call   41342 <program_load>
   40182:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(r >= 0);
   40185:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
   40189:	79 1c                	jns    401a7 <kernel+0xaf>
   4018b:	c7 44 24 08 20 1c 04 	movl   $0x41c20,0x8(%esp)
   40192:	00 
   40193:	c7 44 24 04 32 00 00 	movl   $0x32,0x4(%esp)
   4019a:	00 
   4019b:	c7 04 24 27 1c 04 00 	movl   $0x41c27,(%esp)
   401a2:	e8 74 11 00 00       	call   4131b <assert_fail>
    processes[1].p_registers.reg_esp = PROC_START_ADDR + PROC_SIZE;
   401a7:	c7 05 8c 60 04 00 00 	movl   $0x140000,0x4608c
   401ae:	00 14 00 
    processes[1].p_state = P_RUNNABLE;
   401b1:	c7 05 94 60 04 00 01 	movl   $0x1,0x46094
   401b8:	00 00 00 

    // Switch to the first process using run()
    run(&processes[1]);
   401bb:	c7 04 24 4c 60 04 00 	movl   $0x4604c,(%esp)
   401c2:	e8 5e 01 00 00       	call   40325 <run>

000401c7 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_registers* reg) {
   401c7:	55                   	push   %ebp
   401c8:	89 e5                	mov    %esp,%ebp
   401ca:	57                   	push   %edi
   401cb:	56                   	push   %esi
   401cc:	53                   	push   %ebx
   401cd:	83 ec 2c             	sub    $0x2c,%esp
    // Copy the saved registers into the `current` process descriptor.
    current->p_registers = *reg;
   401d0:	8b 15 08 a0 04 00    	mov    0x4a008,%edx
   401d6:	8b 45 08             	mov    0x8(%ebp),%eax
   401d9:	8d 5a 04             	lea    0x4(%edx),%ebx
   401dc:	89 c2                	mov    %eax,%edx
   401de:	b8 11 00 00 00       	mov    $0x11,%eax
   401e3:	89 df                	mov    %ebx,%edi
   401e5:	89 d6                	mov    %edx,%esi
   401e7:	89 c1                	mov    %eax,%ecx
   401e9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

    // Show the current cursor location.
    console_show_cursor(cursorpos);
   401eb:	a1 fc 8f 0b 00       	mov    0xb8ffc,%eax
   401f0:	89 04 24             	mov    %eax,(%esp)
   401f3:	e8 60 0c 00 00       	call   40e58 <console_show_cursor>

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   401f8:	e8 2c 10 00 00       	call   41229 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   401fd:	8b 45 08             	mov    0x8(%ebp),%eax
   40200:	8b 40 28             	mov    0x28(%eax),%eax
   40203:	83 f8 31             	cmp    $0x31,%eax
   40206:	74 2a                	je     40232 <exception+0x6b>
   40208:	83 f8 32             	cmp    $0x32,%eax
   4020b:	0f 84 88 00 00 00    	je     40299 <exception+0xd2>
   40211:	83 f8 30             	cmp    $0x30,%eax
   40214:	0f 85 84 00 00 00    	jne    4029e <exception+0xd7>

    case INT_SYS_PANIC:
        panic("%s", (char*) current->p_registers.reg_eax);
   4021a:	a1 08 a0 04 00       	mov    0x4a008,%eax
   4021f:	8b 40 20             	mov    0x20(%eax),%eax
   40222:	89 44 24 04          	mov    %eax,0x4(%esp)
   40226:	c7 04 24 30 1c 04 00 	movl   $0x41c30,(%esp)
   4022d:	e8 25 10 00 00       	call   41257 <panic>
        break;                  // will not be reached

    case INT_SYS_WRITE:
        cursorpos = console_printf(cursorpos, 0x0700, "%.*s",
                                   (int) current->p_registers.reg_ecx,
                                   (char*) current->p_registers.reg_eax);
   40232:	a1 08 a0 04 00       	mov    0x4a008,%eax
   40237:	8b 40 20             	mov    0x20(%eax),%eax
    case INT_SYS_PANIC:
        panic("%s", (char*) current->p_registers.reg_eax);
        break;                  // will not be reached

    case INT_SYS_WRITE:
        cursorpos = console_printf(cursorpos, 0x0700, "%.*s",
   4023a:	89 c1                	mov    %eax,%ecx
                                   (int) current->p_registers.reg_ecx,
   4023c:	a1 08 a0 04 00       	mov    0x4a008,%eax
   40241:	8b 40 1c             	mov    0x1c(%eax),%eax
    case INT_SYS_PANIC:
        panic("%s", (char*) current->p_registers.reg_eax);
        break;                  // will not be reached

    case INT_SYS_WRITE:
        cursorpos = console_printf(cursorpos, 0x0700, "%.*s",
   40244:	89 c2                	mov    %eax,%edx
   40246:	a1 fc 8f 0b 00       	mov    0xb8ffc,%eax
   4024b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
   4024f:	89 54 24 0c          	mov    %edx,0xc(%esp)
   40253:	c7 44 24 08 33 1c 04 	movl   $0x41c33,0x8(%esp)
   4025a:	00 
   4025b:	c7 44 24 04 00 07 00 	movl   $0x700,0x4(%esp)
   40262:	00 
   40263:	89 04 24             	mov    %eax,(%esp)
   40266:	e8 49 19 00 00       	call   41bb4 <console_printf>
   4026b:	a3 fc 8f 0b 00       	mov    %eax,0xb8ffc
                                   (int) current->p_registers.reg_ecx,
                                   (char*) current->p_registers.reg_eax);
        console_show_cursor(cursorpos);
   40270:	a1 fc 8f 0b 00       	mov    0xb8ffc,%eax
   40275:	89 04 24             	mov    %eax,(%esp)
   40278:	e8 db 0b 00 00       	call   40e58 <console_show_cursor>
        current->p_registers.reg_eax = 0; // return 0 to process
   4027d:	a1 08 a0 04 00       	mov    0x4a008,%eax
   40282:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
        break;
   40289:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE)
   4028a:	a1 08 a0 04 00       	mov    0x4a008,%eax
   4028f:	8b 40 48             	mov    0x48(%eax),%eax
   40292:	83 f8 01             	cmp    $0x1,%eax
   40295:	75 2a                	jne    402c1 <exception+0xfa>
   40297:	eb 1b                	jmp    402b4 <exception+0xed>
        console_show_cursor(cursorpos);
        current->p_registers.reg_eax = 0; // return 0 to process
        break;

    case INT_SYS_YIELD:
        schedule();             // does not return
   40299:	e8 30 00 00 00       	call   402ce <schedule>

    default:
        panic("Unexpected interrupt %d!\n", reg->reg_intno);
   4029e:	8b 45 08             	mov    0x8(%ebp),%eax
   402a1:	8b 40 28             	mov    0x28(%eax),%eax
   402a4:	89 44 24 04          	mov    %eax,0x4(%esp)
   402a8:	c7 04 24 38 1c 04 00 	movl   $0x41c38,(%esp)
   402af:	e8 a3 0f 00 00       	call   41257 <panic>
    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE)
        run(current);
   402b4:	a1 08 a0 04 00       	mov    0x4a008,%eax
   402b9:	89 04 24             	mov    %eax,(%esp)
   402bc:	e8 64 00 00 00       	call   40325 <run>
    else
        schedule();
   402c1:	e8 08 00 00 00       	call   402ce <schedule>
}
   402c6:	83 c4 2c             	add    $0x2c,%esp
   402c9:	5b                   	pop    %ebx
   402ca:	5e                   	pop    %esi
   402cb:	5f                   	pop    %edi
   402cc:	5d                   	pop    %ebp
   402cd:	c3                   	ret    

000402ce <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   402ce:	55                   	push   %ebp
   402cf:	89 e5                	mov    %esp,%ebp
   402d1:	83 ec 28             	sub    $0x28,%esp
    pid_t pid = current->p_pid;
   402d4:	a1 08 a0 04 00       	mov    0x4a008,%eax
   402d9:	8b 00                	mov    (%eax),%eax
   402db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (1) {
        pid = (pid + 1) % NPROC;
   402de:	8b 45 f4             	mov    -0xc(%ebp),%eax
   402e1:	8d 50 01             	lea    0x1(%eax),%edx
   402e4:	89 d0                	mov    %edx,%eax
   402e6:	c1 f8 1f             	sar    $0x1f,%eax
   402e9:	c1 e8 1c             	shr    $0x1c,%eax
   402ec:	01 c2                	add    %eax,%edx
   402ee:	83 e2 0f             	and    $0xf,%edx
   402f1:	29 c2                	sub    %eax,%edx
   402f3:	89 d0                	mov    %edx,%eax
   402f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (processes[pid].p_state == P_RUNNABLE)
   402f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
   402fb:	6b c0 4c             	imul   $0x4c,%eax,%eax
   402fe:	05 40 60 04 00       	add    $0x46040,%eax
   40303:	8b 40 08             	mov    0x8(%eax),%eax
   40306:	83 f8 01             	cmp    $0x1,%eax
   40309:	75 13                	jne    4031e <schedule+0x50>
            run(&processes[pid]);
   4030b:	8b 45 f4             	mov    -0xc(%ebp),%eax
   4030e:	6b c0 4c             	imul   $0x4c,%eax,%eax
   40311:	05 00 60 04 00       	add    $0x46000,%eax
   40316:	89 04 24             	mov    %eax,(%esp)
   40319:	e8 07 00 00 00       	call   40325 <run>
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4031e:	e8 06 0f 00 00       	call   41229 <check_keyboard>
    }
   40323:	eb b9                	jmp    402de <schedule+0x10>

00040325 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40325:	55                   	push   %ebp
   40326:	89 e5                	mov    %esp,%ebp
   40328:	83 ec 18             	sub    $0x18,%esp
    assert(p->p_state == P_RUNNABLE);
   4032b:	8b 45 08             	mov    0x8(%ebp),%eax
   4032e:	8b 40 48             	mov    0x48(%eax),%eax
   40331:	83 f8 01             	cmp    $0x1,%eax
   40334:	74 1c                	je     40352 <run+0x2d>
   40336:	c7 44 24 08 52 1c 04 	movl   $0x41c52,0x8(%esp)
   4033d:	00 
   4033e:	c7 44 24 04 89 00 00 	movl   $0x89,0x4(%esp)
   40345:	00 
   40346:	c7 04 24 27 1c 04 00 	movl   $0x41c27,(%esp)
   4034d:	e8 c9 0f 00 00       	call   4131b <assert_fail>
    current = p;
   40352:	8b 45 08             	mov    0x8(%ebp),%eax
   40355:	a3 08 a0 04 00       	mov    %eax,0x4a008
                 "popl %%es\n\t"
                 "popl %%ds\n\t"
                 "addl $8, %%esp\n\t"
                 "iret"
                 :
                 : "g" (&p->p_registers)
   4035a:	8b 45 08             	mov    0x8(%ebp),%eax
   4035d:	83 c0 04             	add    $0x4,%eax

void run(proc* p) {
    assert(p->p_state == P_RUNNABLE);
    current = p;

    asm volatile("movl %0,%%esp\n\t"
   40360:	89 c4                	mov    %eax,%esp
   40362:	61                   	popa   
   40363:	07                   	pop    %es
   40364:	1f                   	pop    %ds
   40365:	83 c4 08             	add    $0x8,%esp
   40368:	cf                   	iret   
                 "iret"
                 :
                 : "g" (&p->p_registers)
                 : "memory");

 spinloop: goto spinloop;       // should never get here
   40369:	eb fe                	jmp    40369 <run+0x44>

0004036b <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
static void virtual_memory_init(void);

void hardware_init(void) {
   4036b:	55                   	push   %ebp
   4036c:	89 e5                	mov    %esp,%ebp
   4036e:	83 ec 08             	sub    $0x8,%esp
    segments_init();
   40371:	e8 0c 00 00 00       	call   40382 <segments_init>
    interrupt_init();
   40376:	e8 95 04 00 00       	call   40810 <interrupt_init>
    virtual_memory_init();
   4037b:	e8 8f 05 00 00       	call   4090f <virtual_memory_init>
}
   40380:	c9                   	leave  
   40381:	c3                   	ret    

00040382 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   40382:	55                   	push   %ebp
   40383:	89 e5                	mov    %esp,%ebp
   40385:	83 ec 28             	sub    $0x28,%esp
    // Set task state segment
    segments[SEGSEL_TASKSTATE >> 3]
        = SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
   40388:	66 c7 05 28 30 04 00 	movw   $0x68,0x43028
   4038f:	68 00 
   40391:	b8 00 70 04 00       	mov    $0x47000,%eax
   40396:	66 a3 2a 30 04 00    	mov    %ax,0x4302a
   4039c:	b8 00 70 04 00       	mov    $0x47000,%eax
   403a1:	c1 e8 10             	shr    $0x10,%eax
   403a4:	a2 2c 30 04 00       	mov    %al,0x4302c
   403a9:	0f b6 05 2d 30 04 00 	movzbl 0x4302d,%eax
   403b0:	83 e0 f0             	and    $0xfffffff0,%eax
   403b3:	83 c8 09             	or     $0x9,%eax
   403b6:	a2 2d 30 04 00       	mov    %al,0x4302d
   403bb:	0f b6 05 2d 30 04 00 	movzbl 0x4302d,%eax
   403c2:	83 c8 10             	or     $0x10,%eax
   403c5:	a2 2d 30 04 00       	mov    %al,0x4302d
   403ca:	0f b6 05 2d 30 04 00 	movzbl 0x4302d,%eax
   403d1:	83 e0 9f             	and    $0xffffff9f,%eax
   403d4:	a2 2d 30 04 00       	mov    %al,0x4302d
   403d9:	0f b6 05 2d 30 04 00 	movzbl 0x4302d,%eax
   403e0:	83 c8 80             	or     $0xffffff80,%eax
   403e3:	a2 2d 30 04 00       	mov    %al,0x4302d
   403e8:	0f b6 05 2e 30 04 00 	movzbl 0x4302e,%eax
   403ef:	83 e0 f0             	and    $0xfffffff0,%eax
   403f2:	a2 2e 30 04 00       	mov    %al,0x4302e
   403f7:	0f b6 05 2e 30 04 00 	movzbl 0x4302e,%eax
   403fe:	83 e0 ef             	and    $0xffffffef,%eax
   40401:	a2 2e 30 04 00       	mov    %al,0x4302e
   40406:	0f b6 05 2e 30 04 00 	movzbl 0x4302e,%eax
   4040d:	83 e0 df             	and    $0xffffffdf,%eax
   40410:	a2 2e 30 04 00       	mov    %al,0x4302e
   40415:	0f b6 05 2e 30 04 00 	movzbl 0x4302e,%eax
   4041c:	83 c8 40             	or     $0x40,%eax
   4041f:	a2 2e 30 04 00       	mov    %al,0x4302e
   40424:	0f b6 05 2e 30 04 00 	movzbl 0x4302e,%eax
   4042b:	83 e0 7f             	and    $0x7f,%eax
   4042e:	a2 2e 30 04 00       	mov    %al,0x4302e
   40433:	b8 00 70 04 00       	mov    $0x47000,%eax
   40438:	c1 e8 18             	shr    $0x18,%eax
   4043b:	a2 2f 30 04 00       	mov    %al,0x4302f
                sizeof(x86_taskstate), 0);
    segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
   40440:	0f b6 05 2d 30 04 00 	movzbl 0x4302d,%eax
   40447:	83 e0 ef             	and    $0xffffffef,%eax
   4044a:	a2 2d 30 04 00       	mov    %al,0x4302d

    // Set up kernel task descriptor, so we can receive interrupts
    kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
   4044f:	c7 05 04 70 04 00 00 	movl   $0x80000,0x47004
   40456:	00 08 00 
    kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
   40459:	66 c7 05 08 70 04 00 	movw   $0x10,0x47008
   40460:	10 00 

    // Set up interrupt descriptor table.
    // Most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   40462:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
   40469:	00 
   4046a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   40471:	00 
   40472:	c7 04 24 80 70 04 00 	movl   $0x47080,(%esp)
   40479:	e8 e2 10 00 00       	call   41560 <memset>
    for (int i = 16;
   4047e:	c7 45 f4 10 00 00 00 	movl   $0x10,-0xc(%ebp)
   40485:	e9 b9 00 00 00       	jmp    40543 <segments_init+0x1c1>
         i < sizeof(interrupt_descriptors) / sizeof(x86_gatedescriptor);
         ++i)
        SETGATE(interrupt_descriptors[i], 0,
   4048a:	b8 a2 00 04 00       	mov    $0x400a2,%eax
   4048f:	89 c2                	mov    %eax,%edx
   40491:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40494:	66 89 14 c5 80 70 04 	mov    %dx,0x47080(,%eax,8)
   4049b:	00 
   4049c:	8b 45 f4             	mov    -0xc(%ebp),%eax
   4049f:	66 c7 04 c5 82 70 04 	movw   $0x8,0x47082(,%eax,8)
   404a6:	00 08 00 
   404a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
   404ac:	0f b6 14 c5 84 70 04 	movzbl 0x47084(,%eax,8),%edx
   404b3:	00 
   404b4:	83 e2 e0             	and    $0xffffffe0,%edx
   404b7:	88 14 c5 84 70 04 00 	mov    %dl,0x47084(,%eax,8)
   404be:	8b 45 f4             	mov    -0xc(%ebp),%eax
   404c1:	0f b6 14 c5 84 70 04 	movzbl 0x47084(,%eax,8),%edx
   404c8:	00 
   404c9:	83 e2 1f             	and    $0x1f,%edx
   404cc:	88 14 c5 84 70 04 00 	mov    %dl,0x47084(,%eax,8)
   404d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
   404d6:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   404dd:	00 
   404de:	83 e2 f0             	and    $0xfffffff0,%edx
   404e1:	83 ca 0e             	or     $0xe,%edx
   404e4:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   404eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
   404ee:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   404f5:	00 
   404f6:	83 e2 ef             	and    $0xffffffef,%edx
   404f9:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   40500:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40503:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   4050a:	00 
   4050b:	83 e2 9f             	and    $0xffffff9f,%edx
   4050e:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   40515:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40518:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   4051f:	00 
   40520:	83 ca 80             	or     $0xffffff80,%edx
   40523:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   4052a:	b8 a2 00 04 00       	mov    $0x400a2,%eax
   4052f:	c1 e8 10             	shr    $0x10,%eax
   40532:	89 c2                	mov    %eax,%edx
   40534:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40537:	66 89 14 c5 86 70 04 	mov    %dx,0x47086(,%eax,8)
   4053e:	00 
    // Set up interrupt descriptor table.
    // Most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
    for (int i = 16;
         i < sizeof(interrupt_descriptors) / sizeof(x86_gatedescriptor);
         ++i)
   4053f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

    // Set up interrupt descriptor table.
    // Most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
    for (int i = 16;
         i < sizeof(interrupt_descriptors) / sizeof(x86_gatedescriptor);
   40543:	8b 45 f4             	mov    -0xc(%ebp),%eax
    kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

    // Set up interrupt descriptor table.
    // Most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
    for (int i = 16;
   40546:	3d ff 00 00 00       	cmp    $0xff,%eax
   4054b:	0f 86 39 ff ff ff    	jbe    4048a <segments_init+0x108>
         ++i)
        SETGATE(interrupt_descriptors[i], 0,
                SEGSEL_KERN_CODE, default_int_handler, 0);

    // Timer interrupt
    SETGATE(interrupt_descriptors[INT_TIMER], 0,
   40551:	b8 3c 00 04 00       	mov    $0x4003c,%eax
   40556:	66 a3 80 71 04 00    	mov    %ax,0x47180
   4055c:	66 c7 05 82 71 04 00 	movw   $0x8,0x47182
   40563:	08 00 
   40565:	0f b6 05 84 71 04 00 	movzbl 0x47184,%eax
   4056c:	83 e0 e0             	and    $0xffffffe0,%eax
   4056f:	a2 84 71 04 00       	mov    %al,0x47184
   40574:	0f b6 05 84 71 04 00 	movzbl 0x47184,%eax
   4057b:	83 e0 1f             	and    $0x1f,%eax
   4057e:	a2 84 71 04 00       	mov    %al,0x47184
   40583:	0f b6 05 85 71 04 00 	movzbl 0x47185,%eax
   4058a:	83 e0 f0             	and    $0xfffffff0,%eax
   4058d:	83 c8 0e             	or     $0xe,%eax
   40590:	a2 85 71 04 00       	mov    %al,0x47185
   40595:	0f b6 05 85 71 04 00 	movzbl 0x47185,%eax
   4059c:	83 e0 ef             	and    $0xffffffef,%eax
   4059f:	a2 85 71 04 00       	mov    %al,0x47185
   405a4:	0f b6 05 85 71 04 00 	movzbl 0x47185,%eax
   405ab:	83 e0 9f             	and    $0xffffff9f,%eax
   405ae:	a2 85 71 04 00       	mov    %al,0x47185
   405b3:	0f b6 05 85 71 04 00 	movzbl 0x47185,%eax
   405ba:	83 c8 80             	or     $0xffffff80,%eax
   405bd:	a2 85 71 04 00       	mov    %al,0x47185
   405c2:	b8 3c 00 04 00       	mov    $0x4003c,%eax
   405c7:	c1 e8 10             	shr    $0x10,%eax
   405ca:	66 a3 86 71 04 00    	mov    %ax,0x47186
            SEGSEL_KERN_CODE, timer_int_handler, 0);

    // GPF and page fault
    SETGATE(interrupt_descriptors[INT_GPF], 0,
   405d0:	b8 34 00 04 00       	mov    $0x40034,%eax
   405d5:	66 a3 e8 70 04 00    	mov    %ax,0x470e8
   405db:	66 c7 05 ea 70 04 00 	movw   $0x8,0x470ea
   405e2:	08 00 
   405e4:	0f b6 05 ec 70 04 00 	movzbl 0x470ec,%eax
   405eb:	83 e0 e0             	and    $0xffffffe0,%eax
   405ee:	a2 ec 70 04 00       	mov    %al,0x470ec
   405f3:	0f b6 05 ec 70 04 00 	movzbl 0x470ec,%eax
   405fa:	83 e0 1f             	and    $0x1f,%eax
   405fd:	a2 ec 70 04 00       	mov    %al,0x470ec
   40602:	0f b6 05 ed 70 04 00 	movzbl 0x470ed,%eax
   40609:	83 e0 f0             	and    $0xfffffff0,%eax
   4060c:	83 c8 0e             	or     $0xe,%eax
   4060f:	a2 ed 70 04 00       	mov    %al,0x470ed
   40614:	0f b6 05 ed 70 04 00 	movzbl 0x470ed,%eax
   4061b:	83 e0 ef             	and    $0xffffffef,%eax
   4061e:	a2 ed 70 04 00       	mov    %al,0x470ed
   40623:	0f b6 05 ed 70 04 00 	movzbl 0x470ed,%eax
   4062a:	83 e0 9f             	and    $0xffffff9f,%eax
   4062d:	a2 ed 70 04 00       	mov    %al,0x470ed
   40632:	0f b6 05 ed 70 04 00 	movzbl 0x470ed,%eax
   40639:	83 c8 80             	or     $0xffffff80,%eax
   4063c:	a2 ed 70 04 00       	mov    %al,0x470ed
   40641:	b8 34 00 04 00       	mov    $0x40034,%eax
   40646:	c1 e8 10             	shr    $0x10,%eax
   40649:	66 a3 ee 70 04 00    	mov    %ax,0x470ee
            SEGSEL_KERN_CODE, gpf_int_handler, 0);
    SETGATE(interrupt_descriptors[INT_PAGEFAULT], 0,
   4064f:	b8 38 00 04 00       	mov    $0x40038,%eax
   40654:	66 a3 f0 70 04 00    	mov    %ax,0x470f0
   4065a:	66 c7 05 f2 70 04 00 	movw   $0x8,0x470f2
   40661:	08 00 
   40663:	0f b6 05 f4 70 04 00 	movzbl 0x470f4,%eax
   4066a:	83 e0 e0             	and    $0xffffffe0,%eax
   4066d:	a2 f4 70 04 00       	mov    %al,0x470f4
   40672:	0f b6 05 f4 70 04 00 	movzbl 0x470f4,%eax
   40679:	83 e0 1f             	and    $0x1f,%eax
   4067c:	a2 f4 70 04 00       	mov    %al,0x470f4
   40681:	0f b6 05 f5 70 04 00 	movzbl 0x470f5,%eax
   40688:	83 e0 f0             	and    $0xfffffff0,%eax
   4068b:	83 c8 0e             	or     $0xe,%eax
   4068e:	a2 f5 70 04 00       	mov    %al,0x470f5
   40693:	0f b6 05 f5 70 04 00 	movzbl 0x470f5,%eax
   4069a:	83 e0 ef             	and    $0xffffffef,%eax
   4069d:	a2 f5 70 04 00       	mov    %al,0x470f5
   406a2:	0f b6 05 f5 70 04 00 	movzbl 0x470f5,%eax
   406a9:	83 e0 9f             	and    $0xffffff9f,%eax
   406ac:	a2 f5 70 04 00       	mov    %al,0x470f5
   406b1:	0f b6 05 f5 70 04 00 	movzbl 0x470f5,%eax
   406b8:	83 c8 80             	or     $0xffffff80,%eax
   406bb:	a2 f5 70 04 00       	mov    %al,0x470f5
   406c0:	b8 38 00 04 00       	mov    $0x40038,%eax
   406c5:	c1 e8 10             	shr    $0x10,%eax
   406c8:	66 a3 f6 70 04 00    	mov    %ax,0x470f6
            SEGSEL_KERN_CODE, pagefault_int_handler, 0);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (int i = INT_SYS; i < INT_SYS + 16; ++i)
   406ce:	c7 45 f0 30 00 00 00 	movl   $0x30,-0x10(%ebp)
   406d5:	e9 c9 00 00 00       	jmp    407a3 <segments_init+0x421>
        SETGATE(interrupt_descriptors[i], 0,
   406da:	8b 45 f0             	mov    -0x10(%ebp),%eax
   406dd:	83 e8 30             	sub    $0x30,%eax
   406e0:	8b 04 85 b8 00 04 00 	mov    0x400b8(,%eax,4),%eax
   406e7:	89 c2                	mov    %eax,%edx
   406e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
   406ec:	66 89 14 c5 80 70 04 	mov    %dx,0x47080(,%eax,8)
   406f3:	00 
   406f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
   406f7:	66 c7 04 c5 82 70 04 	movw   $0x8,0x47082(,%eax,8)
   406fe:	00 08 00 
   40701:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40704:	0f b6 14 c5 84 70 04 	movzbl 0x47084(,%eax,8),%edx
   4070b:	00 
   4070c:	83 e2 e0             	and    $0xffffffe0,%edx
   4070f:	88 14 c5 84 70 04 00 	mov    %dl,0x47084(,%eax,8)
   40716:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40719:	0f b6 14 c5 84 70 04 	movzbl 0x47084(,%eax,8),%edx
   40720:	00 
   40721:	83 e2 1f             	and    $0x1f,%edx
   40724:	88 14 c5 84 70 04 00 	mov    %dl,0x47084(,%eax,8)
   4072b:	8b 45 f0             	mov    -0x10(%ebp),%eax
   4072e:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   40735:	00 
   40736:	83 e2 f0             	and    $0xfffffff0,%edx
   40739:	83 ca 0e             	or     $0xe,%edx
   4073c:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   40743:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40746:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   4074d:	00 
   4074e:	83 e2 ef             	and    $0xffffffef,%edx
   40751:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   40758:	8b 45 f0             	mov    -0x10(%ebp),%eax
   4075b:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   40762:	00 
   40763:	83 ca 60             	or     $0x60,%edx
   40766:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   4076d:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40770:	0f b6 14 c5 85 70 04 	movzbl 0x47085(,%eax,8),%edx
   40777:	00 
   40778:	83 ca 80             	or     $0xffffff80,%edx
   4077b:	88 14 c5 85 70 04 00 	mov    %dl,0x47085(,%eax,8)
   40782:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40785:	83 e8 30             	sub    $0x30,%eax
   40788:	8b 04 85 b8 00 04 00 	mov    0x400b8(,%eax,4),%eax
   4078f:	c1 e8 10             	shr    $0x10,%eax
   40792:	89 c2                	mov    %eax,%edx
   40794:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40797:	66 89 14 c5 86 70 04 	mov    %dx,0x47086(,%eax,8)
   4079e:	00 
            SEGSEL_KERN_CODE, pagefault_int_handler, 0);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (int i = INT_SYS; i < INT_SYS + 16; ++i)
   4079f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
   407a3:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
   407a7:	0f 8e 2d ff ff ff    	jle    406da <segments_init+0x358>
        SETGATE(interrupt_descriptors[i], 0,
                SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS], 3);

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   407ad:	b8 28 00 00 00       	mov    $0x28,%eax
   407b2:	0f 01 15 30 30 04 00 	lgdtl  0x43030
   407b9:	0f 00 d8             	ltr    %ax
   407bc:	0f 01 1d 36 30 04 00 	lidtl  0x43036
                 "lidt %2"
                 :
                 : "m" (global_descriptor_table),
                   "r" ((uint16_t) SEGSEL_TASKSTATE),
                   "m" (interrupt_descriptor_table));
}
   407c3:	c9                   	leave  
   407c4:	c3                   	ret    

000407c5 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   407c5:	55                   	push   %ebp
   407c6:	89 e5                	mov    %esp,%ebp
   407c8:	83 ec 20             	sub    $0x20,%esp
    uint16_t masked = ~interrupts_enabled;
   407cb:	0f b7 05 80 78 04 00 	movzwl 0x47880,%eax
   407d2:	f7 d0                	not    %eax
   407d4:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
    outb(IO_PIC1+1, masked & 0xFF);
   407d8:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
   407dc:	0f b6 c0             	movzbl %al,%eax
   407df:	c7 45 f8 21 00 00 00 	movl   $0x21,-0x8(%ebp)
   407e6:	88 45 f7             	mov    %al,-0x9(%ebp)
                 : "d" (port), "0" (addr), "1" (cnt)
                 : "memory", "cc");
}

static inline void outb(int port, uint8_t data) {
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   407e9:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
   407ed:	8b 55 f8             	mov    -0x8(%ebp),%edx
   407f0:	ee                   	out    %al,(%dx)
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   407f1:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
   407f5:	66 c1 e8 08          	shr    $0x8,%ax
   407f9:	0f b6 c0             	movzbl %al,%eax
   407fc:	c7 45 f0 a1 00 00 00 	movl   $0xa1,-0x10(%ebp)
   40803:	88 45 ef             	mov    %al,-0x11(%ebp)
   40806:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
   4080a:	8b 55 f0             	mov    -0x10(%ebp),%edx
   4080d:	ee                   	out    %al,(%dx)
}
   4080e:	c9                   	leave  
   4080f:	c3                   	ret    

00040810 <interrupt_init>:

void interrupt_init(void) {
   40810:	55                   	push   %ebp
   40811:	89 e5                	mov    %esp,%ebp
   40813:	83 ec 60             	sub    $0x60,%esp
    // mask all interrupts
    interrupts_enabled = 0;
   40816:	66 c7 05 80 78 04 00 	movw   $0x0,0x47880
   4081d:	00 00 
    interrupt_mask();
   4081f:	e8 a1 ff ff ff       	call   407c5 <interrupt_mask>
   40824:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%ebp)
   4082b:	c6 45 fb 11          	movb   $0x11,-0x5(%ebp)
   4082f:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
   40833:	8b 55 fc             	mov    -0x4(%ebp),%edx
   40836:	ee                   	out    %al,(%dx)
   40837:	c7 45 f4 21 00 00 00 	movl   $0x21,-0xc(%ebp)
   4083e:	c6 45 f3 20          	movb   $0x20,-0xd(%ebp)
   40842:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
   40846:	8b 55 f4             	mov    -0xc(%ebp),%edx
   40849:	ee                   	out    %al,(%dx)
   4084a:	c7 45 ec 21 00 00 00 	movl   $0x21,-0x14(%ebp)
   40851:	c6 45 eb 04          	movb   $0x4,-0x15(%ebp)
   40855:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
   40859:	8b 55 ec             	mov    -0x14(%ebp),%edx
   4085c:	ee                   	out    %al,(%dx)
   4085d:	c7 45 e4 21 00 00 00 	movl   $0x21,-0x1c(%ebp)
   40864:	c6 45 e3 03          	movb   $0x3,-0x1d(%ebp)
   40868:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
   4086c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
   4086f:	ee                   	out    %al,(%dx)
   40870:	c7 45 dc a0 00 00 00 	movl   $0xa0,-0x24(%ebp)
   40877:	c6 45 db 11          	movb   $0x11,-0x25(%ebp)
   4087b:	0f b6 45 db          	movzbl -0x25(%ebp),%eax
   4087f:	8b 55 dc             	mov    -0x24(%ebp),%edx
   40882:	ee                   	out    %al,(%dx)
   40883:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%ebp)
   4088a:	c6 45 d3 28          	movb   $0x28,-0x2d(%ebp)
   4088e:	0f b6 45 d3          	movzbl -0x2d(%ebp),%eax
   40892:	8b 55 d4             	mov    -0x2c(%ebp),%edx
   40895:	ee                   	out    %al,(%dx)
   40896:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%ebp)
   4089d:	c6 45 cb 02          	movb   $0x2,-0x35(%ebp)
   408a1:	0f b6 45 cb          	movzbl -0x35(%ebp),%eax
   408a5:	8b 55 cc             	mov    -0x34(%ebp),%edx
   408a8:	ee                   	out    %al,(%dx)
   408a9:	c7 45 c4 a1 00 00 00 	movl   $0xa1,-0x3c(%ebp)
   408b0:	c6 45 c3 01          	movb   $0x1,-0x3d(%ebp)
   408b4:	0f b6 45 c3          	movzbl -0x3d(%ebp),%eax
   408b8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
   408bb:	ee                   	out    %al,(%dx)
   408bc:	c7 45 bc 20 00 00 00 	movl   $0x20,-0x44(%ebp)
   408c3:	c6 45 bb 68          	movb   $0x68,-0x45(%ebp)
   408c7:	0f b6 45 bb          	movzbl -0x45(%ebp),%eax
   408cb:	8b 55 bc             	mov    -0x44(%ebp),%edx
   408ce:	ee                   	out    %al,(%dx)
   408cf:	c7 45 b4 20 00 00 00 	movl   $0x20,-0x4c(%ebp)
   408d6:	c6 45 b3 0a          	movb   $0xa,-0x4d(%ebp)
   408da:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
   408de:	8b 55 b4             	mov    -0x4c(%ebp),%edx
   408e1:	ee                   	out    %al,(%dx)
   408e2:	c7 45 ac a0 00 00 00 	movl   $0xa0,-0x54(%ebp)
   408e9:	c6 45 ab 68          	movb   $0x68,-0x55(%ebp)
   408ed:	0f b6 45 ab          	movzbl -0x55(%ebp),%eax
   408f1:	8b 55 ac             	mov    -0x54(%ebp),%edx
   408f4:	ee                   	out    %al,(%dx)
   408f5:	c7 45 a4 a0 00 00 00 	movl   $0xa0,-0x5c(%ebp)
   408fc:	c6 45 a3 0a          	movb   $0xa,-0x5d(%ebp)
   40900:	0f b6 45 a3          	movzbl -0x5d(%ebp),%eax
   40904:	8b 55 a4             	mov    -0x5c(%ebp),%edx
   40907:	ee                   	out    %al,(%dx)

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   40908:	e8 b8 fe ff ff       	call   407c5 <interrupt_mask>
}
   4090d:	c9                   	leave  
   4090e:	c3                   	ret    

0004090f <virtual_memory_init>:

static x86_pagetable kernel_pagetable_memory;
static x86_pagetable kernel_level2_pagetable;
x86_pagetable* kernel_pagetable;

void virtual_memory_init(void) {
   4090f:	55                   	push   %ebp
   40910:	89 e5                	mov    %esp,%ebp
   40912:	83 ec 38             	sub    $0x38,%esp
    kernel_pagetable = &kernel_pagetable_memory;
   40915:	c7 05 0c a0 04 00 00 	movl   $0x48000,0x4a00c
   4091c:	80 04 00 
    memset(kernel_pagetable, 0, sizeof(x86_pagetable));
   4091f:	a1 0c a0 04 00       	mov    0x4a00c,%eax
   40924:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
   4092b:	00 
   4092c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   40933:	00 
   40934:	89 04 24             	mov    %eax,(%esp)
   40937:	e8 24 0c 00 00       	call   41560 <memset>
    kernel_pagetable->entry[0] = (x86_pageentry_t) &kernel_level2_pagetable
   4093c:	a1 0c a0 04 00       	mov    0x4a00c,%eax
   40941:	ba 00 90 04 00       	mov    $0x49000,%edx
            | PTE_P | PTE_W | PTE_U;
   40946:	83 ca 07             	or     $0x7,%edx
x86_pagetable* kernel_pagetable;

void virtual_memory_init(void) {
    kernel_pagetable = &kernel_pagetable_memory;
    memset(kernel_pagetable, 0, sizeof(x86_pagetable));
    kernel_pagetable->entry[0] = (x86_pageentry_t) &kernel_level2_pagetable
   40949:	89 10                	mov    %edx,(%eax)
            | PTE_P | PTE_W | PTE_U;

    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4094b:	a1 0c a0 04 00       	mov    0x4a00c,%eax
   40950:	c7 44 24 10 07 00 00 	movl   $0x7,0x10(%esp)
   40957:	00 
   40958:	c7 44 24 0c 00 00 20 	movl   $0x200000,0xc(%esp)
   4095f:	00 
   40960:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
   40967:	00 
   40968:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   4096f:	00 
   40970:	89 04 24             	mov    %eax,(%esp)
   40973:	e8 33 00 00 00       	call   409ab <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // Use special instructions to initialize paged virtual memory.
    lcr3((uintptr_t) kernel_pagetable);
   40978:	a1 0c a0 04 00       	mov    0x4a00c,%eax
   4097d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile("movl %%cr2,%0" : "=r" (val));
    return val;
}

static inline void lcr3(uintptr_t val) {
    asm volatile("movl %0,%%cr3" : : "r" (val));
   40980:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40983:	0f 22 d8             	mov    %eax,%cr3
    asm volatile("movl %0,%%cr0" : : "r" (val));
}

static inline uint32_t rcr0(void) {
    uint32_t val;
    asm volatile("movl %%cr0,%0" : "=r" (val));
   40986:	0f 20 c0             	mov    %cr0,%eax
   40989:	89 45 ec             	mov    %eax,-0x14(%ebp)
    return val;
   4098c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    uint32_t cr0 = rcr0();
   4098f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS
   40992:	81 4d f4 2f 00 05 80 	orl    $0x8005002f,-0xc(%ebp)
        | CR0_EM | CR0_MP;
    cr0 &= ~(CR0_TS | CR0_EM);
   40999:	83 65 f4 f3          	andl   $0xfffffff3,-0xc(%ebp)
   4099d:	8b 45 f4             	mov    -0xc(%ebp),%eax
   409a0:	89 45 e8             	mov    %eax,-0x18(%ebp)
static inline void ltr(uint16_t sel) {
    asm volatile("ltr %0" : : "r" (sel));
}

static inline void lcr0(uint32_t val) {
    asm volatile("movl %0,%%cr0" : : "r" (val));
   409a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
   409a6:	0f 22 c0             	mov    %eax,%cr0
    lcr0(cr0);
}
   409a9:	c9                   	leave  
   409aa:	c3                   	ret    

000409ab <virtual_memory_map>:
//    `PTE_W` (the memory is Writable), and `PTE_U` (the memory may be
//    accessed by Unprivileged applications). If `!(perm & PTE_P)`, `pa` is
//    ignored.

void virtual_memory_map(x86_pagetable* pagetable, uintptr_t va, uintptr_t pa,
                        size_t sz, int perm) {
   409ab:	55                   	push   %ebp
   409ac:	89 e5                	mov    %esp,%ebp
   409ae:	83 ec 28             	sub    $0x28,%esp
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   409b1:	8b 45 0c             	mov    0xc(%ebp),%eax
   409b4:	25 ff 0f 00 00       	and    $0xfff,%eax
   409b9:	85 c0                	test   %eax,%eax
   409bb:	74 1c                	je     409d9 <virtual_memory_map+0x2e>
   409bd:	c7 44 24 08 80 1c 04 	movl   $0x41c80,0x8(%esp)
   409c4:	00 
   409c5:	c7 44 24 04 14 01 00 	movl   $0x114,0x4(%esp)
   409cc:	00 
   409cd:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   409d4:	e8 42 09 00 00       	call   4131b <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   409d9:	8b 45 14             	mov    0x14(%ebp),%eax
   409dc:	25 ff 0f 00 00       	and    $0xfff,%eax
   409e1:	85 c0                	test   %eax,%eax
   409e3:	74 1c                	je     40a01 <virtual_memory_map+0x56>
   409e5:	c7 44 24 08 a0 1c 04 	movl   $0x41ca0,0x8(%esp)
   409ec:	00 
   409ed:	c7 44 24 04 15 01 00 	movl   $0x115,0x4(%esp)
   409f4:	00 
   409f5:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   409fc:	e8 1a 09 00 00       	call   4131b <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   40a01:	8b 45 14             	mov    0x14(%ebp),%eax
   40a04:	8b 55 0c             	mov    0xc(%ebp),%edx
   40a07:	01 d0                	add    %edx,%eax
   40a09:	3b 45 0c             	cmp    0xc(%ebp),%eax
   40a0c:	73 28                	jae    40a36 <virtual_memory_map+0x8b>
   40a0e:	8b 45 14             	mov    0x14(%ebp),%eax
   40a11:	8b 55 0c             	mov    0xc(%ebp),%edx
   40a14:	01 d0                	add    %edx,%eax
   40a16:	85 c0                	test   %eax,%eax
   40a18:	74 1c                	je     40a36 <virtual_memory_map+0x8b>
   40a1a:	c7 44 24 08 b3 1c 04 	movl   $0x41cb3,0x8(%esp)
   40a21:	00 
   40a22:	c7 44 24 04 16 01 00 	movl   $0x116,0x4(%esp)
   40a29:	00 
   40a2a:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40a31:	e8 e5 08 00 00       	call   4131b <assert_fail>
    if (perm & PTE_P) {
   40a36:	8b 45 18             	mov    0x18(%ebp),%eax
   40a39:	83 e0 01             	and    $0x1,%eax
   40a3c:	85 c0                	test   %eax,%eax
   40a3e:	74 7c                	je     40abc <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   40a40:	8b 45 10             	mov    0x10(%ebp),%eax
   40a43:	25 ff 0f 00 00       	and    $0xfff,%eax
   40a48:	85 c0                	test   %eax,%eax
   40a4a:	74 1c                	je     40a68 <virtual_memory_map+0xbd>
   40a4c:	c7 44 24 08 d1 1c 04 	movl   $0x41cd1,0x8(%esp)
   40a53:	00 
   40a54:	c7 44 24 04 18 01 00 	movl   $0x118,0x4(%esp)
   40a5b:	00 
   40a5c:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40a63:	e8 b3 08 00 00       	call   4131b <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   40a68:	8b 45 14             	mov    0x14(%ebp),%eax
   40a6b:	8b 55 10             	mov    0x10(%ebp),%edx
   40a6e:	01 d0                	add    %edx,%eax
   40a70:	3b 45 10             	cmp    0x10(%ebp),%eax
   40a73:	73 1c                	jae    40a91 <virtual_memory_map+0xe6>
   40a75:	c7 44 24 08 e4 1c 04 	movl   $0x41ce4,0x8(%esp)
   40a7c:	00 
   40a7d:	c7 44 24 04 19 01 00 	movl   $0x119,0x4(%esp)
   40a84:	00 
   40a85:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40a8c:	e8 8a 08 00 00       	call   4131b <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   40a91:	8b 45 14             	mov    0x14(%ebp),%eax
   40a94:	8b 55 10             	mov    0x10(%ebp),%edx
   40a97:	01 d0                	add    %edx,%eax
   40a99:	3d 00 00 20 00       	cmp    $0x200000,%eax
   40a9e:	76 1c                	jbe    40abc <virtual_memory_map+0x111>
   40aa0:	c7 44 24 08 f2 1c 04 	movl   $0x41cf2,0x8(%esp)
   40aa7:	00 
   40aa8:	c7 44 24 04 1a 01 00 	movl   $0x11a,0x4(%esp)
   40aaf:	00 
   40ab0:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40ab7:	e8 5f 08 00 00       	call   4131b <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense
   40abc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
   40ac0:	78 09                	js     40acb <virtual_memory_map+0x120>
   40ac2:	81 7d 18 ff 0f 00 00 	cmpl   $0xfff,0x18(%ebp)
   40ac9:	7e 1c                	jle    40ae7 <virtual_memory_map+0x13c>
   40acb:	c7 44 24 08 0e 1d 04 	movl   $0x41d0e,0x8(%esp)
   40ad2:	00 
   40ad3:	c7 44 24 04 1c 01 00 	movl   $0x11c,0x4(%esp)
   40ada:	00 
   40adb:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40ae2:	e8 34 08 00 00       	call   4131b <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   40ae7:	8b 45 08             	mov    0x8(%ebp),%eax
   40aea:	25 ff 0f 00 00       	and    $0xfff,%eax
   40aef:	85 c0                	test   %eax,%eax
   40af1:	74 1c                	je     40b0f <virtual_memory_map+0x164>
   40af3:	c7 44 24 08 2c 1d 04 	movl   $0x41d2c,0x8(%esp)
   40afa:	00 
   40afb:	c7 44 24 04 1d 01 00 	movl   $0x11d,0x4(%esp)
   40b02:	00 
   40b03:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40b0a:	e8 0c 08 00 00       	call   4131b <assert_fail>

    int l1pageindex = -1;
   40b0f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    x86_pagetable* l2pagetable = 0;
   40b16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   40b1d:	e9 36 01 00 00       	jmp    40c58 <virtual_memory_map+0x2ad>
        if (L1PAGEINDEX(va) != l1pageindex) {
   40b22:	8b 45 0c             	mov    0xc(%ebp),%eax
   40b25:	c1 e8 16             	shr    $0x16,%eax
   40b28:	89 c2                	mov    %eax,%edx
   40b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40b2d:	39 c2                	cmp    %eax,%edx
   40b2f:	0f 84 d1 00 00 00    	je     40c06 <virtual_memory_map+0x25b>
            l1pageindex = L1PAGEINDEX(va);
   40b35:	8b 45 0c             	mov    0xc(%ebp),%eax
   40b38:	c1 e8 16             	shr    $0x16,%eax
   40b3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
            x86_pageentry_t l1pte = pagetable->entry[l1pageindex];
   40b3e:	8b 45 08             	mov    0x8(%ebp),%eax
   40b41:	8b 55 f4             	mov    -0xc(%ebp),%edx
   40b44:	8b 04 90             	mov    (%eax,%edx,4),%eax
   40b47:	89 45 ec             	mov    %eax,-0x14(%ebp)
            assert(l1pte & PTE_P);      // level-2 pagetable must exist
   40b4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
   40b4d:	83 e0 01             	and    $0x1,%eax
   40b50:	85 c0                	test   %eax,%eax
   40b52:	75 1c                	jne    40b70 <virtual_memory_map+0x1c5>
   40b54:	c7 44 24 08 52 1d 04 	movl   $0x41d52,0x8(%esp)
   40b5b:	00 
   40b5c:	c7 44 24 04 25 01 00 	movl   $0x125,0x4(%esp)
   40b63:	00 
   40b64:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40b6b:	e8 ab 07 00 00       	call   4131b <assert_fail>
            assert(PTE_ADDR(l1pte) < MEMSIZE_VIRTUAL); // at a sensible address
   40b70:	8b 45 ec             	mov    -0x14(%ebp),%eax
   40b73:	25 00 f0 ff ff       	and    $0xfffff000,%eax
   40b78:	3d ff ff 2f 00       	cmp    $0x2fffff,%eax
   40b7d:	76 1c                	jbe    40b9b <virtual_memory_map+0x1f0>
   40b7f:	c7 44 24 08 60 1d 04 	movl   $0x41d60,0x8(%esp)
   40b86:	00 
   40b87:	c7 44 24 04 26 01 00 	movl   $0x126,0x4(%esp)
   40b8e:	00 
   40b8f:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40b96:	e8 80 07 00 00       	call   4131b <assert_fail>
            if (perm & PTE_W)           // if requester wants PTE_W,
   40b9b:	8b 45 18             	mov    0x18(%ebp),%eax
   40b9e:	83 e0 02             	and    $0x2,%eax
   40ba1:	85 c0                	test   %eax,%eax
   40ba3:	74 26                	je     40bcb <virtual_memory_map+0x220>
                assert(l1pte & PTE_W);  //   level-1 entry must allow PTE_W
   40ba5:	8b 45 ec             	mov    -0x14(%ebp),%eax
   40ba8:	83 e0 02             	and    $0x2,%eax
   40bab:	85 c0                	test   %eax,%eax
   40bad:	75 1c                	jne    40bcb <virtual_memory_map+0x220>
   40baf:	c7 44 24 08 82 1d 04 	movl   $0x41d82,0x8(%esp)
   40bb6:	00 
   40bb7:	c7 44 24 04 28 01 00 	movl   $0x128,0x4(%esp)
   40bbe:	00 
   40bbf:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40bc6:	e8 50 07 00 00       	call   4131b <assert_fail>
            if (perm & PTE_U)           // if requester wants PTE_U,
   40bcb:	8b 45 18             	mov    0x18(%ebp),%eax
   40bce:	83 e0 04             	and    $0x4,%eax
   40bd1:	85 c0                	test   %eax,%eax
   40bd3:	74 26                	je     40bfb <virtual_memory_map+0x250>
                assert(l1pte & PTE_U);  //   level-1 entry must allow PTE_U
   40bd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
   40bd8:	83 e0 04             	and    $0x4,%eax
   40bdb:	85 c0                	test   %eax,%eax
   40bdd:	75 1c                	jne    40bfb <virtual_memory_map+0x250>
   40bdf:	c7 44 24 08 90 1d 04 	movl   $0x41d90,0x8(%esp)
   40be6:	00 
   40be7:	c7 44 24 04 2a 01 00 	movl   $0x12a,0x4(%esp)
   40bee:	00 
   40bef:	c7 04 24 93 1c 04 00 	movl   $0x41c93,(%esp)
   40bf6:	e8 20 07 00 00       	call   4131b <assert_fail>
            l2pagetable = (x86_pagetable*) PTE_ADDR(l1pte);
   40bfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
   40bfe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
   40c03:	89 45 f0             	mov    %eax,-0x10(%ebp)
        }
        if (perm & PTE_P)
   40c06:	8b 45 18             	mov    0x18(%ebp),%eax
   40c09:	83 e0 01             	and    $0x1,%eax
   40c0c:	85 c0                	test   %eax,%eax
   40c0e:	74 1d                	je     40c2d <virtual_memory_map+0x282>
            l2pagetable->entry[L2PAGEINDEX(va)] = pa | perm;
   40c10:	8b 45 0c             	mov    0xc(%ebp),%eax
   40c13:	c1 e8 0c             	shr    $0xc,%eax
   40c16:	25 ff 03 00 00       	and    $0x3ff,%eax
   40c1b:	89 c1                	mov    %eax,%ecx
   40c1d:	8b 45 18             	mov    0x18(%ebp),%eax
   40c20:	0b 45 10             	or     0x10(%ebp),%eax
   40c23:	89 c2                	mov    %eax,%edx
   40c25:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40c28:	89 14 88             	mov    %edx,(%eax,%ecx,4)
   40c2b:	eb 16                	jmp    40c43 <virtual_memory_map+0x298>
        else
            l2pagetable->entry[L2PAGEINDEX(va)] = perm;
   40c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
   40c30:	c1 e8 0c             	shr    $0xc,%eax
   40c33:	25 ff 03 00 00       	and    $0x3ff,%eax
   40c38:	89 c1                	mov    %eax,%ecx
   40c3a:	8b 55 18             	mov    0x18(%ebp),%edx
   40c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40c40:	89 14 88             	mov    %edx,(%eax,%ecx,4)
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned

    int l1pageindex = -1;
    x86_pagetable* l2pagetable = 0;
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   40c43:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
   40c4a:	81 45 10 00 10 00 00 	addl   $0x1000,0x10(%ebp)
   40c51:	81 6d 14 00 10 00 00 	subl   $0x1000,0x14(%ebp)
   40c58:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
   40c5c:	0f 85 c0 fe ff ff    	jne    40b22 <virtual_memory_map+0x177>
        if (perm & PTE_P)
            l2pagetable->entry[L2PAGEINDEX(va)] = pa | perm;
        else
            l2pagetable->entry[L2PAGEINDEX(va)] = perm;
    }
}
   40c62:	c9                   	leave  
   40c63:	c3                   	ret    

00040c64 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   40c64:	55                   	push   %ebp
   40c65:	89 e5                	mov    %esp,%ebp
    return (bus << 16) | (slot << 11) | (func << 8);
   40c67:	8b 45 08             	mov    0x8(%ebp),%eax
   40c6a:	c1 e0 10             	shl    $0x10,%eax
   40c6d:	89 c2                	mov    %eax,%edx
   40c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
   40c72:	c1 e0 0b             	shl    $0xb,%eax
   40c75:	09 c2                	or     %eax,%edx
   40c77:	8b 45 10             	mov    0x10(%ebp),%eax
   40c7a:	c1 e0 08             	shl    $0x8,%eax
   40c7d:	09 d0                	or     %edx,%eax
}
   40c7f:	5d                   	pop    %ebp
   40c80:	c3                   	ret    

00040c81 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   40c81:	55                   	push   %ebp
   40c82:	89 e5                	mov    %esp,%ebp
   40c84:	83 ec 10             	sub    $0x10,%esp
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   40c87:	8b 55 08             	mov    0x8(%ebp),%edx
   40c8a:	8b 45 0c             	mov    0xc(%ebp),%eax
   40c8d:	09 d0                	or     %edx,%eax
   40c8f:	0d 00 00 00 80       	or     $0x80000000,%eax
   40c94:	c7 45 fc f8 0c 00 00 	movl   $0xcf8,-0x4(%ebp)
   40c9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
                 : "d" (port), "0" (addr), "1" (cnt)
                 : "cc");
}

static inline void outl(int port, uint32_t data) {
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   40c9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
   40ca1:	8b 55 fc             	mov    -0x4(%ebp),%edx
   40ca4:	ef                   	out    %eax,(%dx)
   40ca5:	c7 45 f4 fc 0c 00 00 	movl   $0xcfc,-0xc(%ebp)
                 : "memory", "cc");
}

static inline uint32_t inl(int port) {
    uint32_t data;
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   40cac:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40caf:	89 c2                	mov    %eax,%edx
   40cb1:	ed                   	in     (%dx),%eax
   40cb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return data;
   40cb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   40cb8:	c9                   	leave  
   40cb9:	c3                   	ret    

00040cba <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   40cba:	55                   	push   %ebp
   40cbb:	89 e5                	mov    %esp,%ebp
   40cbd:	83 ec 2c             	sub    $0x2c,%esp
    for (int bus = 0; bus != 256; ++bus)
   40cc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
   40cc7:	eb 7d                	jmp    40d46 <pci_find_device+0x8c>
        for (int slot = 0; slot != 32; ++slot)
   40cc9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
   40cd0:	eb 6a                	jmp    40d3c <pci_find_device+0x82>
            for (int func = 0; func != 8; ++func) {
   40cd2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   40cd9:	eb 57                	jmp    40d32 <pci_find_device+0x78>
                int configaddr = pci_make_configaddr(bus, slot, func);
   40cdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40cde:	89 44 24 08          	mov    %eax,0x8(%esp)
   40ce2:	8b 45 f8             	mov    -0x8(%ebp),%eax
   40ce5:	89 44 24 04          	mov    %eax,0x4(%esp)
   40ce9:	8b 45 fc             	mov    -0x4(%ebp),%eax
   40cec:	89 04 24             	mov    %eax,(%esp)
   40cef:	e8 70 ff ff ff       	call   40c64 <pci_make_configaddr>
   40cf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   40cf7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   40cfe:	00 
   40cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40d02:	89 04 24             	mov    %eax,(%esp)
   40d05:	e8 77 ff ff ff       	call   40c81 <pci_config_readl>
   40d0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
                if (vendor_device == (vendor | (device << 16)))
   40d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
   40d10:	c1 e0 10             	shl    $0x10,%eax
   40d13:	0b 45 08             	or     0x8(%ebp),%eax
   40d16:	3b 45 ec             	cmp    -0x14(%ebp),%eax
   40d19:	75 05                	jne    40d20 <pci_find_device+0x66>
                    return configaddr;
   40d1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40d1e:	eb 38                	jmp    40d58 <pci_find_device+0x9e>
                else if (vendor_device == (uint32_t) -1 && func == 0)
   40d20:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
   40d24:	75 08                	jne    40d2e <pci_find_device+0x74>
   40d26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
   40d2a:	75 02                	jne    40d2e <pci_find_device+0x74>
                    break;
   40d2c:	eb 0a                	jmp    40d38 <pci_find_device+0x7e>
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
    for (int bus = 0; bus != 256; ++bus)
        for (int slot = 0; slot != 32; ++slot)
            for (int func = 0; func != 8; ++func) {
   40d2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
   40d32:	83 7d f4 08          	cmpl   $0x8,-0xc(%ebp)
   40d36:	75 a3                	jne    40cdb <pci_find_device+0x21>
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
    for (int bus = 0; bus != 256; ++bus)
        for (int slot = 0; slot != 32; ++slot)
   40d38:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
   40d3c:	83 7d f8 20          	cmpl   $0x20,-0x8(%ebp)
   40d40:	75 90                	jne    40cd2 <pci_find_device+0x18>
// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
    for (int bus = 0; bus != 256; ++bus)
   40d42:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   40d46:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%ebp)
   40d4d:	0f 85 76 ff ff ff    	jne    40cc9 <pci_find_device+0xf>
                if (vendor_device == (vendor | (device << 16)))
                    return configaddr;
                else if (vendor_device == (uint32_t) -1 && func == 0)
                    break;
            }
    return -1;
   40d53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   40d58:	c9                   	leave  
   40d59:	c3                   	ret    

00040d5a <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   40d5a:	55                   	push   %ebp
   40d5b:	89 e5                	mov    %esp,%ebp
   40d5d:	83 ec 28             	sub    $0x28,%esp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   40d60:	c7 44 24 04 13 71 00 	movl   $0x7113,0x4(%esp)
   40d67:	00 
   40d68:	c7 04 24 86 80 00 00 	movl   $0x8086,(%esp)
   40d6f:	e8 46 ff ff ff       	call   40cba <pci_find_device>
   40d74:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (configaddr >= 0) {
   40d77:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
   40d7b:	78 33                	js     40db0 <poweroff+0x56>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   40d7d:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
   40d84:	00 
   40d85:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40d88:	89 04 24             	mov    %eax,(%esp)
   40d8b:	e8 f1 fe ff ff       	call   40c81 <pci_config_readl>
   40d90:	25 c0 ff 00 00       	and    $0xffc0,%eax
   40d95:	89 45 f0             	mov    %eax,-0x10(%ebp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   40d98:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40d9b:	83 c0 04             	add    $0x4,%eax
   40d9e:	89 45 ec             	mov    %eax,-0x14(%ebp)
   40da1:	66 c7 45 ea 00 20    	movw   $0x2000,-0x16(%ebp)
                 : "d" (port), "0" (addr), "1" (cnt)
                 : "cc");
}

static inline void outw(int port, uint16_t data) {
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   40da7:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
   40dab:	8b 55 ec             	mov    -0x14(%ebp),%edx
   40dae:	66 ef                	out    %ax,(%dx)
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   40db0:	c7 44 24 08 9e 1d 04 	movl   $0x41d9e,0x8(%esp)
   40db7:	00 
   40db8:	c7 44 24 04 00 c0 00 	movl   $0xc000,0x4(%esp)
   40dbf:	00 
   40dc0:	c7 04 24 80 07 00 00 	movl   $0x780,(%esp)
   40dc7:	e8 e8 0d 00 00       	call   41bb4 <console_printf>
 spinloop: goto spinloop;
   40dcc:	eb fe                	jmp    40dcc <poweroff+0x72>

00040dce <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   40dce:	55                   	push   %ebp
   40dcf:	89 e5                	mov    %esp,%ebp
   40dd1:	83 ec 18             	sub    $0x18,%esp
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   40dd4:	8b 45 08             	mov    0x8(%ebp),%eax
   40dd7:	83 c0 04             	add    $0x4,%eax
   40dda:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
   40de1:	00 
   40de2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   40de9:	00 
   40dea:	89 04 24             	mov    %eax,(%esp)
   40ded:	e8 6e 07 00 00       	call   41560 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   40df2:	8b 45 08             	mov    0x8(%ebp),%eax
   40df5:	66 c7 40 38 1b 00    	movw   $0x1b,0x38(%eax)
    p->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
   40dfb:	8b 45 08             	mov    0x8(%ebp),%eax
   40dfe:	66 c7 40 28 23 00    	movw   $0x23,0x28(%eax)
    p->p_registers.reg_es = SEGSEL_APP_DATA | 3;
   40e04:	8b 45 08             	mov    0x8(%ebp),%eax
   40e07:	66 c7 40 24 23 00    	movw   $0x23,0x24(%eax)
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   40e0d:	8b 45 08             	mov    0x8(%ebp),%eax
   40e10:	66 c7 40 44 23 00    	movw   $0x23,0x44(%eax)
    p->p_registers.reg_eflags = EFLAGS_IF;
   40e16:	8b 45 08             	mov    0x8(%ebp),%eax
   40e19:	c7 40 3c 00 02 00 00 	movl   $0x200,0x3c(%eax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO)
   40e20:	8b 45 0c             	mov    0xc(%ebp),%eax
   40e23:	83 e0 01             	and    $0x1,%eax
   40e26:	85 c0                	test   %eax,%eax
   40e28:	74 11                	je     40e3b <process_init+0x6d>
        p->p_registers.reg_eflags |= EFLAGS_IOPL_3;
   40e2a:	8b 45 08             	mov    0x8(%ebp),%eax
   40e2d:	8b 40 3c             	mov    0x3c(%eax),%eax
   40e30:	80 cc 30             	or     $0x30,%ah
   40e33:	89 c2                	mov    %eax,%edx
   40e35:	8b 45 08             	mov    0x8(%ebp),%eax
   40e38:	89 50 3c             	mov    %edx,0x3c(%eax)
    if (flags & PROCINIT_DISABLE_INTERRUPTS)
   40e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
   40e3e:	83 e0 02             	and    $0x2,%eax
   40e41:	85 c0                	test   %eax,%eax
   40e43:	74 11                	je     40e56 <process_init+0x88>
        p->p_registers.reg_eflags &= ~EFLAGS_IF;
   40e45:	8b 45 08             	mov    0x8(%ebp),%eax
   40e48:	8b 40 3c             	mov    0x3c(%eax),%eax
   40e4b:	80 e4 fd             	and    $0xfd,%ah
   40e4e:	89 c2                	mov    %eax,%edx
   40e50:	8b 45 08             	mov    0x8(%ebp),%eax
   40e53:	89 50 3c             	mov    %edx,0x3c(%eax)
}
   40e56:	c9                   	leave  
   40e57:	c3                   	ret    

00040e58 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   40e58:	55                   	push   %ebp
   40e59:	89 e5                	mov    %esp,%ebp
   40e5b:	83 ec 20             	sub    $0x20,%esp
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS)
   40e5e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
   40e62:	78 09                	js     40e6d <console_show_cursor+0x15>
   40e64:	81 7d 08 d0 07 00 00 	cmpl   $0x7d0,0x8(%ebp)
   40e6b:	7e 07                	jle    40e74 <console_show_cursor+0x1c>
        cpos = 0;
   40e6d:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
   40e74:	c7 45 fc d4 03 00 00 	movl   $0x3d4,-0x4(%ebp)
   40e7b:	c6 45 fb 0e          	movb   $0xe,-0x5(%ebp)
                 : "d" (port), "0" (addr), "1" (cnt)
                 : "memory", "cc");
}

static inline void outb(int port, uint8_t data) {
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   40e7f:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
   40e83:	8b 55 fc             	mov    -0x4(%ebp),%edx
   40e86:	ee                   	out    %al,(%dx)
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   40e87:	8b 45 08             	mov    0x8(%ebp),%eax
   40e8a:	8d 90 ff 00 00 00    	lea    0xff(%eax),%edx
   40e90:	85 c0                	test   %eax,%eax
   40e92:	0f 48 c2             	cmovs  %edx,%eax
   40e95:	c1 f8 08             	sar    $0x8,%eax
   40e98:	0f b6 c0             	movzbl %al,%eax
   40e9b:	c7 45 f4 d5 03 00 00 	movl   $0x3d5,-0xc(%ebp)
   40ea2:	88 45 f3             	mov    %al,-0xd(%ebp)
   40ea5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
   40ea9:	8b 55 f4             	mov    -0xc(%ebp),%edx
   40eac:	ee                   	out    %al,(%dx)
   40ead:	c7 45 ec d4 03 00 00 	movl   $0x3d4,-0x14(%ebp)
   40eb4:	c6 45 eb 0f          	movb   $0xf,-0x15(%ebp)
   40eb8:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
   40ebc:	8b 55 ec             	mov    -0x14(%ebp),%edx
   40ebf:	ee                   	out    %al,(%dx)
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   40ec0:	8b 45 08             	mov    0x8(%ebp),%eax
   40ec3:	99                   	cltd   
   40ec4:	c1 ea 18             	shr    $0x18,%edx
   40ec7:	01 d0                	add    %edx,%eax
   40ec9:	0f b6 c0             	movzbl %al,%eax
   40ecc:	29 d0                	sub    %edx,%eax
   40ece:	0f b6 c0             	movzbl %al,%eax
   40ed1:	c7 45 e4 d5 03 00 00 	movl   $0x3d5,-0x1c(%ebp)
   40ed8:	88 45 e3             	mov    %al,-0x1d(%ebp)
   40edb:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
   40edf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
   40ee2:	ee                   	out    %al,(%dx)
}
   40ee3:	c9                   	leave  
   40ee4:	c3                   	ret    

00040ee5 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   40ee5:	55                   	push   %ebp
   40ee6:	89 e5                	mov    %esp,%ebp
   40ee8:	83 ec 20             	sub    $0x20,%esp
   40eeb:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%ebp)
    asm volatile("int3");
}

static inline uint8_t inb(int port) {
    uint8_t data;
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   40ef2:	8b 45 f0             	mov    -0x10(%ebp),%eax
   40ef5:	89 c2                	mov    %eax,%edx
   40ef7:	ec                   	in     (%dx),%al
   40ef8:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
   40efb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0)
   40eff:	0f b6 c0             	movzbl %al,%eax
   40f02:	83 e0 01             	and    $0x1,%eax
   40f05:	85 c0                	test   %eax,%eax
   40f07:	75 0a                	jne    40f13 <keyboard_readc+0x2e>
        return -1;
   40f09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40f0e:	e9 d9 01 00 00       	jmp    410ec <keyboard_readc+0x207>
   40f13:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%ebp)
    asm volatile("int3");
}

static inline uint8_t inb(int port) {
    uint8_t data;
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   40f1a:	8b 45 e8             	mov    -0x18(%ebp),%eax
   40f1d:	89 c2                	mov    %eax,%edx
   40f1f:	ec                   	in     (%dx),%al
   40f20:	88 45 e7             	mov    %al,-0x19(%ebp)
    return data;
   40f23:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax

    uint8_t data = inb(KEYBOARD_DATAREG);
   40f27:	88 45 fb             	mov    %al,-0x5(%ebp)
    uint8_t escape = last_escape;
   40f2a:	0f b6 05 00 a0 04 00 	movzbl 0x4a000,%eax
   40f31:	88 45 fa             	mov    %al,-0x6(%ebp)
    last_escape = 0;
   40f34:	c6 05 00 a0 04 00 00 	movb   $0x0,0x4a000

    if (data == 0xE0) {         // mode shift
   40f3b:	80 7d fb e0          	cmpb   $0xe0,-0x5(%ebp)
   40f3f:	75 11                	jne    40f52 <keyboard_readc+0x6d>
        last_escape = 0x80;
   40f41:	c6 05 00 a0 04 00 80 	movb   $0x80,0x4a000
        return 0;
   40f48:	b8 00 00 00 00       	mov    $0x0,%eax
   40f4d:	e9 9a 01 00 00       	jmp    410ec <keyboard_readc+0x207>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   40f52:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
   40f56:	84 c0                	test   %al,%al
   40f58:	79 5d                	jns    40fb7 <keyboard_readc+0xd2>
        int ch = keymap[(data & 0x7F) | escape];
   40f5a:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
   40f5e:	83 e0 7f             	and    $0x7f,%eax
   40f61:	89 c2                	mov    %eax,%edx
   40f63:	0f b6 45 fa          	movzbl -0x6(%ebp),%eax
   40f67:	09 d0                	or     %edx,%eax
   40f69:	0f b6 80 c0 1d 04 00 	movzbl 0x41dc0(%eax),%eax
   40f70:	0f b6 c0             	movzbl %al,%eax
   40f73:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK)
   40f76:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%ebp)
   40f7d:	7e 2e                	jle    40fad <keyboard_readc+0xc8>
   40f7f:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%ebp)
   40f86:	7f 25                	jg     40fad <keyboard_readc+0xc8>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   40f88:	8b 45 f4             	mov    -0xc(%ebp),%eax
   40f8b:	2d fa 00 00 00       	sub    $0xfa,%eax
   40f90:	ba 01 00 00 00       	mov    $0x1,%edx
   40f95:	89 c1                	mov    %eax,%ecx
   40f97:	d3 e2                	shl    %cl,%edx
   40f99:	89 d0                	mov    %edx,%eax
   40f9b:	f7 d0                	not    %eax
   40f9d:	89 c2                	mov    %eax,%edx
   40f9f:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   40fa6:	21 d0                	and    %edx,%eax
   40fa8:	a2 01 a0 04 00       	mov    %al,0x4a001
        return 0;
   40fad:	b8 00 00 00 00       	mov    $0x0,%eax
   40fb2:	e9 35 01 00 00       	jmp    410ec <keyboard_readc+0x207>
    }

    int ch = (unsigned char) keymap[data | escape];
   40fb7:	0f b6 45 fa          	movzbl -0x6(%ebp),%eax
   40fbb:	0f b6 55 fb          	movzbl -0x5(%ebp),%edx
   40fbf:	09 d0                	or     %edx,%eax
   40fc1:	0f b6 c0             	movzbl %al,%eax
   40fc4:	0f b6 80 c0 1d 04 00 	movzbl 0x41dc0(%eax),%eax
   40fcb:	0f b6 c0             	movzbl %al,%eax
   40fce:	89 45 fc             	mov    %eax,-0x4(%ebp)

    if (ch >= 'a' && ch <= 'z') {
   40fd1:	83 7d fc 60          	cmpl   $0x60,-0x4(%ebp)
   40fd5:	7e 55                	jle    4102c <keyboard_readc+0x147>
   40fd7:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%ebp)
   40fdb:	7f 4f                	jg     4102c <keyboard_readc+0x147>
        if (modifiers & MOD_CONTROL)
   40fdd:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   40fe4:	0f b6 c0             	movzbl %al,%eax
   40fe7:	83 e0 02             	and    $0x2,%eax
   40fea:	85 c0                	test   %eax,%eax
   40fec:	74 06                	je     40ff4 <keyboard_readc+0x10f>
            ch -= 0x60;
   40fee:	83 6d fc 60          	subl   $0x60,-0x4(%ebp)
   40ff2:	eb 33                	jmp    41027 <keyboard_readc+0x142>
        else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK))
   40ff4:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   40ffb:	0f b6 c0             	movzbl %al,%eax
   40ffe:	83 e0 01             	and    $0x1,%eax
   41001:	85 c0                	test   %eax,%eax
   41003:	0f 94 c2             	sete   %dl
   41006:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   4100d:	0f b6 c0             	movzbl %al,%eax
   41010:	83 e0 08             	and    $0x8,%eax
   41013:	85 c0                	test   %eax,%eax
   41015:	0f 94 c0             	sete   %al
   41018:	31 d0                	xor    %edx,%eax
   4101a:	84 c0                	test   %al,%al
   4101c:	74 09                	je     41027 <keyboard_readc+0x142>
            ch -= 0x20;
   4101e:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)
    }

    int ch = (unsigned char) keymap[data | escape];

    if (ch >= 'a' && ch <= 'z') {
        if (modifiers & MOD_CONTROL)
   41022:	e9 c2 00 00 00       	jmp    410e9 <keyboard_readc+0x204>
   41027:	e9 bd 00 00 00       	jmp    410e9 <keyboard_readc+0x204>
            ch -= 0x60;
        else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK))
            ch -= 0x20;
    } else if (ch >= KEY_CAPSLOCK) {
   4102c:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%ebp)
   41033:	7e 2f                	jle    41064 <keyboard_readc+0x17f>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41035:	8b 45 fc             	mov    -0x4(%ebp),%eax
   41038:	2d fa 00 00 00       	sub    $0xfa,%eax
   4103d:	ba 01 00 00 00       	mov    $0x1,%edx
   41042:	89 c1                	mov    %eax,%ecx
   41044:	d3 e2                	shl    %cl,%edx
   41046:	89 d0                	mov    %edx,%eax
   41048:	89 c2                	mov    %eax,%edx
   4104a:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   41051:	31 d0                	xor    %edx,%eax
   41053:	a2 01 a0 04 00       	mov    %al,0x4a001
        ch = 0;
   41058:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
   4105f:	e9 85 00 00 00       	jmp    410e9 <keyboard_readc+0x204>
    } else if (ch >= KEY_SHIFT) {
   41064:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%ebp)
   4106b:	7e 2c                	jle    41099 <keyboard_readc+0x1b4>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4106d:	8b 45 fc             	mov    -0x4(%ebp),%eax
   41070:	2d fa 00 00 00       	sub    $0xfa,%eax
   41075:	ba 01 00 00 00       	mov    $0x1,%edx
   4107a:	89 c1                	mov    %eax,%ecx
   4107c:	d3 e2                	shl    %cl,%edx
   4107e:	89 d0                	mov    %edx,%eax
   41080:	89 c2                	mov    %eax,%edx
   41082:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   41089:	09 d0                	or     %edx,%eax
   4108b:	a2 01 a0 04 00       	mov    %al,0x4a001
        ch = 0;
   41090:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
   41097:	eb 50                	jmp    410e9 <keyboard_readc+0x204>
    } else if (ch >= CKEY(0) && ch <= CKEY(21))
   41099:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
   4109d:	7e 2c                	jle    410cb <keyboard_readc+0x1e6>
   4109f:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%ebp)
   410a6:	7f 23                	jg     410cb <keyboard_readc+0x1e6>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   410a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
   410ab:	8d 50 80             	lea    -0x80(%eax),%edx
   410ae:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   410b5:	0f b6 c0             	movzbl %al,%eax
   410b8:	83 e0 03             	and    $0x3,%eax
   410bb:	0f b6 84 90 c0 1e 04 	movzbl 0x41ec0(%eax,%edx,4),%eax
   410c2:	00 
   410c3:	0f b6 c0             	movzbl %al,%eax
   410c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
   410c9:	eb 1e                	jmp    410e9 <keyboard_readc+0x204>
    else if (ch < 0x80 && (modifiers & MOD_CONTROL))
   410cb:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
   410cf:	7f 18                	jg     410e9 <keyboard_readc+0x204>
   410d1:	0f b6 05 01 a0 04 00 	movzbl 0x4a001,%eax
   410d8:	0f b6 c0             	movzbl %al,%eax
   410db:	83 e0 02             	and    $0x2,%eax
   410de:	85 c0                	test   %eax,%eax
   410e0:	74 07                	je     410e9 <keyboard_readc+0x204>
        ch = 0;
   410e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)

    return ch;
   410e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
   410ec:	c9                   	leave  
   410ed:	c3                   	ret    

000410ee <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   410ee:	55                   	push   %ebp
   410ef:	89 e5                	mov    %esp,%ebp
   410f1:	83 ec 20             	sub    $0x20,%esp
   410f4:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%ebp)
    asm volatile("int3");
}

static inline uint8_t inb(int port) {
    uint8_t data;
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   410fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
   410fe:	89 c2                	mov    %eax,%edx
   41100:	ec                   	in     (%dx),%al
   41101:	88 45 fb             	mov    %al,-0x5(%ebp)
   41104:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%ebp)
   4110b:	8b 45 f4             	mov    -0xc(%ebp),%eax
   4110e:	89 c2                	mov    %eax,%edx
   41110:	ec                   	in     (%dx),%al
   41111:	88 45 f3             	mov    %al,-0xd(%ebp)
   41114:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%ebp)
   4111b:	8b 45 ec             	mov    -0x14(%ebp),%eax
   4111e:	89 c2                	mov    %eax,%edx
   41120:	ec                   	in     (%dx),%al
   41121:	88 45 eb             	mov    %al,-0x15(%ebp)
   41124:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%ebp)
   4112b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
   4112e:	89 c2                	mov    %eax,%edx
   41130:	ec                   	in     (%dx),%al
   41131:	88 45 e3             	mov    %al,-0x1d(%ebp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   41134:	c9                   	leave  
   41135:	c3                   	ret    

00041136 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   41136:	55                   	push   %ebp
   41137:	89 e5                	mov    %esp,%ebp
   41139:	83 ec 34             	sub    $0x34,%esp
   4113c:	8b 45 0c             	mov    0xc(%ebp),%eax
   4113f:	88 45 cc             	mov    %al,-0x34(%ebp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   41142:	a1 04 a0 04 00       	mov    0x4a004,%eax
   41147:	85 c0                	test   %eax,%eax
   41149:	75 1d                	jne    41168 <parallel_port_putc+0x32>
   4114b:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%ebp)
   41152:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
                 : "d" (port), "0" (addr), "1" (cnt)
                 : "memory", "cc");
}

static inline void outb(int port, uint8_t data) {
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41156:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
   4115a:	8b 55 f8             	mov    -0x8(%ebp),%edx
   4115d:	ee                   	out    %al,(%dx)
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   4115e:	c7 05 04 a0 04 00 01 	movl   $0x1,0x4a004
   41165:	00 00 00 
    }

    for (int i = 0;
   41168:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
   4116f:	eb 09                	jmp    4117a <parallel_port_putc+0x44>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i)
        delay();
   41171:	e8 78 ff ff ff       	call   410ee <delay>
        initialized = 1;
    }

    for (int i = 0;
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i)
   41176:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if (!initialized) {
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
    }

    for (int i = 0;
   4117a:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
   41181:	7f 18                	jg     4119b <parallel_port_putc+0x65>
   41183:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%ebp)
    asm volatile("int3");
}

static inline uint8_t inb(int port) {
    uint8_t data;
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4118a:	8b 45 f0             	mov    -0x10(%ebp),%eax
   4118d:	89 c2                	mov    %eax,%edx
   4118f:	ec                   	in     (%dx),%al
   41190:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
   41193:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   41197:	84 c0                	test   %al,%al
   41199:	79 d6                	jns    41171 <parallel_port_putc+0x3b>
         ++i)
        delay();
    outb(IO_PARALLEL1_DATA, c);
   4119b:	0f b6 45 cc          	movzbl -0x34(%ebp),%eax
   4119f:	c7 45 e8 78 03 00 00 	movl   $0x378,-0x18(%ebp)
   411a6:	88 45 e7             	mov    %al,-0x19(%ebp)
                 : "d" (port), "0" (addr), "1" (cnt)
                 : "memory", "cc");
}

static inline void outb(int port, uint8_t data) {
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   411a9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
   411ad:	8b 55 e8             	mov    -0x18(%ebp),%edx
   411b0:	ee                   	out    %al,(%dx)
   411b1:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%ebp)
   411b8:	c6 45 df 0d          	movb   $0xd,-0x21(%ebp)
   411bc:	0f b6 45 df          	movzbl -0x21(%ebp),%eax
   411c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
   411c3:	ee                   	out    %al,(%dx)
   411c4:	c7 45 d8 7a 03 00 00 	movl   $0x37a,-0x28(%ebp)
   411cb:	c6 45 d7 0c          	movb   $0xc,-0x29(%ebp)
   411cf:	0f b6 45 d7          	movzbl -0x29(%ebp),%eax
   411d3:	8b 55 d8             	mov    -0x28(%ebp),%edx
   411d6:	ee                   	out    %al,(%dx)
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   411d7:	c9                   	leave  
   411d8:	c3                   	ret    

000411d9 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   411d9:	55                   	push   %ebp
   411da:	89 e5                	mov    %esp,%ebp
   411dc:	83 ec 28             	sub    $0x28,%esp
    printer p;
    p.putc = parallel_port_putc;
   411df:	c7 45 f4 36 11 04 00 	movl   $0x41136,-0xc(%ebp)
    printer_vprintf(&p, 0, format, val);
   411e6:	8b 45 0c             	mov    0xc(%ebp),%eax
   411e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
   411ed:	8b 45 08             	mov    0x8(%ebp),%eax
   411f0:	89 44 24 08          	mov    %eax,0x8(%esp)
   411f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   411fb:	00 
   411fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
   411ff:	89 04 24             	mov    %eax,(%esp)
   41202:	e8 29 04 00 00       	call   41630 <printer_vprintf>
}
   41207:	c9                   	leave  
   41208:	c3                   	ret    

00041209 <log_printf>:

void log_printf(const char* format, ...) {
   41209:	55                   	push   %ebp
   4120a:	89 e5                	mov    %esp,%ebp
   4120c:	83 ec 28             	sub    $0x28,%esp
    va_list val;
    va_start(val, format);
   4120f:	8d 45 0c             	lea    0xc(%ebp),%eax
   41212:	89 45 f4             	mov    %eax,-0xc(%ebp)
    log_vprintf(format, val);
   41215:	8b 45 08             	mov    0x8(%ebp),%eax
   41218:	8b 55 f4             	mov    -0xc(%ebp),%edx
   4121b:	89 54 24 04          	mov    %edx,0x4(%esp)
   4121f:	89 04 24             	mov    %eax,(%esp)
   41222:	e8 b2 ff ff ff       	call   411d9 <log_vprintf>
    va_end(val);
}
   41227:	c9                   	leave  
   41228:	c3                   	ret    

00041229 <check_keyboard>:

// check_keyboard
//    Check for the user typing a control key. Control-C or 'q' exit the
//    virtual machine.

void check_keyboard(void) {
   41229:	55                   	push   %ebp
   4122a:	89 e5                	mov    %esp,%ebp
   4122c:	83 ec 18             	sub    $0x18,%esp
    int c = keyboard_readc();
   4122f:	e8 b1 fc ff ff       	call   40ee5 <keyboard_readc>
   41234:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (c == 0x03 || c == 'q')
   41237:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
   4123b:	74 06                	je     41243 <check_keyboard+0x1a>
   4123d:	83 7d f4 71          	cmpl   $0x71,-0xc(%ebp)
   41241:	75 05                	jne    41248 <check_keyboard+0x1f>
        poweroff();
   41243:	e8 12 fb ff ff       	call   40d5a <poweroff>
}
   41248:	c9                   	leave  
   41249:	c3                   	ret    

0004124a <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4124a:	55                   	push   %ebp
   4124b:	89 e5                	mov    %esp,%ebp
   4124d:	83 ec 08             	sub    $0x8,%esp
    while (1)
        check_keyboard();
   41250:	e8 d4 ff ff ff       	call   41229 <check_keyboard>
   41255:	eb f9                	jmp    41250 <fail+0x6>

00041257 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   41257:	55                   	push   %ebp
   41258:	89 e5                	mov    %esp,%ebp
   4125a:	83 ec 28             	sub    $0x28,%esp
    va_list val;
    va_start(val, format);
   4125d:	8d 45 0c             	lea    0xc(%ebp),%eax
   41260:	89 45 f0             	mov    %eax,-0x10(%ebp)

    // Print panic message to both the screen and the log
    int cpos = console_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   41263:	c7 44 24 08 18 1f 04 	movl   $0x41f18,0x8(%esp)
   4126a:	00 
   4126b:	c7 44 24 04 00 c0 00 	movl   $0xc000,0x4(%esp)
   41272:	00 
   41273:	c7 04 24 30 07 00 00 	movl   $0x730,(%esp)
   4127a:	e8 35 09 00 00       	call   41bb4 <console_printf>
   4127f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    log_printf("PANIC: ");
   41282:	c7 04 24 18 1f 04 00 	movl   $0x41f18,(%esp)
   41289:	e8 7b ff ff ff       	call   41209 <log_printf>

    cpos = console_vprintf(cpos, 0xC000, format, val);
   4128e:	8b 45 08             	mov    0x8(%ebp),%eax
   41291:	8b 55 f0             	mov    -0x10(%ebp),%edx
   41294:	89 54 24 0c          	mov    %edx,0xc(%esp)
   41298:	89 44 24 08          	mov    %eax,0x8(%esp)
   4129c:	c7 44 24 04 00 c0 00 	movl   $0xc000,0x4(%esp)
   412a3:	00 
   412a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
   412a7:	89 04 24             	mov    %eax,(%esp)
   412aa:	e8 b2 08 00 00       	call   41b61 <console_vprintf>
   412af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    log_vprintf(format, val);
   412b2:	8b 45 08             	mov    0x8(%ebp),%eax
   412b5:	8b 55 f0             	mov    -0x10(%ebp),%edx
   412b8:	89 54 24 04          	mov    %edx,0x4(%esp)
   412bc:	89 04 24             	mov    %eax,(%esp)
   412bf:	e8 15 ff ff ff       	call   411d9 <log_vprintf>

    if (CCOL(cpos)) {
   412c4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
   412c7:	ba 67 66 66 66       	mov    $0x66666667,%edx
   412cc:	89 c8                	mov    %ecx,%eax
   412ce:	f7 ea                	imul   %edx
   412d0:	c1 fa 05             	sar    $0x5,%edx
   412d3:	89 c8                	mov    %ecx,%eax
   412d5:	c1 f8 1f             	sar    $0x1f,%eax
   412d8:	29 c2                	sub    %eax,%edx
   412da:	89 d0                	mov    %edx,%eax
   412dc:	c1 e0 02             	shl    $0x2,%eax
   412df:	01 d0                	add    %edx,%eax
   412e1:	c1 e0 04             	shl    $0x4,%eax
   412e4:	29 c1                	sub    %eax,%ecx
   412e6:	89 ca                	mov    %ecx,%edx
   412e8:	85 d2                	test   %edx,%edx
   412ea:	74 2a                	je     41316 <panic+0xbf>
        cpos = console_printf(cpos, 0xC000, "\n");
   412ec:	c7 44 24 08 20 1f 04 	movl   $0x41f20,0x8(%esp)
   412f3:	00 
   412f4:	c7 44 24 04 00 c0 00 	movl   $0xc000,0x4(%esp)
   412fb:	00 
   412fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
   412ff:	89 04 24             	mov    %eax,(%esp)
   41302:	e8 ad 08 00 00       	call   41bb4 <console_printf>
   41307:	89 45 f4             	mov    %eax,-0xc(%ebp)
        log_printf("\n");
   4130a:	c7 04 24 20 1f 04 00 	movl   $0x41f20,(%esp)
   41311:	e8 f3 fe ff ff       	call   41209 <log_printf>
    }

    va_end(val);
    fail();
   41316:	e8 2f ff ff ff       	call   4124a <fail>

0004131b <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   4131b:	55                   	push   %ebp
   4131c:	89 e5                	mov    %esp,%ebp
   4131e:	83 ec 18             	sub    $0x18,%esp
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   41321:	8b 45 10             	mov    0x10(%ebp),%eax
   41324:	89 44 24 0c          	mov    %eax,0xc(%esp)
   41328:	8b 45 0c             	mov    0xc(%ebp),%eax
   4132b:	89 44 24 08          	mov    %eax,0x8(%esp)
   4132f:	8b 45 08             	mov    0x8(%ebp),%eax
   41332:	89 44 24 04          	mov    %eax,0x4(%esp)
   41336:	c7 04 24 22 1f 04 00 	movl   $0x41f22,(%esp)
   4133d:	e8 15 ff ff ff       	call   41257 <panic>

00041342 <program_load>:
// program_load(p, program_id)
//    Load the code corresponding to program `programnumber` into the process
//    `p` and set `p->p_registers.reg_eip` to its entry point.
//    Assumes memory for `p` is already allocated and mapped.
//    Returns 0 on success and -1 on failure (e.g. out-of-memory).
int program_load(proc* p, int program_id) {
   41342:	55                   	push   %ebp
   41343:	89 e5                	mov    %esp,%ebp
   41345:	83 ec 28             	sub    $0x28,%esp
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   41348:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    assert(program_id >= 0 && program_id < nprograms);
   4134f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
   41353:	78 08                	js     4135d <program_load+0x1b>
   41355:	8b 45 0c             	mov    0xc(%ebp),%eax
   41358:	3b 45 f0             	cmp    -0x10(%ebp),%eax
   4135b:	7c 1c                	jl     41379 <program_load+0x37>
   4135d:	c7 44 24 08 40 1f 04 	movl   $0x41f40,0x8(%esp)
   41364:	00 
   41365:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
   4136c:	00 
   4136d:	c7 04 24 6a 1f 04 00 	movl   $0x41f6a,(%esp)
   41374:	e8 a2 ff ff ff       	call   4131b <assert_fail>
    elf_header* eh = (elf_header*) ramimages[program_id].begin;
   41379:	8b 45 0c             	mov    0xc(%ebp),%eax
   4137c:	8b 04 c5 3c 30 04 00 	mov    0x4303c(,%eax,8),%eax
   41383:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(eh->e_magic == ELF_MAGIC);
   41386:	8b 45 ec             	mov    -0x14(%ebp),%eax
   41389:	8b 00                	mov    (%eax),%eax
   4138b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   41390:	74 1c                	je     413ae <program_load+0x6c>
   41392:	c7 44 24 08 75 1f 04 	movl   $0x41f75,0x8(%esp)
   41399:	00 
   4139a:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
   413a1:	00 
   413a2:	c7 04 24 6a 1f 04 00 	movl   $0x41f6a,(%esp)
   413a9:	e8 6d ff ff ff       	call   4131b <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   413ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
   413b1:	8b 50 1c             	mov    0x1c(%eax),%edx
   413b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
   413b7:	01 d0                	add    %edx,%eax
   413b9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int i = 0; i < eh->e_phnum; ++i)
   413bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   413c3:	eb 58                	jmp    4141d <program_load+0xdb>
        if (ph[i].p_type == ELF_PTYPE_LOAD)
   413c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
   413c8:	c1 e0 05             	shl    $0x5,%eax
   413cb:	89 c2                	mov    %eax,%edx
   413cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
   413d0:	01 d0                	add    %edx,%eax
   413d2:	8b 00                	mov    (%eax),%eax
   413d4:	83 f8 01             	cmp    $0x1,%eax
   413d7:	75 40                	jne    41419 <program_load+0xd7>
            if (copyseg(p, &ph[i], (const uint8_t*) eh + ph[i].p_offset) < 0)
   413d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
   413dc:	c1 e0 05             	shl    $0x5,%eax
   413df:	89 c2                	mov    %eax,%edx
   413e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
   413e4:	01 d0                	add    %edx,%eax
   413e6:	8b 50 04             	mov    0x4(%eax),%edx
   413e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
   413ec:	01 c2                	add    %eax,%edx
   413ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
   413f1:	c1 e0 05             	shl    $0x5,%eax
   413f4:	89 c1                	mov    %eax,%ecx
   413f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
   413f9:	01 c8                	add    %ecx,%eax
   413fb:	89 54 24 08          	mov    %edx,0x8(%esp)
   413ff:	89 44 24 04          	mov    %eax,0x4(%esp)
   41403:	8b 45 08             	mov    0x8(%ebp),%eax
   41406:	89 04 24             	mov    %eax,(%esp)
   41409:	e8 31 00 00 00       	call   4143f <copyseg>
   4140e:	85 c0                	test   %eax,%eax
   41410:	79 07                	jns    41419 <program_load+0xd7>
                return -1;
   41412:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41417:	eb 24                	jmp    4143d <program_load+0xfb>
    elf_header* eh = (elf_header*) ramimages[program_id].begin;
    assert(eh->e_magic == ELF_MAGIC);

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
    for (int i = 0; i < eh->e_phnum; ++i)
   41419:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
   4141d:	8b 45 ec             	mov    -0x14(%ebp),%eax
   41420:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
   41424:	0f b7 c0             	movzwl %ax,%eax
   41427:	3b 45 f4             	cmp    -0xc(%ebp),%eax
   4142a:	7f 99                	jg     413c5 <program_load+0x83>
        if (ph[i].p_type == ELF_PTYPE_LOAD)
            if (copyseg(p, &ph[i], (const uint8_t*) eh + ph[i].p_offset) < 0)
                return -1;

    // set the entry point from the ELF header
    p->p_registers.reg_eip = eh->e_entry;
   4142c:	8b 45 ec             	mov    -0x14(%ebp),%eax
   4142f:	8b 50 18             	mov    0x18(%eax),%edx
   41432:	8b 45 08             	mov    0x8(%ebp),%eax
   41435:	89 50 34             	mov    %edx,0x34(%eax)
    return 0;
   41438:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4143d:	c9                   	leave  
   4143e:	c3                   	ret    

0004143f <copyseg>:
// copyseg(p, ph, src)
//    Load an ELF segment at virtual address `ph->p_va` in process `p`. Copies
//    `[src, src + ph->p_filesz)` to `dst`, then clears
//    `[ph->p_va + ph->p_filesz, ph->p_va + ph->p_memsz)` to 0.
//    Returns 0 on success and -1 on failure.
static int copyseg(proc* p, const elf_program* ph, const uint8_t* src) {
   4143f:	55                   	push   %ebp
   41440:	89 e5                	mov    %esp,%ebp
   41442:	83 ec 28             	sub    $0x28,%esp
    uintptr_t va = (uintptr_t) ph->p_va;
   41445:	8b 45 0c             	mov    0xc(%ebp),%eax
   41448:	8b 40 08             	mov    0x8(%eax),%eax
   4144b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4144e:	8b 45 0c             	mov    0xc(%ebp),%eax
   41451:	8b 50 10             	mov    0x10(%eax),%edx
   41454:	8b 45 f4             	mov    -0xc(%ebp),%eax
   41457:	01 d0                	add    %edx,%eax
   41459:	89 45 f0             	mov    %eax,-0x10(%ebp)
   4145c:	8b 45 0c             	mov    0xc(%ebp),%eax
   4145f:	8b 50 14             	mov    0x14(%eax),%edx
   41462:	8b 45 f4             	mov    -0xc(%ebp),%eax
   41465:	01 d0                	add    %edx,%eax
   41467:	89 45 ec             	mov    %eax,-0x14(%ebp)
    va &= ~(PAGESIZE - 1);              // round to page boundary
   4146a:	81 65 f4 00 f0 ff ff 	andl   $0xfffff000,-0xc(%ebp)
    memcpy((uint8_t*) va, src, end_file - va);
   41471:	8b 45 f4             	mov    -0xc(%ebp),%eax
   41474:	8b 55 f0             	mov    -0x10(%ebp),%edx
   41477:	29 c2                	sub    %eax,%edx
   41479:	8b 45 f4             	mov    -0xc(%ebp),%eax
   4147c:	89 54 24 08          	mov    %edx,0x8(%esp)
   41480:	8b 55 10             	mov    0x10(%ebp),%edx
   41483:	89 54 24 04          	mov    %edx,0x4(%esp)
   41487:	89 04 24             	mov    %eax,(%esp)
   4148a:	e8 a6 00 00 00       	call   41535 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   4148f:	8b 45 f0             	mov    -0x10(%ebp),%eax
   41492:	8b 55 ec             	mov    -0x14(%ebp),%edx
   41495:	29 c2                	sub    %eax,%edx
   41497:	8b 45 f0             	mov    -0x10(%ebp),%eax
   4149a:	89 54 24 08          	mov    %edx,0x8(%esp)
   4149e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   414a5:	00 
   414a6:	89 04 24             	mov    %eax,(%esp)
   414a9:	e8 b2 00 00 00       	call   41560 <memset>
    return 0;
   414ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
   414b3:	c9                   	leave  
   414b4:	c3                   	ret    

000414b5 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   414b5:	55                   	push   %ebp
   414b6:	89 e5                	mov    %esp,%ebp
   414b8:	56                   	push   %esi
   414b9:	53                   	push   %ebx
   414ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
   414bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS)
   414c0:	81 79 04 a0 8f 0b 00 	cmpl   $0xb8fa0,0x4(%ecx)
   414c7:	72 07                	jb     414d0 <console_putc+0x1b>
        cp->cursor = console;
   414c9:	c7 41 04 00 80 0b 00 	movl   $0xb8000,0x4(%ecx)
    if (c == '\n') {
   414d0:	3c 0a                	cmp    $0xa,%al
   414d2:	75 4a                	jne    4151e <console_putc+0x69>
        int pos = (cp->cursor - console) % 80;
   414d4:	8b 71 04             	mov    0x4(%ecx),%esi
   414d7:	81 ee 00 80 0b 00    	sub    $0xb8000,%esi
   414dd:	89 f3                	mov    %esi,%ebx
   414df:	d1 fb                	sar    %ebx
   414e1:	ba 67 66 66 66       	mov    $0x66666667,%edx
   414e6:	89 d8                	mov    %ebx,%eax
   414e8:	f7 ea                	imul   %edx
   414ea:	c1 fa 05             	sar    $0x5,%edx
   414ed:	c1 fe 1f             	sar    $0x1f,%esi
   414f0:	29 f2                	sub    %esi,%edx
   414f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
   414f5:	c1 e0 04             	shl    $0x4,%eax
   414f8:	29 c3                	sub    %eax,%ebx
   414fa:	89 da                	mov    %ebx,%edx
        for (; pos != 80; pos++)
   414fc:	83 fb 50             	cmp    $0x50,%ebx
   414ff:	74 30                	je     41531 <console_putc+0x7c>
            *cp->cursor++ = ' ' | color;
   41501:	0f b7 75 10          	movzwl 0x10(%ebp),%esi
   41505:	83 ce 20             	or     $0x20,%esi
   41508:	8b 41 04             	mov    0x4(%ecx),%eax
   4150b:	8d 58 02             	lea    0x2(%eax),%ebx
   4150e:	89 59 04             	mov    %ebx,0x4(%ecx)
   41511:	66 89 30             	mov    %si,(%eax)
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS)
        cp->cursor = console;
    if (c == '\n') {
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++)
   41514:	83 c2 01             	add    $0x1,%edx
   41517:	83 fa 50             	cmp    $0x50,%edx
   4151a:	75 ec                	jne    41508 <console_putc+0x53>
   4151c:	eb 13                	jmp    41531 <console_putc+0x7c>
            *cp->cursor++ = ' ' | color;
    } else
        *cp->cursor++ = c | color;
   4151e:	8b 51 04             	mov    0x4(%ecx),%edx
   41521:	8d 5a 02             	lea    0x2(%edx),%ebx
   41524:	89 59 04             	mov    %ebx,0x4(%ecx)
   41527:	0f b6 c0             	movzbl %al,%eax
   4152a:	66 0b 45 10          	or     0x10(%ebp),%ax
   4152e:	66 89 02             	mov    %ax,(%edx)
}
   41531:	5b                   	pop    %ebx
   41532:	5e                   	pop    %esi
   41533:	5d                   	pop    %ebp
   41534:	c3                   	ret    

00041535 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   41535:	55                   	push   %ebp
   41536:	89 e5                	mov    %esp,%ebp
   41538:	56                   	push   %esi
   41539:	53                   	push   %ebx
   4153a:	8b 75 08             	mov    0x8(%ebp),%esi
   4153d:	8b 55 0c             	mov    0xc(%ebp),%edx
   41540:	8b 5d 10             	mov    0x10(%ebp),%ebx
    const char* s = (const char*) src;
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d)
   41543:	85 db                	test   %ebx,%ebx
   41545:	74 13                	je     4155a <memcpy+0x25>
   41547:	01 d3                	add    %edx,%ebx
   41549:	89 f1                	mov    %esi,%ecx
        *d = *s;
   4154b:	0f b6 02             	movzbl (%edx),%eax
   4154e:	88 01                	mov    %al,(%ecx)
// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
    const char* s = (const char*) src;
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d)
   41550:	83 c2 01             	add    $0x1,%edx
   41553:	83 c1 01             	add    $0x1,%ecx
   41556:	39 da                	cmp    %ebx,%edx
   41558:	75 f1                	jne    4154b <memcpy+0x16>
        *d = *s;
    return dst;
}
   4155a:	89 f0                	mov    %esi,%eax
   4155c:	5b                   	pop    %ebx
   4155d:	5e                   	pop    %esi
   4155e:	5d                   	pop    %ebp
   4155f:	c3                   	ret    

00041560 <memset>:
        while (n-- > 0)
            *d++ = *s++;
    return dst;
}

void* memset(void* v, int c, size_t n) {
   41560:	55                   	push   %ebp
   41561:	89 e5                	mov    %esp,%ebp
   41563:	53                   	push   %ebx
   41564:	8b 45 08             	mov    0x8(%ebp),%eax
   41567:	8b 4d 0c             	mov    0xc(%ebp),%ecx
   4156a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    for (char* p = (char*) v; n > 0; ++p, --n)
   4156d:	85 db                	test   %ebx,%ebx
   4156f:	74 0d                	je     4157e <memset+0x1e>
   41571:	01 c3                	add    %eax,%ebx
   41573:	89 c2                	mov    %eax,%edx
        *p = c;
   41575:	88 0a                	mov    %cl,(%edx)
            *d++ = *s++;
    return dst;
}

void* memset(void* v, int c, size_t n) {
    for (char* p = (char*) v; n > 0; ++p, --n)
   41577:	83 c2 01             	add    $0x1,%edx
   4157a:	39 da                	cmp    %ebx,%edx
   4157c:	75 f7                	jne    41575 <memset+0x15>
        *p = c;
    return v;
}
   4157e:	5b                   	pop    %ebx
   4157f:	5d                   	pop    %ebp
   41580:	c3                   	ret    

00041581 <strlen>:

size_t strlen(const char* s) {
   41581:	55                   	push   %ebp
   41582:	89 e5                	mov    %esp,%ebp
   41584:	8b 55 08             	mov    0x8(%ebp),%edx
    size_t n;
    for (n = 0; *s != '\0'; ++s)
   41587:	80 3a 00             	cmpb   $0x0,(%edx)
   4158a:	74 10                	je     4159c <strlen+0x1b>
   4158c:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   41591:	83 c0 01             	add    $0x1,%eax
    return v;
}

size_t strlen(const char* s) {
    size_t n;
    for (n = 0; *s != '\0'; ++s)
   41594:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
   41598:	75 f7                	jne    41591 <strlen+0x10>
   4159a:	eb 05                	jmp    415a1 <strlen+0x20>
   4159c:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
    return n;
}
   415a1:	5d                   	pop    %ebp
   415a2:	c3                   	ret    
   415a3:	66 90                	xchg   %ax,%ax
   415a5:	66 90                	xchg   %ax,%ax
   415a7:	66 90                	xchg   %ax,%ax
   415a9:	66 90                	xchg   %ax,%ax
   415ab:	66 90                	xchg   %ax,%ax
   415ad:	66 90                	xchg   %ax,%ax
   415af:	90                   	nop

000415b0 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   415b0:	55                   	push   %ebp
   415b1:	89 e5                	mov    %esp,%ebp
   415b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
   415b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s)
   415b9:	85 d2                	test   %edx,%edx
   415bb:	74 19                	je     415d6 <strnlen+0x26>
   415bd:	80 39 00             	cmpb   $0x0,(%ecx)
   415c0:	74 1b                	je     415dd <strnlen+0x2d>
   415c2:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   415c7:	83 c0 01             	add    $0x1,%eax
    return n;
}

size_t strnlen(const char* s, size_t maxlen) {
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s)
   415ca:	39 d0                	cmp    %edx,%eax
   415cc:	74 14                	je     415e2 <strnlen+0x32>
   415ce:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
   415d2:	75 f3                	jne    415c7 <strnlen+0x17>
   415d4:	eb 0c                	jmp    415e2 <strnlen+0x32>
   415d6:	b8 00 00 00 00       	mov    $0x0,%eax
   415db:	eb 05                	jmp    415e2 <strnlen+0x32>
   415dd:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
    return n;
}
   415e2:	5d                   	pop    %ebp
   415e3:	c3                   	ret    
   415e4:	66 90                	xchg   %ax,%ax
   415e6:	66 90                	xchg   %ax,%ax
   415e8:	66 90                	xchg   %ax,%ax
   415ea:	66 90                	xchg   %ax,%ax
   415ec:	66 90                	xchg   %ax,%ax
   415ee:	66 90                	xchg   %ax,%ax

000415f0 <strchr>:
        ++a, ++b;
    return ((unsigned char) *a > (unsigned char) *b)
        - ((unsigned char) *a < (unsigned char) *b);
}

char* strchr(const char* s, int c) {
   415f0:	55                   	push   %ebp
   415f1:	89 e5                	mov    %esp,%ebp
   415f3:	53                   	push   %ebx
   415f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
   415f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*s && *s != (char) c)
   415fa:	0f b6 11             	movzbl (%ecx),%edx
   415fd:	84 d2                	test   %dl,%dl
   415ff:	74 16                	je     41617 <strchr+0x27>
   41601:	89 d8                	mov    %ebx,%eax
   41603:	38 da                	cmp    %bl,%dl
   41605:	74 1b                	je     41622 <strchr+0x32>
        ++s;
   41607:	83 c1 01             	add    $0x1,%ecx
    return ((unsigned char) *a > (unsigned char) *b)
        - ((unsigned char) *a < (unsigned char) *b);
}

char* strchr(const char* s, int c) {
    while (*s && *s != (char) c)
   4160a:	0f b6 11             	movzbl (%ecx),%edx
   4160d:	84 d2                	test   %dl,%dl
   4160f:	74 06                	je     41617 <strchr+0x27>
   41611:	38 c2                	cmp    %al,%dl
   41613:	75 f2                	jne    41607 <strchr+0x17>
   41615:	eb 0b                	jmp    41622 <strchr+0x32>
        ++s;
    if (*s == (char) c)
        return (char*) s;
    else
        return NULL;
   41617:	b8 00 00 00 00       	mov    $0x0,%eax
}

char* strchr(const char* s, int c) {
    while (*s && *s != (char) c)
        ++s;
    if (*s == (char) c)
   4161c:	38 da                	cmp    %bl,%dl
   4161e:	66 90                	xchg   %ax,%ax
   41620:	75 02                	jne    41624 <strchr+0x34>
        return (char*) s;
   41622:	89 c8                	mov    %ecx,%eax
    else
        return NULL;
}
   41624:	5b                   	pop    %ebx
   41625:	5d                   	pop    %ebp
   41626:	c3                   	ret    
   41627:	66 90                	xchg   %ax,%ax
   41629:	66 90                	xchg   %ax,%ax
   4162b:	66 90                	xchg   %ax,%ax
   4162d:	66 90                	xchg   %ax,%ax
   4162f:	90                   	nop

00041630 <printer_vprintf>:
#define FLAG_LEFTJUSTIFY        (1<<2)
#define FLAG_SPACEPOSITIVE      (1<<3)
#define FLAG_PLUSPOSITIVE       (1<<4)
static const char flag_chars[] = "#0- +";

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   41630:	55                   	push   %ebp
   41631:	89 e5                	mov    %esp,%ebp
   41633:	57                   	push   %edi
   41634:	56                   	push   %esi
   41635:	53                   	push   %ebx
   41636:	83 ec 6c             	sub    $0x6c,%esp
   41639:	8b 7d 08             	mov    0x8(%ebp),%edi
   4163c:	8b 75 10             	mov    0x10(%ebp),%esi
   4163f:	8b 45 14             	mov    0x14(%ebp),%eax
   41642:	89 45 b0             	mov    %eax,-0x50(%ebp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   41645:	0f b6 06             	movzbl (%esi),%eax
   41648:	84 c0                	test   %al,%al
   4164a:	0f 84 09 05 00 00    	je     41b59 <printer_vprintf+0x529>
        base = -base;
    }

    *--numbuf_end = '\0';
    do {
        *--numbuf_end = digits[val % base];
   41650:	89 f3                	mov    %esi,%ebx
   41652:	89 fe                	mov    %edi,%esi
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
        if (*format != '%') {
   41654:	3c 25                	cmp    $0x25,%al
   41656:	74 1a                	je     41672 <printer_vprintf+0x42>
            p->putc(p, *format, color);
   41658:	8b 4d 0c             	mov    0xc(%ebp),%ecx
   4165b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
   4165f:	0f b6 c0             	movzbl %al,%eax
   41662:	89 44 24 04          	mov    %eax,0x4(%esp)
   41666:	89 34 24             	mov    %esi,(%esp)
   41669:	ff 16                	call   *(%esi)
            continue;
   4166b:	89 df                	mov    %ebx,%edi
   4166d:	e9 03 04 00 00       	jmp    41a75 <printer_vprintf+0x445>
        }

        // process flags
        int flags = 0;
        for (++format; *format; ++format) {
   41672:	8d 7b 01             	lea    0x1(%ebx),%edi
   41675:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
   41679:	84 db                	test   %bl,%bl
   4167b:	0f 84 08 04 00 00    	je     41a89 <printer_vprintf+0x459>
            p->putc(p, *format, color);
            continue;
        }

        // process flags
        int flags = 0;
   41681:	b8 00 00 00 00       	mov    $0x0,%eax
   41686:	89 75 08             	mov    %esi,0x8(%ebp)
   41689:	89 c6                	mov    %eax,%esi
        for (++format; *format; ++format) {
            const char* flagc = strchr(flag_chars, *format);
   4168b:	0f be c3             	movsbl %bl,%eax
   4168e:	89 44 24 04          	mov    %eax,0x4(%esp)
   41692:	c7 04 24 8a 20 04 00 	movl   $0x4208a,(%esp)
   41699:	e8 52 ff ff ff       	call   415f0 <strchr>
            if (flagc)
   4169e:	85 c0                	test   %eax,%eax
   416a0:	74 25                	je     416c7 <printer_vprintf+0x97>
                flags |= 1 << (flagc - flag_chars);
   416a2:	2d 8a 20 04 00       	sub    $0x4208a,%eax
   416a7:	89 c1                	mov    %eax,%ecx
   416a9:	b8 01 00 00 00       	mov    $0x1,%eax
   416ae:	d3 e0                	shl    %cl,%eax
   416b0:	09 c6                	or     %eax,%esi
            continue;
        }

        // process flags
        int flags = 0;
        for (++format; *format; ++format) {
   416b2:	83 c7 01             	add    $0x1,%edi
   416b5:	0f b6 1f             	movzbl (%edi),%ebx
   416b8:	84 db                	test   %bl,%bl
   416ba:	75 cf                	jne    4168b <printer_vprintf+0x5b>
   416bc:	89 75 c4             	mov    %esi,-0x3c(%ebp)
   416bf:	8b 75 08             	mov    0x8(%ebp),%esi
   416c2:	e9 c9 03 00 00       	jmp    41a90 <printer_vprintf+0x460>
   416c7:	89 75 c4             	mov    %esi,-0x3c(%ebp)
   416ca:	8b 75 08             	mov    0x8(%ebp),%esi
                break;
        }

        // process width
        int width = -1;
        if (*format >= '1' && *format <= '9') {
   416cd:	8d 43 cf             	lea    -0x31(%ebx),%eax
   416d0:	3c 08                	cmp    $0x8,%al
   416d2:	77 2d                	ja     41701 <printer_vprintf+0xd1>
            for (width = 0; *format >= '0' && *format <= '9'; )
   416d4:	0f b6 07             	movzbl (%edi),%eax
   416d7:	8d 50 d0             	lea    -0x30(%eax),%edx
   416da:	80 fa 09             	cmp    $0x9,%dl
   416dd:	77 41                	ja     41720 <printer_vprintf+0xf0>
   416df:	ba 00 00 00 00       	mov    $0x0,%edx
                width = 10 * width + *format++ - '0';
   416e4:	83 c7 01             	add    $0x1,%edi
   416e7:	8d 14 92             	lea    (%edx,%edx,4),%edx
   416ea:	0f be c0             	movsbl %al,%eax
   416ed:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
        }

        // process width
        int width = -1;
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
   416f1:	0f b6 07             	movzbl (%edi),%eax
   416f4:	8d 48 d0             	lea    -0x30(%eax),%ecx
   416f7:	80 f9 09             	cmp    $0x9,%cl
   416fa:	76 e8                	jbe    416e4 <printer_vprintf+0xb4>
   416fc:	89 55 c0             	mov    %edx,-0x40(%ebp)
   416ff:	eb 26                	jmp    41727 <printer_vprintf+0xf7>
            else
                break;
        }

        // process width
        int width = -1;
   41701:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
                width = 10 * width + *format++ - '0';
        } else if (*format == '*') {
   41708:	80 fb 2a             	cmp    $0x2a,%bl
   4170b:	75 1a                	jne    41727 <printer_vprintf+0xf7>
            width = va_arg(val, int);
   4170d:	8b 45 b0             	mov    -0x50(%ebp),%eax
   41710:	8b 08                	mov    (%eax),%ecx
   41712:	89 4d c0             	mov    %ecx,-0x40(%ebp)
            ++format;
   41715:	8d 7f 01             	lea    0x1(%edi),%edi
        int width = -1;
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
                width = 10 * width + *format++ - '0';
        } else if (*format == '*') {
            width = va_arg(val, int);
   41718:	8d 40 04             	lea    0x4(%eax),%eax
   4171b:	89 45 b0             	mov    %eax,-0x50(%ebp)
   4171e:	eb 07                	jmp    41727 <printer_vprintf+0xf7>
        }

        // process width
        int width = -1;
        if (*format >= '1' && *format <= '9') {
            for (width = 0; *format >= '0' && *format <= '9'; )
   41720:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
            width = va_arg(val, int);
            ++format;
        }

        // process precision
        int precision = -1;
   41727:	c7 45 b8 ff ff ff ff 	movl   $0xffffffff,-0x48(%ebp)
        if (*format == '.') {
   4172e:	80 3f 2e             	cmpb   $0x2e,(%edi)
   41731:	75 58                	jne    4178b <printer_vprintf+0x15b>
            ++format;
   41733:	8d 4f 01             	lea    0x1(%edi),%ecx
            if (*format >= '0' && *format <= '9') {
   41736:	0f b6 57 01          	movzbl 0x1(%edi),%edx
   4173a:	8d 42 d0             	lea    -0x30(%edx),%eax
   4173d:	3c 09                	cmp    $0x9,%al
   4173f:	77 21                	ja     41762 <printer_vprintf+0x132>
   41741:	89 cf                	mov    %ecx,%edi
   41743:	b8 00 00 00 00       	mov    $0x0,%eax
                for (precision = 0; *format >= '0' && *format <= '9'; )
                    precision = 10 * precision + *format++ - '0';
   41748:	83 c7 01             	add    $0x1,%edi
   4174b:	8d 04 80             	lea    (%eax,%eax,4),%eax
   4174e:	0f be d2             	movsbl %dl,%edx
   41751:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
        // process precision
        int precision = -1;
        if (*format == '.') {
            ++format;
            if (*format >= '0' && *format <= '9') {
                for (precision = 0; *format >= '0' && *format <= '9'; )
   41755:	0f b6 17             	movzbl (%edi),%edx
   41758:	8d 4a d0             	lea    -0x30(%edx),%ecx
   4175b:	80 f9 09             	cmp    $0x9,%cl
   4175e:	76 e8                	jbe    41748 <printer_vprintf+0x118>
   41760:	eb 1c                	jmp    4177e <printer_vprintf+0x14e>
                    precision = 10 * precision + *format++ - '0';
            } else if (*format == '*') {
   41762:	80 fa 2a             	cmp    $0x2a,%dl
   41765:	75 10                	jne    41777 <printer_vprintf+0x147>
                precision = va_arg(val, int);
   41767:	8b 4d b0             	mov    -0x50(%ebp),%ecx
   4176a:	8b 01                	mov    (%ecx),%eax
                ++format;
   4176c:	83 c7 02             	add    $0x2,%edi
            ++format;
            if (*format >= '0' && *format <= '9') {
                for (precision = 0; *format >= '0' && *format <= '9'; )
                    precision = 10 * precision + *format++ - '0';
            } else if (*format == '*') {
                precision = va_arg(val, int);
   4176f:	8d 49 04             	lea    0x4(%ecx),%ecx
   41772:	89 4d b0             	mov    %ecx,-0x50(%ebp)
   41775:	eb 07                	jmp    4177e <printer_vprintf+0x14e>
        }

        // process precision
        int precision = -1;
        if (*format == '.') {
            ++format;
   41777:	89 cf                	mov    %ecx,%edi
            width = va_arg(val, int);
            ++format;
        }

        // process precision
        int precision = -1;
   41779:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4177e:	85 c0                	test   %eax,%eax
   41780:	ba 00 00 00 00       	mov    $0x0,%edx
   41785:	0f 49 d0             	cmovns %eax,%edx
   41788:	89 55 b8             	mov    %edx,-0x48(%ebp)
        // process main conversion character
        int negative = 0;
        int numeric = 0;
        int base = 10;
        char* data;
        switch (*format) {
   4178b:	0f b6 17             	movzbl (%edi),%edx
   4178e:	8d 42 bd             	lea    -0x43(%edx),%eax
   41791:	3c 35                	cmp    $0x35,%al
   41793:	0f 87 15 01 00 00    	ja     418ae <printer_vprintf+0x27e>
   41799:	0f b6 c0             	movzbl %al,%eax
   4179c:	ff 24 85 90 1f 04 00 	jmp    *0x41f90(,%eax,4)
        case 'd': {
            int x = va_arg(val, int);
   417a3:	8b 45 b0             	mov    -0x50(%ebp),%eax
   417a6:	8d 48 04             	lea    0x4(%eax),%ecx
   417a9:	89 4d bc             	mov    %ecx,-0x44(%ebp)
   417ac:	8b 00                	mov    (%eax),%eax
   417ae:	89 c1                	mov    %eax,%ecx
   417b0:	89 45 b4             	mov    %eax,-0x4c(%ebp)
            data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10);
   417b3:	c1 f8 1f             	sar    $0x1f,%eax
   417b6:	31 c1                	xor    %eax,%ecx
   417b8:	29 c1                	sub    %eax,%ecx
    if (base < 0) {
        digits = lower_digits;
        base = -base;
    }

    *--numbuf_end = '\0';
   417ba:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
   417be:	8d 5d e7             	lea    -0x19(%ebp),%ebx
    do {
        *--numbuf_end = digits[val % base];
   417c1:	83 eb 01             	sub    $0x1,%ebx
   417c4:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
   417c9:	f7 e1                	mul    %ecx
   417cb:	c1 ea 03             	shr    $0x3,%edx
   417ce:	8d 04 92             	lea    (%edx,%edx,4),%eax
   417d1:	01 c0                	add    %eax,%eax
   417d3:	29 c1                	sub    %eax,%ecx
   417d5:	0f b6 81 79 20 04 00 	movzbl 0x42079(%ecx),%eax
   417dc:	88 03                	mov    %al,(%ebx)
        val /= base;
   417de:	89 d1                	mov    %edx,%ecx
    } while (val != 0);
   417e0:	85 d2                	test   %edx,%edx
   417e2:	75 dd                	jne    417c1 <printer_vprintf+0x191>
        switch (*format) {
        case 'd': {
            int x = va_arg(val, int);
            data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10);
            if (x < 0)
                negative = 1;
   417e4:	8b 45 b4             	mov    -0x4c(%ebp),%eax
   417e7:	c1 e8 1f             	shr    $0x1f,%eax
   417ea:	89 45 ac             	mov    %eax,-0x54(%ebp)
        int numeric = 0;
        int base = 10;
        char* data;
        switch (*format) {
        case 'd': {
            int x = va_arg(val, int);
   417ed:	8b 45 bc             	mov    -0x44(%ebp),%eax
   417f0:	89 45 b0             	mov    %eax,-0x50(%ebp)
   417f3:	e9 04 03 00 00       	jmp    41afc <printer_vprintf+0x4cc>
            numeric = 1;
            break;
        }
        case 'u':
        print_unsigned: {
            unsigned x = va_arg(val, unsigned);
   417f8:	8b 45 b0             	mov    -0x50(%ebp),%eax
   417fb:	8b 10                	mov    (%eax),%edx
   417fd:	8d 40 04             	lea    0x4(%eax),%eax
   41800:	89 45 b0             	mov    %eax,-0x50(%ebp)

static char* fill_numbuf(char* numbuf_end, uint32_t val, int base) {
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   41803:	b9 79 20 04 00       	mov    $0x42079,%ecx
        }

        // process main conversion character
        int negative = 0;
        int numeric = 0;
        int base = 10;
   41808:	b8 0a 00 00 00       	mov    $0xa,%eax
    if (base < 0) {
        digits = lower_digits;
        base = -base;
    }

    *--numbuf_end = '\0';
   4180d:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
   41811:	8d 5d e7             	lea    -0x19(%ebp),%ebx
   41814:	89 75 08             	mov    %esi,0x8(%ebp)
   41817:	89 c6                	mov    %eax,%esi
    do {
        *--numbuf_end = digits[val % base];
   41819:	83 eb 01             	sub    $0x1,%ebx
   4181c:	89 d0                	mov    %edx,%eax
   4181e:	ba 00 00 00 00       	mov    $0x0,%edx
   41823:	f7 f6                	div    %esi
   41825:	0f b6 14 11          	movzbl (%ecx,%edx,1),%edx
   41829:	88 13                	mov    %dl,(%ebx)
        val /= base;
   4182b:	89 c2                	mov    %eax,%edx
    } while (val != 0);
   4182d:	85 c0                	test   %eax,%eax
   4182f:	75 e8                	jne    41819 <printer_vprintf+0x1e9>
   41831:	e9 bc 02 00 00       	jmp    41af2 <printer_vprintf+0x4c2>
            goto print_unsigned;
        case 'X':
            base = 16;
            goto print_unsigned;
        case 'p': {
            void* x = va_arg(val, void*);
   41836:	8b 45 b0             	mov    -0x50(%ebp),%eax
   41839:	8d 48 04             	lea    0x4(%eax),%ecx
   4183c:	89 4d bc             	mov    %ecx,-0x44(%ebp)
            data = fill_numbuf(numbuf + NUMBUFSIZ, (uintptr_t) x, -16);
   4183f:	8b 10                	mov    (%eax),%edx
    if (base < 0) {
        digits = lower_digits;
        base = -base;
    }

    *--numbuf_end = '\0';
   41841:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
   41845:	8d 45 e7             	lea    -0x19(%ebp),%eax
    do {
        *--numbuf_end = digits[val % base];
   41848:	83 e8 01             	sub    $0x1,%eax
   4184b:	89 d1                	mov    %edx,%ecx
   4184d:	83 e1 0f             	and    $0xf,%ecx
   41850:	0f b6 89 68 20 04 00 	movzbl 0x42068(%ecx),%ecx
   41857:	88 08                	mov    %cl,(%eax)
        val /= base;
   41859:	89 d1                	mov    %edx,%ecx
   4185b:	c1 e9 04             	shr    $0x4,%ecx
   4185e:	89 ca                	mov    %ecx,%edx
    } while (val != 0);
   41860:	85 c9                	test   %ecx,%ecx
   41862:	75 e4                	jne    41848 <printer_vprintf+0x218>
            base = 16;
            goto print_unsigned;
        case 'p': {
            void* x = va_arg(val, void*);
            data = fill_numbuf(numbuf + NUMBUFSIZ, (uintptr_t) x, -16);
            data[-1] = 'x';
   41864:	c6 40 ff 78          	movb   $0x78,-0x1(%eax)
            data[-2] = '0';
   41868:	c6 40 fe 30          	movb   $0x30,-0x2(%eax)
            data -= 2;
   4186c:	8d 58 fe             	lea    -0x2(%eax),%ebx
            goto print_unsigned;
        case 'X':
            base = 16;
            goto print_unsigned;
        case 'p': {
            void* x = va_arg(val, void*);
   4186f:	8b 45 bc             	mov    -0x44(%ebp),%eax
   41872:	89 45 b0             	mov    %eax,-0x50(%ebp)
            data = fill_numbuf(numbuf + NUMBUFSIZ, (uintptr_t) x, -16);
            data[-1] = 'x';
            data[-2] = '0';
            data -= 2;
            break;
   41875:	eb 44                	jmp    418bb <printer_vprintf+0x28b>
        }
        case 's':
            data = va_arg(val, char*);
   41877:	8b 45 b0             	mov    -0x50(%ebp),%eax
   4187a:	8b 18                	mov    (%eax),%ebx
   4187c:	8d 40 04             	lea    0x4(%eax),%eax
   4187f:	89 45 b0             	mov    %eax,-0x50(%ebp)
            break;
   41882:	eb 37                	jmp    418bb <printer_vprintf+0x28b>
        case 'C':
            color = va_arg(val, int);
   41884:	8b 45 b0             	mov    -0x50(%ebp),%eax
   41887:	8b 08                	mov    (%eax),%ecx
   41889:	89 4d 0c             	mov    %ecx,0xc(%ebp)
   4188c:	8d 40 04             	lea    0x4(%eax),%eax
   4188f:	89 45 b0             	mov    %eax,-0x50(%ebp)
            goto done;
   41892:	e9 de 01 00 00       	jmp    41a75 <printer_vprintf+0x445>
        case 'c':
            data = numbuf;
            numbuf[0] = va_arg(val, int);
   41897:	8b 4d b0             	mov    -0x50(%ebp),%ecx
   4189a:	8b 01                	mov    (%ecx),%eax
   4189c:	88 45 d0             	mov    %al,-0x30(%ebp)
            numbuf[1] = '\0';
   4189f:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
        case 'C':
            color = va_arg(val, int);
            goto done;
        case 'c':
            data = numbuf;
            numbuf[0] = va_arg(val, int);
   418a3:	8d 41 04             	lea    0x4(%ecx),%eax
   418a6:	89 45 b0             	mov    %eax,-0x50(%ebp)
            break;
        case 'C':
            color = va_arg(val, int);
            goto done;
        case 'c':
            data = numbuf;
   418a9:	8d 5d d0             	lea    -0x30(%ebp),%ebx
            numbuf[0] = va_arg(val, int);
            numbuf[1] = '\0';
            break;
   418ac:	eb 0d                	jmp    418bb <printer_vprintf+0x28b>
        normal:
        default:
            data = numbuf;
            numbuf[0] = (*format ? *format : '%');
   418ae:	84 d2                	test   %dl,%dl
   418b0:	0f 85 2d 02 00 00    	jne    41ae3 <printer_vprintf+0x4b3>
   418b6:	e9 15 02 00 00       	jmp    41ad0 <printer_vprintf+0x4a0>
                format--;
            break;
        }

        int len;
        if (precision >= 0 && !numeric)
   418bb:	8b 4d b8             	mov    -0x48(%ebp),%ecx
   418be:	89 c8                	mov    %ecx,%eax
   418c0:	f7 d0                	not    %eax
   418c2:	c1 e8 1f             	shr    $0x1f,%eax
   418c5:	88 45 98             	mov    %al,-0x68(%ebp)
   418c8:	84 c0                	test   %al,%al
   418ca:	74 16                	je     418e2 <printer_vprintf+0x2b2>
            len = strnlen(data, precision);
   418cc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
   418d0:	89 1c 24             	mov    %ebx,(%esp)
   418d3:	e8 d8 fc ff ff       	call   415b0 <strnlen>
   418d8:	89 45 bc             	mov    %eax,-0x44(%ebp)
        else
            len = strlen(data);
        if (numeric && negative)
   418db:	ba 00 00 00 00       	mov    $0x0,%edx
   418e0:	eb 27                	jmp    41909 <printer_vprintf+0x2d9>
   418e2:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
   418e9:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)

        int len;
        if (precision >= 0 && !numeric)
            len = strnlen(data, precision);
        else
            len = strlen(data);
   418f0:	89 1c 24             	mov    %ebx,(%esp)
   418f3:	e8 89 fc ff ff       	call   41581 <strlen>
   418f8:	89 45 bc             	mov    %eax,-0x44(%ebp)
        if (numeric && negative)
   418fb:	0f b6 55 b4          	movzbl -0x4c(%ebp),%edx
   418ff:	83 7d ac 00          	cmpl   $0x0,-0x54(%ebp)
   41903:	74 04                	je     41909 <printer_vprintf+0x2d9>
   41905:	84 d2                	test   %dl,%dl
   41907:	75 24                	jne    4192d <printer_vprintf+0x2fd>
            negative = '-';
        else if (flags & FLAG_PLUSPOSITIVE)
            negative = '+';
   41909:	c7 45 b4 2b 00 00 00 	movl   $0x2b,-0x4c(%ebp)
            len = strnlen(data, precision);
        else
            len = strlen(data);
        if (numeric && negative)
            negative = '-';
        else if (flags & FLAG_PLUSPOSITIVE)
   41910:	f6 45 c4 10          	testb  $0x10,-0x3c(%ebp)
   41914:	75 1e                	jne    41934 <printer_vprintf+0x304>
            negative = '+';
        else if (flags & FLAG_SPACEPOSITIVE)
   41916:	8b 45 c4             	mov    -0x3c(%ebp),%eax
   41919:	83 e0 08             	and    $0x8,%eax
            negative = ' ';
   4191c:	83 f8 01             	cmp    $0x1,%eax
   4191f:	19 c0                	sbb    %eax,%eax
   41921:	89 45 b4             	mov    %eax,-0x4c(%ebp)
   41924:	f7 55 b4             	notl   -0x4c(%ebp)
   41927:	83 65 b4 20          	andl   $0x20,-0x4c(%ebp)
   4192b:	eb 07                	jmp    41934 <printer_vprintf+0x304>
        if (precision >= 0 && !numeric)
            len = strnlen(data, precision);
        else
            len = strlen(data);
        if (numeric && negative)
            negative = '-';
   4192d:	c7 45 b4 2d 00 00 00 	movl   $0x2d,-0x4c(%ebp)
        else if (flags & FLAG_SPACEPOSITIVE)
            negative = ' ';
        else
            negative = 0;
        int zeros;
        if (numeric && precision >= 0)
   41934:	84 d2                	test   %dl,%dl
   41936:	74 1f                	je     41957 <printer_vprintf+0x327>
   41938:	80 7d 98 00          	cmpb   $0x0,-0x68(%ebp)
   4193c:	74 19                	je     41957 <printer_vprintf+0x327>
            zeros = precision > len ? precision - len : 0;
   4193e:	8b 45 b8             	mov    -0x48(%ebp),%eax
   41941:	89 c2                	mov    %eax,%edx
   41943:	8b 4d bc             	mov    -0x44(%ebp),%ecx
   41946:	29 ca                	sub    %ecx,%edx
   41948:	39 c8                	cmp    %ecx,%eax
   4194a:	b8 00 00 00 00       	mov    $0x0,%eax
   4194f:	0f 4f c2             	cmovg  %edx,%eax
   41952:	89 45 b8             	mov    %eax,-0x48(%ebp)
   41955:	eb 35                	jmp    4198c <printer_vprintf+0x35c>
        else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
   41957:	8b 45 c4             	mov    -0x3c(%ebp),%eax
   4195a:	83 e0 06             	and    $0x6,%eax
                 && numeric && len + !!negative < width)
            zeros = width - len - !!negative;
        else
            zeros = 0;
   4195d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
        else
            negative = 0;
        int zeros;
        if (numeric && precision >= 0)
            zeros = precision > len ? precision - len : 0;
        else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
   41964:	83 f8 02             	cmp    $0x2,%eax
   41967:	75 23                	jne    4198c <printer_vprintf+0x35c>
                 && numeric && len + !!negative < width)
   41969:	84 d2                	test   %dl,%dl
   4196b:	74 1f                	je     4198c <printer_vprintf+0x35c>
   4196d:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
   41971:	0f 95 c0             	setne  %al
   41974:	0f b6 c0             	movzbl %al,%eax
   41977:	8b 4d bc             	mov    -0x44(%ebp),%ecx
   4197a:	8d 14 08             	lea    (%eax,%ecx,1),%edx
   4197d:	39 55 c0             	cmp    %edx,-0x40(%ebp)
   41980:	7e 0a                	jle    4198c <printer_vprintf+0x35c>
            zeros = width - len - !!negative;
   41982:	8b 55 c0             	mov    -0x40(%ebp),%edx
   41985:	29 ca                	sub    %ecx,%edx
   41987:	29 c2                	sub    %eax,%edx
   41989:	89 55 b8             	mov    %edx,-0x48(%ebp)
        else
            zeros = 0;
        width -= len + zeros + !!negative;
   4198c:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
   41990:	0f 95 c0             	setne  %al
   41993:	88 45 98             	mov    %al,-0x68(%ebp)
   41996:	8b 55 bc             	mov    -0x44(%ebp),%edx
   41999:	03 55 b8             	add    -0x48(%ebp),%edx
   4199c:	0f b6 c0             	movzbl %al,%eax
   4199f:	01 d0                	add    %edx,%eax
   419a1:	8b 4d c0             	mov    -0x40(%ebp),%ecx
   419a4:	29 c1                	sub    %eax,%ecx
   419a6:	89 4d c0             	mov    %ecx,-0x40(%ebp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
   419a9:	f6 45 c4 04          	testb  $0x4,-0x3c(%ebp)
   419ad:	75 2b                	jne    419da <printer_vprintf+0x3aa>
   419af:	85 c9                	test   %ecx,%ecx
   419b1:	0f 8f 75 01 00 00    	jg     41b2c <printer_vprintf+0x4fc>
   419b7:	eb 21                	jmp    419da <printer_vprintf+0x3aa>
   419b9:	85 db                	test   %ebx,%ebx
   419bb:	90                   	nop
   419bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
   419c0:	0f 85 4d 01 00 00    	jne    41b13 <printer_vprintf+0x4e3>
   419c6:	8b 7d ac             	mov    -0x54(%ebp),%edi
   419c9:	8b 5d a8             	mov    -0x58(%ebp),%ebx
   419cc:	b8 01 00 00 00       	mov    $0x1,%eax
   419d1:	2b 45 c0             	sub    -0x40(%ebp),%eax
   419d4:	03 45 c4             	add    -0x3c(%ebp),%eax
   419d7:	89 45 c0             	mov    %eax,-0x40(%ebp)
            p->putc(p, ' ', color);
        if (negative)
   419da:	80 7d 98 00          	cmpb   $0x0,-0x68(%ebp)
   419de:	74 14                	je     419f4 <printer_vprintf+0x3c4>
            p->putc(p, negative, color);
   419e0:	8b 45 0c             	mov    0xc(%ebp),%eax
   419e3:	89 44 24 08          	mov    %eax,0x8(%esp)
   419e7:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
   419eb:	89 44 24 04          	mov    %eax,0x4(%esp)
   419ef:	89 34 24             	mov    %esi,(%esp)
   419f2:	ff 16                	call   *(%esi)
        for (; zeros > 0; --zeros)
   419f4:	8b 45 b8             	mov    -0x48(%ebp),%eax
   419f7:	85 c0                	test   %eax,%eax
   419f9:	7e 27                	jle    41a22 <printer_vprintf+0x3f2>
   419fb:	89 7d c4             	mov    %edi,-0x3c(%ebp)
   419fe:	89 5d b8             	mov    %ebx,-0x48(%ebp)
   41a01:	89 c3                	mov    %eax,%ebx
   41a03:	8b 7d 0c             	mov    0xc(%ebp),%edi
            p->putc(p, '0', color);
   41a06:	89 7c 24 08          	mov    %edi,0x8(%esp)
   41a0a:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
   41a11:	00 
   41a12:	89 34 24             	mov    %esi,(%esp)
   41a15:	ff 16                	call   *(%esi)
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
            p->putc(p, ' ', color);
        if (negative)
            p->putc(p, negative, color);
        for (; zeros > 0; --zeros)
   41a17:	83 eb 01             	sub    $0x1,%ebx
   41a1a:	75 ea                	jne    41a06 <printer_vprintf+0x3d6>
   41a1c:	8b 7d c4             	mov    -0x3c(%ebp),%edi
   41a1f:	8b 5d b8             	mov    -0x48(%ebp),%ebx
            p->putc(p, '0', color);
        for (; len > 0; ++data, --len)
   41a22:	8b 45 bc             	mov    -0x44(%ebp),%eax
   41a25:	85 c0                	test   %eax,%eax
   41a27:	7e 26                	jle    41a4f <printer_vprintf+0x41f>
   41a29:	01 d8                	add    %ebx,%eax
   41a2b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
   41a2e:	89 7d bc             	mov    %edi,-0x44(%ebp)
   41a31:	8b 7d 0c             	mov    0xc(%ebp),%edi
            p->putc(p, *data, color);
   41a34:	89 7c 24 08          	mov    %edi,0x8(%esp)
   41a38:	0f b6 03             	movzbl (%ebx),%eax
   41a3b:	89 44 24 04          	mov    %eax,0x4(%esp)
   41a3f:	89 34 24             	mov    %esi,(%esp)
   41a42:	ff 16                	call   *(%esi)
            p->putc(p, ' ', color);
        if (negative)
            p->putc(p, negative, color);
        for (; zeros > 0; --zeros)
            p->putc(p, '0', color);
        for (; len > 0; ++data, --len)
   41a44:	83 c3 01             	add    $0x1,%ebx
   41a47:	3b 5d c4             	cmp    -0x3c(%ebp),%ebx
   41a4a:	75 e8                	jne    41a34 <printer_vprintf+0x404>
   41a4c:	8b 7d bc             	mov    -0x44(%ebp),%edi
            p->putc(p, *data, color);
        for (; width > 0; --width)
   41a4f:	8b 5d c0             	mov    -0x40(%ebp),%ebx
   41a52:	85 db                	test   %ebx,%ebx
   41a54:	7e 1f                	jle    41a75 <printer_vprintf+0x445>
   41a56:	89 7d c4             	mov    %edi,-0x3c(%ebp)
   41a59:	8b 7d 0c             	mov    0xc(%ebp),%edi
            p->putc(p, ' ', color);
   41a5c:	89 7c 24 08          	mov    %edi,0x8(%esp)
   41a60:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
   41a67:	00 
   41a68:	89 34 24             	mov    %esi,(%esp)
   41a6b:	ff 16                	call   *(%esi)
            p->putc(p, negative, color);
        for (; zeros > 0; --zeros)
            p->putc(p, '0', color);
        for (; len > 0; ++data, --len)
            p->putc(p, *data, color);
        for (; width > 0; --width)
   41a6d:	83 eb 01             	sub    $0x1,%ebx
   41a70:	75 ea                	jne    41a5c <printer_vprintf+0x42c>
   41a72:	8b 7d c4             	mov    -0x3c(%ebp),%edi

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   41a75:	8d 5f 01             	lea    0x1(%edi),%ebx
   41a78:	0f b6 47 01          	movzbl 0x1(%edi),%eax
   41a7c:	84 c0                	test   %al,%al
   41a7e:	0f 85 d0 fb ff ff    	jne    41654 <printer_vprintf+0x24>
   41a84:	e9 d0 00 00 00       	jmp    41b59 <printer_vprintf+0x529>
            p->putc(p, *format, color);
            continue;
        }

        // process flags
        int flags = 0;
   41a89:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
            else
                break;
        }

        // process width
        int width = -1;
   41a90:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
   41a97:	e9 8b fc ff ff       	jmp    41727 <printer_vprintf+0xf7>
            numeric = 1;
            break;
        }
        case 'u':
        print_unsigned: {
            unsigned x = va_arg(val, unsigned);
   41a9c:	8b 45 b0             	mov    -0x50(%ebp),%eax
   41a9f:	8b 10                	mov    (%eax),%edx
   41aa1:	8d 40 04             	lea    0x4(%eax),%eax
   41aa4:	89 45 b0             	mov    %eax,-0x50(%ebp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
    if (base < 0) {
        digits = lower_digits;
   41aa7:	b9 68 20 04 00       	mov    $0x42068,%ecx
        base = -base;
   41aac:	b8 10 00 00 00       	mov    $0x10,%eax
   41ab1:	e9 57 fd ff ff       	jmp    4180d <printer_vprintf+0x1dd>
            numeric = 1;
            break;
        }
        case 'u':
        print_unsigned: {
            unsigned x = va_arg(val, unsigned);
   41ab6:	8b 45 b0             	mov    -0x50(%ebp),%eax
   41ab9:	8b 10                	mov    (%eax),%edx
   41abb:	8d 40 04             	lea    0x4(%eax),%eax
   41abe:	89 45 b0             	mov    %eax,-0x50(%ebp)

static char* fill_numbuf(char* numbuf_end, uint32_t val, int base) {
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   41ac1:	b9 79 20 04 00       	mov    $0x42079,%ecx
        }
        case 'x':
            base = -16;
            goto print_unsigned;
        case 'X':
            base = 16;
   41ac6:	b8 10 00 00 00       	mov    $0x10,%eax
   41acb:	e9 3d fd ff ff       	jmp    4180d <printer_vprintf+0x1dd>
            numbuf[1] = '\0';
            break;
        normal:
        default:
            data = numbuf;
            numbuf[0] = (*format ? *format : '%');
   41ad0:	c6 45 d0 25          	movb   $0x25,-0x30(%ebp)
            numbuf[1] = '\0';
   41ad4:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
            if (!*format)
                format--;
   41ad8:	83 ef 01             	sub    $0x1,%edi
            numbuf[0] = va_arg(val, int);
            numbuf[1] = '\0';
            break;
        normal:
        default:
            data = numbuf;
   41adb:	8d 5d d0             	lea    -0x30(%ebp),%ebx
   41ade:	e9 d8 fd ff ff       	jmp    418bb <printer_vprintf+0x28b>
            numbuf[0] = (*format ? *format : '%');
   41ae3:	88 55 d0             	mov    %dl,-0x30(%ebp)
            numbuf[1] = '\0';
   41ae6:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
            numbuf[0] = va_arg(val, int);
            numbuf[1] = '\0';
            break;
        normal:
        default:
            data = numbuf;
   41aea:	8d 5d d0             	lea    -0x30(%ebp),%ebx
   41aed:	e9 c9 fd ff ff       	jmp    418bb <printer_vprintf+0x28b>
   41af2:	8b 75 08             	mov    0x8(%ebp),%esi
            if (precision < 0)
                precision = 0;
        }

        // process main conversion character
        int negative = 0;
   41af5:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)
                format--;
            break;
        }

        int len;
        if (precision >= 0 && !numeric)
   41afc:	8b 45 b8             	mov    -0x48(%ebp),%eax
   41aff:	f7 d0                	not    %eax
   41b01:	c1 e8 1f             	shr    $0x1f,%eax
   41b04:	89 45 98             	mov    %eax,-0x68(%ebp)
   41b07:	c7 45 b4 01 00 00 00 	movl   $0x1,-0x4c(%ebp)
   41b0e:	e9 dd fd ff ff       	jmp    418f0 <printer_vprintf+0x2c0>
            zeros = width - len - !!negative;
        else
            zeros = 0;
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
            p->putc(p, ' ', color);
   41b13:	89 7c 24 08          	mov    %edi,0x8(%esp)
   41b17:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
   41b1e:	00 
   41b1f:	89 34 24             	mov    %esi,(%esp)
   41b22:	ff 16                	call   *(%esi)
                 && numeric && len + !!negative < width)
            zeros = width - len - !!negative;
        else
            zeros = 0;
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
   41b24:	83 eb 01             	sub    $0x1,%ebx
   41b27:	e9 8d fe ff ff       	jmp    419b9 <printer_vprintf+0x389>
            p->putc(p, ' ', color);
   41b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
   41b2f:	89 44 24 08          	mov    %eax,0x8(%esp)
   41b33:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
   41b3a:	00 
   41b3b:	89 34 24             	mov    %esi,(%esp)
   41b3e:	ff 16                	call   *(%esi)
                 && numeric && len + !!negative < width)
            zeros = width - len - !!negative;
        else
            zeros = 0;
        width -= len + zeros + !!negative;
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
   41b40:	8b 45 c0             	mov    -0x40(%ebp),%eax
   41b43:	83 e8 01             	sub    $0x1,%eax
   41b46:	89 45 c4             	mov    %eax,-0x3c(%ebp)
   41b49:	89 7d ac             	mov    %edi,-0x54(%ebp)
   41b4c:	89 5d a8             	mov    %ebx,-0x58(%ebp)
   41b4f:	89 c3                	mov    %eax,%ebx
   41b51:	8b 7d 0c             	mov    0xc(%ebp),%edi
   41b54:	e9 60 fe ff ff       	jmp    419b9 <printer_vprintf+0x389>
            p->putc(p, *data, color);
        for (; width > 0; --width)
            p->putc(p, ' ', color);
    done: ;
    }
}
   41b59:	83 c4 6c             	add    $0x6c,%esp
   41b5c:	5b                   	pop    %ebx
   41b5d:	5e                   	pop    %esi
   41b5e:	5f                   	pop    %edi
   41b5f:	5d                   	pop    %ebp
   41b60:	c3                   	ret    

00041b61 <console_vprintf>:
            *cp->cursor++ = ' ' | color;
    } else
        *cp->cursor++ = c | color;
}

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   41b61:	55                   	push   %ebp
   41b62:	89 e5                	mov    %esp,%ebp
   41b64:	83 ec 28             	sub    $0x28,%esp
   41b67:	8b 45 08             	mov    0x8(%ebp),%eax
    struct console_printer cp;
    cp.p.putc = console_putc;
   41b6a:	c7 45 f0 b5 14 04 00 	movl   $0x414b5,-0x10(%ebp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS)
        cpos = 0;
   41b71:	3d d0 07 00 00       	cmp    $0x7d0,%eax
   41b76:	ba 00 00 00 00       	mov    $0x0,%edx
   41b7b:	0f 43 c2             	cmovae %edx,%eax
    cp.cursor = console + cpos;
   41b7e:	8d 84 00 00 80 0b 00 	lea    0xb8000(%eax,%eax,1),%eax
   41b85:	89 45 f4             	mov    %eax,-0xc(%ebp)
    printer_vprintf(&cp.p, color, format, val);
   41b88:	8b 45 14             	mov    0x14(%ebp),%eax
   41b8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
   41b8f:	8b 45 10             	mov    0x10(%ebp),%eax
   41b92:	89 44 24 08          	mov    %eax,0x8(%esp)
   41b96:	8b 45 0c             	mov    0xc(%ebp),%eax
   41b99:	89 44 24 04          	mov    %eax,0x4(%esp)
   41b9d:	8d 45 f0             	lea    -0x10(%ebp),%eax
   41ba0:	89 04 24             	mov    %eax,(%esp)
   41ba3:	e8 88 fa ff ff       	call   41630 <printer_vprintf>
    return cp.cursor - console;
   41ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
   41bab:	2d 00 80 0b 00       	sub    $0xb8000,%eax
   41bb0:	d1 f8                	sar    %eax
}
   41bb2:	c9                   	leave  
   41bb3:	c3                   	ret    

00041bb4 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   41bb4:	55                   	push   %ebp
   41bb5:	89 e5                	mov    %esp,%ebp
   41bb7:	83 ec 18             	sub    $0x18,%esp
    va_list val;
    va_start(val, format);
   41bba:	8d 45 14             	lea    0x14(%ebp),%eax
    cpos = console_vprintf(cpos, color, format, val);
   41bbd:	89 44 24 0c          	mov    %eax,0xc(%esp)
   41bc1:	8b 45 10             	mov    0x10(%ebp),%eax
   41bc4:	89 44 24 08          	mov    %eax,0x8(%esp)
   41bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
   41bcb:	89 44 24 04          	mov    %eax,0x4(%esp)
   41bcf:	8b 45 08             	mov    0x8(%ebp),%eax
   41bd2:	89 04 24             	mov    %eax,(%esp)
   41bd5:	e8 87 ff ff ff       	call   41b61 <console_vprintf>
    va_end(val);
    return cpos;
}
   41bda:	c9                   	leave  
   41bdb:	c3                   	ret    

00041bdc <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   41bdc:	55                   	push   %ebp
   41bdd:	89 e5                	mov    %esp,%ebp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i)
   41bdf:	b8 00 00 00 00       	mov    $0x0,%eax
        console[i] = ' ' | 0x0700;
   41be4:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
   41beb:	00 20 07 

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i)
   41bee:	83 c0 01             	add    $0x1,%eax
   41bf1:	3d d0 07 00 00       	cmp    $0x7d0,%eax
   41bf6:	75 ec                	jne    41be4 <console_clear+0x8>
        console[i] = ' ' | 0x0700;
    cursorpos = 0;
   41bf8:	c7 05 fc 8f 0b 00 00 	movl   $0x0,0xb8ffc
   41bff:	00 00 00 
}
   41c02:	5d                   	pop    %ebp
   41c03:	c3                   	ret    
