/*
  matrix_inversion.c

  Description: Find the inverse of a matrix by Adjoint method

  Special requirements or dependencies: None
  Tested in RHEL 7.4 with GCC 4.8.5

  Compilation and execution: Takes less than a second on most modern hardware

  Compilation: gcc -Wall -g matrix_inversion.c -lm -o matrix_inversion.x
  Execution: ./matrix_inversion.x
*/
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <time.h>
float determinant(float [][25], float);
void cofactor(float [][25], float);
void transpose(float [][25], float [][25], float);
int main()
{
 // Defining the variables
 float a[25][25], k, d;
 int i, j;
 //Generating random order of matrix
 srand(time(0));
 k =rand() % 10 + 1;
 //Print the order of the matrix 
  printf("Order of the matrix A = %.0f \n",k);
  // Print the matrix
  printf("A %.0fX%.0f Matrix is : \n", k, k);
  for (i = 0;i < k; i++)
      {
      for (j = 0;j < k; j++)
          {
          a[i][j] = rand() % 200 -100;
          }
      }
  for(i = 0; i < k; i++)
    {
     for(j = 0; j < k; j++)
        {
        printf("%.0f\t", a[i][j]);
        }
        printf("\n");
    }
  // Call determinant function  
  d = determinant(a, k);
  if (d == 0)
   printf("\nInverse of Entered Matrix is not possible\n");
  else
   cofactor(a, k);
  return 0;
}
 
/*For calculating Determinant of the Matrix */
float determinant(float a[25][25], float k)
{
  float s = 1, det = 0, b[25][25];
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
//Finding the Co-Factor of matrix 
void cofactor(float num[25][25], float f)
{
 float b[25][25], fac[25][25];
 int p, q, m, n, i, j;
 for (q = 0;q < f; q++)
 {
   for (p = 0;p < f; p++)
    {
     m = 0;
     n = 0;
     for (i = 0;i < f; i++)
     {
       for (j = 0;j < f; j++)
        {
          if (i != q && j != p)
          {
            b[m][n] = num[i][j];
            if (n < (f - 2))
             n++;
            else
             {
               n = 0;
               m++;
               }
            }
        }
      }
      fac[q][p] = pow(-1, q + p) * determinant(b, f - 1);
    }
  }
  transpose(num, fac, f);
}
//Finding Transpose and Inverse of matrix
void transpose(float num[25][25], float fac[25][25], float r)
{
  int i, j;
  float b[25][25], inverse[25][25], d;
 
  for (i = 0;i < r; i++)
    {
     for (j = 0;j < r; j++)
       {
         b[i][j] = fac[j][i];
        }
    }
  d = determinant(num, r);
  for (i = 0;i < r; i++)
    {
     for (j = 0;j < r; j++)
       {
        inverse[i][j] = b[i][j] / d;
        }
    }
   //Printing the Inverse of Matrix 
   printf("\n\n\nThe inverse of matrix A : \n");
   for (i = 0;i < r; i++)
    {
     for (j = 0;j < r; j++)
       {
         printf("%.3f\t", inverse[i][j]);
        }
    printf("\n");
     }
}


