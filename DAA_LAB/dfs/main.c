#include<stdio.h>
#include<stdlib.h>
#define max 10

int adj[10][10];
int count=0;
int vertices[10];
void dfs(int v,int n);

int main(){
    int n,v;
    printf("Enter the number of vertices:\n");
    scanf("%d",&n);
    printf("Enter the matrix:\n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&adj[i][j]);
        }
    }
    for(int i=0;i<n;i++){
        vertices[i]=0;
    }
    printf("Enter the starting vertex:\n");
    scanf("%d",&v);
    dfs(v,n);
    return 0;
}

void dfs(int v,int n){
    count++;
    vertices[v]=count;
    printf("Vertex:%d Count:%d\n",v,count);
    for(int w=0;w<n;w++){
        if(adj[v][w]==1 && vertices[w]==0){
            dfs(w,n);
        }
    }
}
