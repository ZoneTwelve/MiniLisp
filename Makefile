code=main
output=program
BISON=bison
CC=gcc
FLEX=flex
MAKE=make
run:
	$(BISON) -d -o $(code).tab.c $(code).y
	$(CC) -c -g -I.. $(code).tab.c
	$(FLEX) -o $(code).yy.c $(code).l
	$(CC) -c -g -I.. $(code).yy.c
	$(CC) -o $(output) $(code).tab.o $(code).yy.c -ll
	#$(MAKE) clean
clean:
	rm -f $(code).tab.? $(code).yy.?
test:
	make run output=$(output) code=$(code)
	./auto-test $(output)