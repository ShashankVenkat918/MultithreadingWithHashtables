	# NAME: Shashank Venkat 
	# EMAIL: shashank18@g.ucla.edu
	# 705303381

build:
	gcc -Wall -Wextra -g -o lab2_list -lpthread -lprofiler lab2_list.c SortedList.c

tests: build
	chmod +x tests.sh
	./tests.sh
	-./lab2_list --threads=1 --yield=id --lists=4 --iterations=1 >> lab2b_list.csv
	-./lab2_list --threads=1 --yield=id --lists=4 --iterations=2 >> lab2b_list.csv
	-./lab2_list --threads=1 --yield=id --lists=4 --iterations=4 >> lab2b_list.csv
	-./lab2_list --threads=1 --yield=id --lists=4 --iterations=8 >> lab2b_list.csv
	-./lab2_list --threads=1 --yield=id --lists=4 --iterations=16 >> lab2b_list.csv
	-./lab2_list --threads=4 --yield=id --lists=4 --iterations=1 >> lab2b_list.csv
	-./lab2_list --threads=4 --yield=id --lists=4 --iterations=2 >> lab2b_list.csv
	-./lab2_list --threads=4 --yield=id --lists=4 --iterations=4 >> lab2b_list.csv
	-./lab2_list --threads=4 --yield=id --lists=4 --iterations=8 >> lab2b_list.csv
	-./lab2_list --threads=4 --yield=id --lists=4 --iterations=16 >> lab2b_list.csv
	-./lab2_list --threads=8 --yield=id --lists=4 --iterations=1 >> lab2b_list.csv
	-./lab2_list --threads=8 --yield=id --lists=4 --iterations=2 >> lab2b_list.csv
	-./lab2_list --threads=8 --yield=id --lists=4 --iterations=4 >> lab2b_list.csv
	-./lab2_list --threads=8 --yield=id --lists=4 --iterations=8 >> lab2b_list.csv
	-./lab2_list --threads=8 --yield=id --lists=4 --iterations=16 >> lab2b_list.csv
	-./lab2_list --threads=16 --yield=id --lists=4 --iterations=1 >> lab2b_list.csv
	-./lab2_list --threads=16 --yield=id --lists=4 --iterations=2 >> lab2b_list.csv
	-./lab2_list --threads=16 --yield=id --lists=4 --iterations=4 >> lab2b_list.csv
	-./lab2_list --threads=16 --yield=id --lists=4 --iterations=8 >> lab2b_list.csv
	-./lab2_list --threads=16 --yield=id --lists=4 --iterations=16 >> lab2b_list.csv
	-./lab2_list --threads=12 --yield=id --lists=4 --iterations=1 >> lab2b_list.csv
	-./lab2_list --threads=12 --yield=id --lists=4 --iterations=2 >> lab2b_list.csv
	-./lab2_list --threads=12 --yield=id --lists=4 --iterations=4 >> lab2b_list.csv
	-./lab2_list --threads=12 --yield=id --lists=4 --iterations=8 >> lab2b_list.csv
	-./lab2_list --threads=12 --yield=id --lists=4 --iterations=16 >> lab2b_list.csv

graphs: tests
	./lab2b_list.gp

dist: graphs
	tar -czvf lab2b-705303381.tar.gz SortedList.c SortedList.h lab2_list.c Makefile lab2b_list.csv profile.out lab2b_1.png lab2b_2.png lab2b_3.png lab2b_4.png lab2b_5.png profile.out tests.sh lab2b_list.gp README
	
profile:
	rm -f ./raw.gperf profile.out
	LD_PRELOAD=/u/eng/class/classsve/cs111/libprofiler.so
	CPUPROFILE=./raw.gperf ./lab2_list --threads=12 --iterations=1000 --sync=s
	/u/eng/class/classsve/cs111/pprof --test ./lab2_list ./raw.gperf
	pprof --text ./lab2_list ./raw.gperf > profile.out
	pprof --list=threadFunc ./lab2_list ./raw.gperf >> profile.out
	rm -f profile.gperf lab2_list ./raw.gperf


clean:
	rm -f lab2b-705303381.tar.gz lab2_list