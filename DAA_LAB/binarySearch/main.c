#include<stdio.h>
#include<stdlib.h>

int binarySearch(int a[],int n,int key);

int main(){
    int n,key,a[10],pos;
    printf("Enter the number of elements:\n");
    scanf("%d",&n);
    printf("Enter the elements:\n");
    for(int i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    printf("Enter the element to be found:\n");
    scanf("%d",&key);
    pos=binarySearch(a,n,key);
    if(pos==-1){
        printf("Key not found!\n");
        exit(0);
    }else{
        printf("Key found at position %d",pos);
    }
    return 0;
}

int binarySearch(int a[],int n,int key){
    int l=0;
    int h=n-1;
    int mid;

    while(l<=h){
        mid=(l+h)/2;

        if(a[mid]==key){
            return mid;
        }else if(a[mid]<key){
            l=mid+1;
        }else{
            h=mid-1;
        }
    }
    return -1;
}
