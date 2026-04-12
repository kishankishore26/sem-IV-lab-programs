#include <stdio.h>
#include <stdlib.h>

void mergeSort(int a[],int n);
void merge(int b[],int c[],int a[],int p,int q);

int main(){
    int n,a[10];
    printf("Enter the number of elements: ");
    scanf("%d",&n);
    printf("Enter the elements: ");
    for(int i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    mergeSort(a,n);
    printf("Elements in sorted order is: ");
    for(int i=0;i<n;i++){
        printf("%d\t",a[i]);
    }
    return 0;
}

void mergeSort(int a[],int n){
    if(n<=1){
        return;
    }
    int mid=n/2;
    int b[mid];
    int c[n-mid];

    for(int i=0;i<mid;i++){
        b[i]=a[i];
    }
    for(int i=mid;i<n;i++){
        c[i-mid]=a[i];
    }

    mergeSort(b,mid);
    mergeSort(c,n-mid);

    merge(b,c,a,mid,n-mid);
}

void merge(int b[],int c[],int a[],int p,int q){
    int i=0,j=0,k=0;
    while(i<p && j<q){
        if(b[i]<c[j]){
            a[k++]=b[i++];
        }else{
            a[k++]=c[j++];
        }
    }

    while(i<p){
        a[k++]=b[i++];
    }
    while(j<q){
        a[k++]=c[j++];
    }
}
