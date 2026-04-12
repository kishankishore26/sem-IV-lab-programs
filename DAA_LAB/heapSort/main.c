#include<stdio.h>
#include<stdlib.h>
#define max 10

void heapSort();
void heapify(int n,int i);
int n,a[max];
int main(){
    printf("Enter the number of elements: ");
    scanf("%d",&n);
    printf("Enter the elements: ");
    for(int i=1;i<=n;i++){
        scanf("%d",&a[i]);
    }
    heapSort();
    printf("Elements after sorting: ");
    for(int i=1;i<=n;i++){
        printf("%d\t",a[i]);
    }
    return 0;
}

void heapSort(){
    for(int i=n/2;i>=1;i--){
        heapify(n,i);
    }
    for(int i=n;i>1;i--){
        int temp=a[1];
        a[1]=a[i];
        a[i]=temp;
        heapify(i-1,1);
    }
}

void heapify(int n,int i){
    int large=i;
    int left=2*i;
    int right=2*i+1;

    if(left<=n && a[left]>a[large]){
        large=left;
    }
    if(right<=n && a[right]>a[large]){
        large=right;
    }
    if(large!=i){
        int temp=a[i];
        a[i]=a[large];
        a[large]=temp;
        heapify(n,large);
    }
}

