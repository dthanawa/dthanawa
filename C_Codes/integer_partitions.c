#include <stdio.h>
#include<math.h>

int partition(int s, int l){ //Integer partition recursive function
    
    if (s==0)//checking if sum = 0
        return 1;
        if (l==0)//checking if largest_num = 0
        return 0;
    if (s<0)//checking if sum < 0
        return 0;

    return partition(s,l-1) + partition(s-l,l);//return the value to function itself
}

double prob(int i){//Approximation formula function
  //initialize the double variable locally
  double num1 = 0.00 ;
  double num  = 0.00 ;
  double den  = 0.00 ;
  double p    = 0.00 ;
  double pi_d = 22.0/7.0;
   
    num1 = pi_d * sqrt(2 * i/3.0);
    num  = exp(num1);//calculating the numerator

    den = 4 * i * sqrt(3.0);//calculating the denominator
    return p=num/den;//calculating the approximation of integer parition
  
}

int main(){
    //Initialize the variable
    int i;
    //creating the array for given input numbers
    int s[12] = {0,1,2,3,4,5,6,7,8,9,10,100};//sum
    int l[12] = {0,1,2,3,4,5,6,7,8,9,10,100};//largest number
    printf("******************Actual v/s Approximated********************\ninteger\tActual\t\t\tApproximation\n");
   
    for(i=0;i<=11;i++)
     {
      printf("%d\t%d\t\t\t%.5lf \n",s[i],partition(s[i],l[i]),prob(s[i])); //print the values
     }

    return 0;
}


