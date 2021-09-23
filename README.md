# MultithreadingWithHashtables
Source file in C that drives one or more parallely executing threads that are operating on one shared list of lists

Used **getopt** library to take various parameters like # of threads, lists, and type of locks
Created and executed threads through the use of **pthread** library
Investigated the effects of spin-locks and mutexes on time/operation by plotting various metrics through **gnuplot**

Developed the list of lists by assigning each sub-list to a specific thread and implemented synchronization support on sublists to
allow parallel access to original list without affecting critical section
