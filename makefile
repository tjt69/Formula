CC	=	gcc
COMPILE	=	$(CC)

all:	formula

formula:	nCr.s formula.c formula.h nCr.h
	$(COMPILE) -g -Wall -m32 -o formula nCr.s formula.c formula.h nCr.h

clean:	
	rm -rf *.o formula nCr
