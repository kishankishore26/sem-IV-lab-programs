#include<stdio.h>
#include<stdlib.h>
#define max 10

void floyds(int a[max][max],int n);

int main(){
    int n,a[max][max];
    printf("Enter the order of matrix: ");
    scanf("%d",&n);
    printf("Enter the adjacency matrix: ");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&a[i][j]);
        }
    }
    floyds(a,n);
    printf("Transitive closure is:\n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            printf("%d\t",a[i][j]);
        }
        printf("\n");
    }
    return 0;
}


void floyds(int a[max][max],int n){
    for(int k=0;k<n;k++){
        for(int i=0;i<n;i++){
            for(int j=0;j<n;j++){
                if(a[i][k]+a[k][j]<a[i][j]){
                    a[i][j]=a[i][k]+a[k][j];
                }
            }
        }
    }
}
