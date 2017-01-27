qs.ml

    An OCaml quicksort function.

testqs

    A program for testing the robustness of Quicksort implementations.
    qs*.c are the Quicksort implementations. We walked through several
    of them, ending with a classic systems optimization that bounds
    the number of recursive calls to qs(), ensuring that no input
    can cause qs() to overflow the stack.

    Test the Quicksort implementations by invoking `./testqs`.
    Options are:

        ./testqs -r [N]
                The array is initially random. N is the number of
                elements in the array; it defaults to 6.
        ./testqs -u [N]
                The array is initially sorted.
        ./testqs -d [N]
                The array is initially reverse-sorted.
        ./testqs -m [N]
                The array contains the numbers [1...N] in a magic
                evil order.

    qs0.c - initial, incorrect Quicksort
        Example test: ./testqs0 -r 3
    qs1.c - correct Quicksort
        Example tests: ./testqs1 -r 3
            ./testqs1 -r 1000
            ./testqs1 -m 1000
            ./testqs1 -m 100000
    qs2.c - correct Quicksort with stack engineering
        Example test: ./testqs2 -m 100000

    Quiz:
        Can you start from qs.c and create a correct Quicksort?
        Use GDB to find the bugs. Then can you recreate the
        stack-engineering trick without looking at qs2.c?

    Further reading:
        "Implementing Quicksort Programs", Robert Sedgewick,
        Communications of the ACM 21(10), October 1978
        http://www.csie.ntu.edu.tw/~b93076/p847-sedgewick.pdf

        "Engineering a Sort Function", Jon L. Bentley and M. Douglas
        McIlroy, Software---Practice and Experience 23(11), November
        1993
        http://www.skidmore.edu/~meckmann/2009Spring/cs206/papers/spe862jb.pdf
