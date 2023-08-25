#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char *argv){

  if(argc < 2){
    printf("wunzip: file1 [file2 ...]\n");
    exit(1);
  }
  
  char* fname = argv[1];
  FILE* fl = fopen(fname, "r");

  char* str;
  int len;
  // while(fread(&len, )){
    
  // }

  return 0;
}