#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char *argv[]){

  if(argc < 2){
    printf("wzip: file1 [file2 ...]\n");
    exit(1);
  }

  int count = 0;
  char cur = '\0';

  for(int j = 1;j<argc;j++){

    char* fname = argv[j];
    FILE* fl = fopen(fname, "r");

    size_t len;
    char* str;

    while(getline(&str, &len, fl) != EOF){

      for(int i = 0;i<strlen(str);i++){
        if(cur == '\0') cur = str[i];
        if(str[i] != cur){
          fwrite(&count, sizeof(int), 1, stdout);
          printf("%c", cur);
          cur = str[i];
          count = 1;
        }
        else count++;
      }

    }
    fclose(fl);
  }

  fwrite(&count, sizeof(int), 1, stdout);
  printf("%c", cur);
  
  return 0;
}