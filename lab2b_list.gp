#! /usr/bin/gnuplot
#NAME: Shashank Venkat
#EMAIL: shashank18@g.ucla.edu
#ID: 705303381
# purpose:
#	 generate data reduction graphs for the multi-threaded list project
#
# input: lab2_list.csv
#	1. test name
#	2. # threads
#	3. # iterations per thread
#	4. # lists
#	5. # operations performed (threads x iterations x (ins + lookup + delete))
#	6. run time (ns)
#	7. run time per operation (ns)
#   8. lock contention time
#
#
# Note:
#	Managing data is simplified by keeping all of the results in a single
#	file.  But this means that the individual graphing commands have to
#	grep to select only the data they want.
#
#	Early in your implementation, you will not have data for all of the
#	tests, and the later sections may generate errors for missing data.
#

# general plot parameters
set terminal png
set datafile separator ","

# lab2b_1.png ... throughput vs. number of threads for mutex and spin-lock synchronized list operations.
set title "Graph 1: (1000 Iterations) Throughput vs # of Threads"
set xlabel "# of Threads"
set logscale x 2
set ylabel "Throughput"
set logscale y 10
set output 'lab2b_1.png'

# grep out only non-yielding with mutex and spin locks, 1000 iterations, 
plot \
     "< grep 'list-none-s,[0-9]*,1000,1,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title 'w/ spin locks' with linespoints lc rgb 'green', \
     "< grep 'list-none-m,[0-9]*,1000,1,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title 'w/ mutex locks' with linespoints lc rgb 'red'

#lab2b_list-2.png
set title "Graph 2: (1000 Iterations) Wait-For-Lock Time and Avg Operation Time vs # of Threads"
set xlabel "# of Threads"
set logscale x 2
set ylabel "Contention Time/Operations"
set logscale y 10
set output 'lab2b_2.png'
plot \
    "< grep 'list-none-m,[0-9]*,1000,1,' lab2b_list.csv" using ($2):($7) \
    title 'average op time' with linespoints lc rgb 'green', \
    "< grep 'list-none-s,[0-9]*,1000,1,' lab2b_list.csv" using ($2):($8) \
    title 'lock contention time' with linespoints lc rgb 'red'


#lab2b_list-3.png
set title "Graph 3: Threads v.s Successful Iterations"
set xlabel "# of Threads"
set logscale x 2
set ylabel "# of Successful Iterations"
set logscale y 10
set output 'lab2b_3.png'
plot \
    "<grep 'list-id-none,[0-9]*,[0-9]*,4,' lab2b_list.csv" using ($2):($3) \
    title 'unprotected' with points lc rgb 'green', \
    "<grep 'list-id-m,[0-9]*,[0-9]*,4,' lab2b_list.csv" using ($2):($3) \
    title 'mutex lock' with points lc rgb 'red', \
    "<grep 'list-id-s,[0-9]*,[0-9]*,4,' lab2b_list.csv" using ($2):($3) \
    title 'spin lock' with points lc rgb 'blue'

#lab2b_list-4.png
set title "Graph 4: Number of Threads v.s. Operations Per Second (Mutex)
set xlabel "# of Threads"
set logscale x 2
set ylabel "Throughput"
set logscale y 10
set output 'lab2b_4.png'  
plot \
     "<grep 'list-none-m,[0-9]*,1000,1,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 1' with linespoints lc rgb 'blue', \
	 "<grep 'list-none-m,[0-9]*,1000,4,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 4' with linespoints lc rgb 'red', \
	 "<grep 'list-none-m,[0-9]*,1000,8,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 8' with linespoints lc rgb 'green', \
     "<grep 'list-none-m,[0-9]*,1000,16,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 16' with linespoints lc rgb 'orange', \

    
#lab2b_list-5.png
set title "Graph 4: Number of Threads v.s. Operations Per Second (Spin Locks)
set xlabel "# of Threads"
set logscale x 2
set ylabel "Throughput"
set logscale y 10
set output 'lab2b_5.png'  
plot \
     "<grep 'list-none-s,[0-9]*,1000,1,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 1' with linespoints lc rgb 'blue', \
	 "<grep 'list-none-s,[0-9]*,1000,4,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 4' with linespoints lc rgb 'red', \
	 "<grep 'list-none-s,[0-9]*,1000,8,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 8' with linespoints lc rgb 'green', \
     "<grep 'list-none-s,[0-9]*,1000,16,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '# of lists = 16' with linespoints lc rgb 'orange'

    