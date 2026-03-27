#include <stdio.h>
#include <stdlib.h>
#define max 10

int adj[10][10];
int queue[max];
int front=-1;
int rear=-1;
int count=0;
int vertices[max];
void bsf(int n,int v);

int enqueue(int v){
    if(rear==max-1){
        return 0;
    }
    if(front==-1){
        front=0;
    }
    queue[++rear]=v;
}

int dequeue(){
    if(front==-1 || front>rear){
        return -1;
    }
    return queue[front++];
}

int isEmpty(){
    return (front==-1 || front>rear);
}

int main(){
    int n,v;
    printf("Enter the number of vertices: ");
    scanf("%d",&n);
    printf("Enter the matrix: \n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&adj[i][j]);
        }
    }
    for(int i=0;i<n;i++){
        vertices[i]=0;
    }
    printf("Enter the starting vertex: ");
    scanf("%d",&v);
    bsf(n,v);
    return 0;
}

void bsf(int n,int v){
    enqueue(v);
    count++;
    vertices[v]=count;
    while(!isEmpty()){
        int current=dequeue();
        printf("Vertex: %d Count: %d\n",current,vertices[current]);
        for(int w=0;w<n;w++){
            if(adj[current][w]==1 && vertices[w]==0){
                enqueue(w);
                count++;
                vertices[w]=count;
            }
        }
    }
}
