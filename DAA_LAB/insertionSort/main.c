#include<stdio.h>
#include<stdlib.h>

void insertionSort(int a[],int n);

int main(){
    int n,a[10];
    printf("Enter the number of elements:\n");
    scanf("%d",&n);
    printf("Enter the elements:\n");
    for(int i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    insertionSort(a,n);
    return 0;
}

void insertionSort(int a[],int n){
    for(int i=1;i<n;i++){
        int v=a[i];
        int j=i-1;
        while(j>=0 && a[j]>v){
            a[j+1]=a[j];
            j--;
        }
        a[j+1]=v;
    }
    printf("Elements in sorted order is:\n");
    for(int i=0;i<n;i++){
        printf("%d\t",a[i]);
    }
}
