#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int stringMatching(int t,int p,char text[],char pattern[]);

int main(){
    char text[100],pattern[100];
    int p,t;
    printf("Enter the text:\n");
    gets(text);
    printf("Enter the pattern:\n");
    gets(pattern);
    p=strlen(pattern);
    t=strlen(text);

    if(p>t){
        printf("Error! Length of pattern cannot be greater than the text\n");
        exit(0);
    }
    int pos=stringMatching(t,p,text,pattern);
    if(pos==-1){
        printf("Pattern does not exist in the text\n");
    }else{
        printf("Pattern exits at position %d",pos);
    }
    return 0;
}

int stringMatching(int t,int p,char text[],char pattern[]){
    for(int i=0;i<t-p+1;i++){
        int j=0;
        while(j<p && pattern[j]==text[i+j]){
            j++;
        }
        if(j==p){
            return i;
        }
    }
    return -1;
}
