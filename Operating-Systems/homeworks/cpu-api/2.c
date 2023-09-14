#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>

int main(){

  close(STDOUT_FILENO);
  open("./conc.output", O_CREAT|O_WRONLY|O_TRUNC, S_IRWXU);
  
  int rc = fork();
  
  if(rc < 0){
    fprintf(stderr, "fork failed\n");
    exit(1);
  }
  else if(rc == 0){
    printf("child\n");
  }
  else{
    printf("parent\n");
  }
  return 0;
}