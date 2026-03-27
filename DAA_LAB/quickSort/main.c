#include<stdio.h>
#include<stdlib.h>

void quickSort(int a[],int l,int r);
int partition(int a[],int l,int r);
int main(){
    int n,l,r;
    int a[10];
    printf("Enter the number of elements:\n");
    scanf("%d",&n);
    printf("Enter the elements:\n");
    for(int i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    l=0;
    r=n-1;
    quickSort(a,l,r);
    printf("Elements in sorted order:\n");
    for(int i=0;i<n;i++){
        printf("%d\t",a[i]);
    }
    return 0;
}

void quickSort(int a[],int l,int r){
    if(l<r){
        int s=partition(a,l,r);
        quickSort(a,l,s-1);
        quickSort(a,s+1,r);
    }
}

int partition(int a[],int l,int r){
    int P=a[l];
    int i=l;
    int j=r;

    while(i<j){
        while(i<r && a[i]<=P){
            i++;
        }
        while(j>=l && a[j]>P){
            j--;
        }
        if(i<j){
            int temp=a[i];
            a[i]=a[j];
            a[j]=temp;
        }
    }
    a[l]=a[j];
    a[j]=P;
    return j;
}
