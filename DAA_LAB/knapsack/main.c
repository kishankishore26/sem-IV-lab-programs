#include<stdio.h>
#include<stdlib.h>
#define MAX 10

int knapsack(int i,int j);

int v[MAX];
int w[MAX];
int F[MAX][MAX];

int max(int a,int b){
    if(a>=b){
        return a;
    }else{
        return b;
    }
}

int main(){
    int n,W;
    printf("Enter the number or items: ");
    scanf("%d",&n);
    printf("Enter the weights of items: ");
    for(int i=0;i<n;i++){
        scanf("%d",&w[i]);
    }
    printf("Enter the values of the items: ");
    for(int i=0;i<n;i++){
        scanf("%d",&v[i]);
    }
    printf("Enter the knapsack capacity: ");
    scanf("%d",&W);

    for(int i=0;i<MAX;i++){
        for(int j=0;j<MAX;j++){
            F[i][j]=-1;
        }
    }
    int res=knapsack(n-1,W);
    printf("Optimal solution is: %d",res);
    return 0;
}

int knapsack(int i,int j){
    int value;
    if(i<0 || j<=0){
        return 0;
    }
    if(F[i][j]<0){
        if(j<w[i]){
            value=knapsack(i-1,j);
        }else{
            value=max(knapsack(i-1,j),knapsack(i-1,j-w[i])+v[i]);
        }
        F[i][j]=value;
    }
    return F[i][j];
}
