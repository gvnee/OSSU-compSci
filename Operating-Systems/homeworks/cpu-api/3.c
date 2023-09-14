#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>

int main(){
  int rc = fork();
  
  if(rc < 0){
    fprintf(stderr, "fork failed\n");
    exit(1);
  }
  else if(rc == 0){
    printf("child says hello\n");
  }
  else{
    wait(NULL);
    printf("parent says goodbye\n");
  }
  
  return 0;
}