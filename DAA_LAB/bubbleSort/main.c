#include<stdio.h>
#include<stdlib.h>

void bubbleSort(int a[],int n);

int main(){
    int n,a[10];
    printf("Enter the number of elements:\n");
    scanf("%d",&n);
    printf("Enter the elements:\n");
    for(int i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    bubbleSort(a,n);
    return 0;
}

void bubbleSort(int a[],int n){
    int i,j;
    for(i=0;i<n-1;i++){
        for(j=0;j<n-i-1;j++){
            if(a[j+1]<a[j]){
                int temp=a[j];
                a[j]=a[j+1];
                a[j+1]=temp;
            }
        }
    }
    printf("The elements in sorted order is:\n");
    for(i=0;i<n;i++){
        printf("%d\t",a[i]);
    }
}
