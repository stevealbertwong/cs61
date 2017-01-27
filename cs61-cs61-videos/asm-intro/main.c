#include <stdio.h>
#include <stdint.h>

void
func(void)
{
    return;
}

int
main(int argc, char *argcv[])
{
    func();
    printf("&func is %x\n", (uintptr_t)func);
}
