#include<stdio.h>
#include<stdlib.h>

int main(int argc, char* argv[]){
  
  for(int i = 1;i<argc;i++){
    char* fname = argv[i];
    FILE *fp = fopen(fname, "r");
    
    if(fp == NULL){
      printf("wcat: cannot open file\n");
      exit(1);
    }

    char str[100];
    while(fgets(str, 100, fp)){
      printf("%s", str);
    }
    fclose(fp);
  }

  return 0;
}