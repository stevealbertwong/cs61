We implement semaphores using mutexes and CVs, just to show that you
can build one primitive out of another.

Then we use them to do a rather short and elegant solution to the
(generalized) pingpong problem -- that is we generalize it to any
number of threads.

The non "-soln" files are the blank files from which I started in
the video; the -soln files are a working solution -- not entirely
sure if it's identical to what I did in the video, but I wanted
to leave both the shell files and the solutions files so students
could try to reproduce it if they wanted.
