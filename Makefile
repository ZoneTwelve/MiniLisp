code=main
output=program
BISON=bison
CC=gcc
FLEX=flex
MAKE=make
BAKNAME=`date +"%Y%m%d-%H%M%S"`
run:
	$(BISON) -d -o $(code).tab.c $(code).y
	$(CC) -c -g -I.. $(code).tab.c
	$(FLEX) -o $(code).yy.c $(code).l
	$(CC) -c -g -I.. $(code).yy.c
	$(CC) -o $(output) $(code).tab.o $(code).yy.c -ll
	# $(MAKE) clean
clean:
	rm -f $(code).tab.? $(code).yy.?
test:
	make run output=$(output) code=$(code)
	./auto-test $(output)
bak:
	mkdir -p backup/$(BAKNAME)
	cp $(code).y ./backup/$(BAKNAME)/$(code).y
	cp $(code).l ./backup/$(BAKNAME)/$(code).l