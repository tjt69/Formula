#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#include<sys/time.h>
#include"nCr.h"
#include"formula.h"

/*	Takes in two integer parameters and returns their sum	*/

int add(int x, int y){
	return x+y;
}
/*
 *	Takes in a positive integer and finds (1+x)^n in long notation
 *	where n is the accepted integer. 
 *
 *	If the user enters "-h" the format for usage will be printed.
 *
 *	If the input is anything else an error message will print and
 *	the program will terminate.
 *
 *	Will print out the time it took in milliseconds and return 0 on success. 
 */

int main(int argc, char** argv){

/*	Checks for help flag from user	*/

	if(strcmp(argv[1],"-h")==0||strcmp(argv[1],"-H")==0){
		printf("Usage: formula <positive integer>\n");
		return 0;
	}

/*	Checks input to make sure it is positive and a digit
 	Exits on error 	*/

	if(argv[1][0]=='-'||!isdigit(argv[1][0])){
		fprintf(stderr,"Error: Must Be Positive Integer\n");
		exit(EXIT_FAILURE);
	}

	struct timeval start,end;	//Declares two struct timevals to keep track of start and finish 

	gettimeofday(&start,NULL);	//Sets the start time

	int i,j;			//declares counter varible i and the coefficient variable j
	int n = atoi(argv[1]);		//changes the string input to an integer

	printf("(1+x)^%d = 1",n);	//prints the first element

/*	Loops to print the indvidual elements of the long form of (1+x)^n.
 *	
 *	Calls nCr to find the coefficient and saves it to j.
 *	
 *	In case of overflow nCr will set j to 0 indicating an error and the loop
 *	will exit.
 */
	for(i=1;i<=n;i++){
		j=nCr(n,i);		//Coefficient

		printf(" + %d*x^%d",j,i);	//prints "+ j*x^i"	
		if(j==0){
			setvbuf (stdout, NULL, _IONBF, 0);//clears the buff so upon exit the contents of the loop does not print after the error
			fprintf(stderr,"\nError: Overflow, Number is too large\n");
			exit(EXIT_FAILURE);
		}
	}
	gettimeofday(&end,NULL);	//Sets the end time

	double time = add(((end.tv_sec-start.tv_sec)*1000000.0),(end.tv_usec-start.tv_usec));	//Computes the time taken in milliseconds

	printf("\nTime Required = %f microseconds\n",time);
	return 0;
}
