#include "kernel.h"
#include "lib.h"

// kernel.c
//
//    This is the kernel.


// INITIAL PHYSICAL MEMORY LAYOUT
//
//  +-------------- Base Memory --------------+
//  v                                         v
// +-----+--------------------+----------------+--------------------+---------/
// |     | Kernel      Kernel |       :    I/O |     Application    |
// |     | Code + Data  Stack |  ...  : Memory | Code + Data  Stack |
// +-----+--------------------+----------------+--------------------+---------/
// 0  0x40000              0x80000 0xA0000 0x100000             0x140000
//                                             ^
//                                             | \___ PROC_SIZE ___/
//                                      PROC_START_ADDR

#define PROC_SIZE 0x40000

static proc processes[NPROC];   // array of process descriptors
                                // Note that `processes[0]` is never used.
proc* current;                  // pointer to currently executing proc

void schedule(void);
void run(proc* p) __attribute__((noreturn));


// kernel
//    Initialize the hardware and processes and start running.

void kernel(void) {
    hardware_init();
    console_clear();

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
    for (pid_t i = 0; i < NPROC; i++) {
        processes[i].p_pid = i;
        processes[i].p_state = P_FREE;
    }

    // Load the process application code and data into memory,
    // set up its %eip and %esp, and mark it runnable.
    process_init(&processes[1], PROCINIT_ALLOW_PROGRAMMED_IO);
    int r = program_load(&processes[1], 0);
    assert(r >= 0);
    processes[1].p_registers.reg_esp = PROC_START_ADDR + PROC_SIZE;
    processes[1].p_state = P_RUNNABLE;

    // Switch to the first process using run()
    run(&processes[1]);
}


// exception(reg)
//    Exception handler (for interrupts, traps, and faults).
//
//    The register values from exception time are stored in `reg`.
//    The processor responds to an exception by saving application state on
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_registers* reg) {
    // Copy the saved registers into the `current` process descriptor.
    current->p_registers = *reg;

    // Show the current cursor location.
    console_show_cursor(cursorpos);

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();


    // Actually handle the exception.
    switch (reg->reg_intno) {

    case INT_SYS_PANIC:
        panic("%s", (char*) current->p_registers.reg_eax);
        break;                  // will not be reached

    case INT_SYS_WRITE:
        cursorpos = console_printf(cursorpos, 0x0700, "%.*s",
                                   (int) current->p_registers.reg_ecx,
                                   (char*) current->p_registers.reg_eax);
        console_show_cursor(cursorpos);
        current->p_registers.reg_eax = 0; // return 0 to process
        break;

    case INT_SYS_YIELD:
        schedule();             // does not return

    default:
        panic("Unexpected interrupt %d!\n", reg->reg_intno);
        break;

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE)
        run(current);
    else
        schedule();
}


// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
    pid_t pid = current->p_pid;
    while (1) {
        pid = (pid + 1) % NPROC;
        if (processes[pid].p_state == P_RUNNABLE)
            run(&processes[pid]);
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
    }
}


// run(p)
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
    assert(p->p_state == P_RUNNABLE);
    current = p;

    asm volatile("movl %0,%%esp\n\t"
                 "popal\n\t"
                 "popl %%es\n\t"
                 "popl %%ds\n\t"
                 "addl $8, %%esp\n\t"
                 "iret"
                 :
                 : "g" (&p->p_registers)
                 : "memory");

 spinloop: goto spinloop;       // should never get here
}
