#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char *argv[]){

  if(argc < 2){
    printf("wunzip: file1 [file2 ...]\n");
    exit(1);
  }

  for(int i = 1;i<argc;i++){
    char* fname = argv[i];
    FILE* fl = fopen(fname, "r");

    size_t len;
    char* str;

    int count = 0;
    char cur;
    while(fread(&count, sizeof(int), 1, fl)){
      fread(&cur, sizeof(char), 1, fl);
      for(int i = 0;i<count;i++){
        printf("%c", cur);
      }
    }
    
    fclose(fl);
  }
  
  return 0;
}