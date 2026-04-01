#include <stdio.h>
#define MAX 10
int graph[MAX][MAX];

void warshallsAlgorithm(int graph[MAX][MAX],int n);

int main(){
    int n;
    printf("Enter number of vertices: ");
    scanf("%d",&n);

    printf("Enter adjacency matrix:\n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&graph[i][j]);
        }
    }
    warshallsAlgorithm(graph,n);
    printf("\nTransitive closure matrix:\n");
    for(int i=0;i<n;i++) {
        for(int j=0;j<n;j++) {
            printf("%d\t",graph[i][j]);
        }
        printf("\n");
    }
    return 0;
}

void warshallsAlgorithm(int graph[MAX][MAX],int n){
    int i,j,k;
    for(k=0;k<n;k++) {
        for(i=0;i<n;i++) {
            for(j=0;j<n;j++) {
                graph[i][j]=graph[i][j] || (graph[i][k] && graph[k][j]);
            }
        }
    }
}
