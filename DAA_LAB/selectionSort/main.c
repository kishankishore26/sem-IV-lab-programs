#include<stdio.h>
#include<stdlib.h>

void selectionSort(int a[],int n);

int main(){
    int n,a[10];
    printf("Enter the number of elements:\n");
    scanf("%d",&n);
    printf("Enter the elements:\n");
    for(int i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    selectionSort(a,n);
    return 0;
}

void selectionSort(int a[],int n){
    int i,j,min;
    for(i=0;i<n-1;i++){
        min=i;
        for(j=i;j<n;j++){
            if(a[j]<a[min]){
                min=j;
            }
        }
        int temp=a[i];
        a[i]=a[min];
        a[min]=temp;
    }
    printf("Elements in sorted order is:\n");
    for(i=0;i<n;i++){
        printf("%d\t",a[i]);
    }
}
