fib.c

    This recursive function was used to demonstrate the usefulness of
    local variables (variables with automatic storage duration).

    GDB example: Try running `gdb ./fib` and setting a breakpoint at
    `fib`. Now `run`, and continue 9 times, stopping at the 10th
    overall call to `fib`. (Either type `c [RETURN]` 9 times, or type
    `c [RETURN]`, and then hit [RETURN] eight times. In GDB, [RETURN]
    by itself repeats the last command.) Now print a backtrace; you
    should see something like this:

        (gdb) bt
        #0  fib (n=1) at fib.c:5
        #1  0x08048484 in fib (n=2) at fib.c:8
        #2  0x08048498 in fib (n=4) at fib.c:8
        #3  0x08048484 in fib (n=5) at fib.c:8
        #4  0x08048484 in fib (n=6) at fib.c:8
        #5  0x08048511 in main (argc=1, argv=0xbffff144) at fib.c:16

    The topmost line, frame #0, is the currently running function. The
    previous lines are the current function's caller, its
    grand-caller, its great-grand-caller, and so forth, all the way
    back to main. These functions are all suspended, waiting for the
    current function to finish. They have their own local variables on
    the stack. (This is why automatic storage duration variables are
    useful: they spring into existence when a function is called, and
    automatically go away when the function exits, so we don't need to
    pre-allocate storage for them.)

    The addresses on lines #1-#5 are RETURN ADDRESSES. They are
    addresses of instructions. When the current function (frame #0)
    returns, its caller will resume at instruction 0x08048484 (the
    address on frame #1). When THAT function returns, its caller will
    resume at instruction 0x08048498 (the address on frame #2).

    Quick quiz:

        1. Why are there two different return addresses associated
           with the source code line `fib.c:8`?
        2. Which return address corresponds to which point in the
           source code?
        3. In the expression `fib(n - 1) + fib(n - 2)`, which
           recursive call has the compiler decided to make first?

    It is possible to answer these questions just by thinking about
    the code and the backtrace.

testalignment.c

    A program for testing the maximum alignment on a machine. The idea
    is to do 1M allocations, and check the alignment (mod 64) of each
    allocation. If every allocation's address were 0 (mod 64), we
    would have pretty good evidence that the maximum alignment of the
    machine was 64. Or, more precisely, that malloc() always returned
    addresses with 64-byte alignment.

    The program is not complete. Can you complete it?

testalignment-gcd.c

    A more direct way to test the machine's maximum alignment is
    simply to calculate the greatest common divisor, or gcd, of the
    addresses of many allocations!

membench.c

    A program for benchmarking different malloc implementations.
    We allocate 4096 `memnode` objects, then, NOPERATIONS times
    (which defaults to 10,000,000), free one object and allocate
    another. `memnode` is declared in `membench.h`.

    membench uses an "arena" for its allocations. An arena is an
    object that encapsulates a set of allocations and frees. You
    can use arenas just to capture statistics, or to encapsulate
    state for a specialized allocator.

    membench links with different allocator libraries. The simplest
    is mb-malloc.c, which implements the `memnode_alloc()`
    functions with malloc and free. Run this with `./membench-malloc`.
    Run a different number of allocations and/or simultaneous
    threads with `./membench-malloc NOPERATIONS NTHREADS`.
    But it's more interesting to see how much time a run takes.
    For this, use the `time` program:

        time ./membench-malloc

    If your machine has Google's libtcmalloc or Jason Evans's
    libjemalloc, try `./membench-tcmalloc` and `./membench-jemalloc`.
    These allocators should beat the system allocator, especially
    when there is more than one thread.

    membench only allocates fixed-sized objects. Fixed-sized objects
    are much easier to handle than variable-sized objects: they
    reduce fragmentation issues and require less tracking overhead.
    The `mb-arena.c` library is the beginnings of a fixed-size
    allocator that takes advantage of these properties. Can you
    complete it on your own? Run `./membench-arena` to check it.
    Our completed version of `mb-arena.c` beats libtcmalloc and
    libjemalloc by around 6x on my machine!
