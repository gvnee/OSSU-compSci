#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include<string.h>

bool contains(char *search, char *str){

  int src_len = strlen(search);
  int str_len = strlen(str);

  if(src_len > str_len)
    return false;
  
  int j = 0;
  for(int i = 0; i<str_len; i++){
    if(search[j] == str[i]){
      if(j == src_len-1)
        return true;
      j++;
    }
    else j = 0;
  }
  return false;
}

int main(int argc, char *argv[]){

  if(argc < 2){
    printf("wgrep: searchterm [file ...]\n");
    exit(1);
  }
  char *search_term = argv[1];

  if(argc == 2){
    char str[10000];
    while(fgets(str, 10000, stdin)){
      if(contains(search_term, str)){
        printf("%s", str);
      }
    }
  }

  for(int i = 2;i<argc;i++){
    char *fname = argv[i];
    FILE *fl = fopen(fname, "r");
    if(fl == NULL){
      printf("wgrep: cannot open file\n");
      exit(1);
    }
    char *str = NULL;
    size_t len = 0;
    while(getline(&str, &len, fl) != EOF){
      if(contains(search_term, str)){
        printf("%s", str);
      }
    }
    fclose(fl);
  }
  
  return 0;
}