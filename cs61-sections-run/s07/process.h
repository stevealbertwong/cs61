#ifndef WEENSYOS_PROCESS_H
#define WEENSYOS_PROCESS_H
#include "lib.h"
#include "x86.h"
#if WEENSYOS_KERNEL
#error "process.h should not be used by kernel code."
#endif

// process.h
//
//    Support code for WeensyOS processes.


// SYSTEM CALLS

static inline uint32_t syscall_0_args(int) __attribute__((always_inline));
static inline uint32_t syscall_1_arg(int, uint32_t)
    __attribute__((always_inline));
static inline uint32_t syscall_2_args(int, uint32_t, uint32_t)
    __attribute__((always_inline));
static inline uint32_t syscall_3_args(int, uint32_t, uint32_t, uint32_t)
    __attribute__((always_inline));

// sys_panic
//    Report an error and stop the current process.
static inline void sys_panic(const char* message) __attribute__((noreturn));
static inline void sys_panic(const char* message) {
    syscall_1_arg(INT_SYS_PANIC, (uint32_t) message);
 spinloop: goto spinloop;
}

// sys_write
//    Write a string to the console.
static inline void sys_write(const char* message, size_t sz) {
    syscall_2_args(INT_SYS_WRITE, (uint32_t) message, (uint32_t) sz);
}

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    (void) syscall_0_args(INT_SYS_YIELD);
}


// syscall_0_args, syscall_1_arg, syscall_2_args, and syscall_3_args functions.
//    We use the following calling convention for system calls.
//    (1) The interrupt number is the system call number.
//    (2) Up to 3 parameters may be passed in registers %eax, %ecx, and %edx.
//    (3) The return value is passed in %eax.

static inline uint32_t syscall_0_args(int syscall_number) {
    uintptr_t result;
    asm volatile("int %1\n"
                 : "=a" (result)        // return value in %eax
                 : "i" (syscall_number) // pass system call number to `int`
                 : "cc", "memory");
    return result;
}

static inline uint32_t syscall_1_arg(int syscall_number, uint32_t arg0) {
    asm volatile("int %1\n"
                 : "+a" (arg0)          // return value + 1st arg in %eax
                 : "i" (syscall_number)
                 : "cc", "memory");
    return arg0;
}

static inline uint32_t syscall_2_args(int syscall_number, uint32_t arg0,
                                      uint32_t arg1) {
    asm volatile("int %1\n"
                 : "+a" (arg0)          // return value + 1st arg in %eax
                 : "i" (syscall_number),
                   "c" (arg1)           // 2nd arg in %ecx
                 : "cc", "memory");
    return arg0;
}

static inline uint32_t syscall_3_args(int syscall_number, uint32_t arg0,
                                      uint32_t arg1, uint32_t arg2) {
    asm volatile("int %1\n"
                 : "+a" (arg0)          // return value + 1st arg in %eax
                 : "i" (syscall_number),
                   "c" (arg1),          // 2nd arg in %ecx
                   "d" (arg2)           // 3rd arg in %edx
                 : "cc", "memory");
    return arg0;
}


// OTHER HELPER FUNCTIONS

// app_printf(format, ...)
//    Calls console_printf() (see lib.h). The cursor position is read from
//    `cursorpos`, a shared variable defined by the kernel, and written back
//    into that variable. The initial color is based on the current process ID.
void app_printf(int colorid, const char* format, ...);

#endif
