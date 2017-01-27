We did not do this in lecture, but instead I'm doing a video on it.
So, the code is committed both here and in the cs61-videos repository.

pingpong: Unsynchronized
pingpong2.c: Properly synchronized using two pipes; never exits
pingpong3.c: Adds flushes so we can pipe output and see what's
    really happening!
pingpong4.c:  Let's try to time out after 5 seconds and kill the
    running children.  This works, but if the children exit early,
    we still sleep for 5 seconds; that is unfortunate!
pingpong5.c: This time, we set a timer, and use waitpid to wait for the
    children to exit.
pingpong6.c: This time, we set up signal handlers for the children and
    go back to sleeping; this also sort of works, but exhibits a race
    condition!
pingpong7.c: This time we use select!
