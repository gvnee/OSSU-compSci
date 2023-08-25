#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char *argv[]){

  if(argc < 2){
    printf("wzip: file1 [file2 ...]\n");
    exit(1);
  }

  for(int j = 1;j<argc;j++){
    char* fname = argv[j];

    FILE *fl = fopen(fname, "r");
    char* str;
    size_t len;

    while(getline(&str, &len, fl) != EOF){
      char cur;
      int count = 0;
        if(strlen(str)>0) cur = str[0];
      for(int i = 0;i<strlen(str);i++){
        if(str[i] == '\n') printf("\n");
        if(str[i] == cur) count++;
        else{
          fwrite(&count, sizeof(int), 1, stdout);
          // printf("%d", count);
          fwrite(&cur, sizeof(char), 1, stdout);
          // printf("%c", cur);
          cur = str[i];
          count = 1;
        }
      }

      if(count > 1){
        fwrite(&count, sizeof(int), 1, stdout);
        fwrite(&cur, sizeof(char), 1, stdout);
      }
      
    }
    
    fclose(fl);
  }

  return 0;
}