/*
  matrix_inversion_det.c
  Description: Find the inverse of a matrix by Numerical Method

  Special requirements or dependencies: None
  Tested in RHEL 7.4 with GCC 4.8.5

  Compilation and execution: Takes less than a second on most modern hardware

  Compilation: gcc -Wall -g matrix_inversion_det.c -lm -o matrix_inversion_det.x
  Execution: ./matrix_inversion_det.x
*/
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <time.h>
float determinant(float [][100], float);
int main()
{
   //Defining the variables
  float ratio,a,d;
  int i, j, k, n;
  
  //Generating the random order of matrix n  between 1-10
  srand(time(0));
  n =rand() % 10 + 1;
  //n=3;
  printf("Order of the matrix A = %d \n",n);
  //Matrix memory allocation
  float A[100][100];
  //Creating the random n*n matrix
  for(i = 0; i < n; i++)
    {
    for(j = 0; j < n; j++)
      {
      A[i][j] = rand() % 200 -100;
      //scanf("%f",&A[i][j]);
          
      }
    }
  // Printing n*n matrix
    printf("A=\n");
    for(i = 0; i < n; i++)
      {
      for(j = 0; j < n; j++)
        {
        printf("%.2f\t", A[i][j]);
        }
      printf("\n");
      }
  // Call determinant function
     d = determinant(A, (float) n);
     if (d == 0)
        printf("\nInverse of Entered Matrix is not possible\n");
     else
       for(i = 0; i < n; i++)
          {
          for(j = n; j <2 * n; j++)
            {
            if(i==(j-n))
              A[i][j] = 1.0;
            else
              A[i][j] = 0.0;
            }
          }
      for(i = 0; i < n; i++)
          {
          for(j = 0; j < n; j++)
            {
            if(i!=j)
              {
              ratio = A[j][i]/A[i][i];
              for(k = 0; k < 2* n; k++)
                {
                A[j][k] -= ratio * A[i][k];
                }
              } 
            }
          }
      for(i = 0; i < n; i++)
        {
        a = A[i][i];
        for(j = 0; j < 2*n; j++)
        {
        A[i][j] /= a;
        }
        }
    //Printing the Inverse of the matrix
    printf("The inverse of matrix A is: \n");
    for(i = 0; i < n; i++)
      {
      for(j = n; j < 2*n; j++)
        {
        printf("%.6f", A[i][j]);
        printf("\t");
        }
      printf("\n");
      }
  return 0;

}
// Determinant function
float determinant(float a[100][100], float k)
  {
    
  float s = 1, det = 0, b[100][100];
  int i, j, m, n, c;
  if (k == 1)
    {
     return (a[0][0]);
    }
  else
    {
     det = 0;
     for (c = 0; c < k; c++)
       {
        m = 0;
        n = 0;
        for (i = 0;i < k; i++)
            {
            for (j = 0 ;j < k; j++)
                {
                b[i][j] = 0;
                if (i != 0 && j != c)
                    {
                    b[m][n] = a[i][j];
                    if (n < (k - 2))
                    n++;
                    else
                        {
                        n = 0;
                        m++;
                        }
                    }
                }
            }
          det = det + s * (a[0][c] * determinant(b, k - 1));
          s = -1 * s;
          }
    }

    return (det);
}

