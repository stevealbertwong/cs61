#include "process.h"
#include "lib.h"
#include "x86.h"
#define ALLOC_SLOWDOWN 100

extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void
evil_interrupt_handler(void)
{
    for (int i = 1; ; i++) {
        if (i % 1000000 == 0)
            app_printf(10, "I own your machine! %d\n", i);
    }
}

// This is a "badguy" process that we're going to use to try to
// break process isolation, thereby uncovering kernel mechanisms
// that prevent bad behavior.
void process_main(void) {
    x86_gatedescriptor *p = (void *)0x50180;
    SETGATE(*p, 0, 8, evil_interrupt_handler, 3);

    // Check fork return values: fork should return 0 to child.
    pid_t me = sys_getpid();
    for (int i = 1; ; i++) {
        if (i % 1000000 == 0)
            app_printf(10, "Bad guy %d running ... %d\n",
                    me, i);
    }
}
