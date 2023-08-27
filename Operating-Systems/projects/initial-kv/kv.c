#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc, char* argv[]){

  FILE* db = fopen("database.txt", "w+");

  char* arr[100000];

  for(int i = 1;i<argc;i++){

    char *token, *str, *to_free;
    to_free = str = strdup(argv[i]);

    int j = 0, key;
    char *cmd, *value;

    while((token = strsep(&str, ",")) != NULL){
      if(j == 0) cmd = token;
      else if(j == 1) key = atoi(token);
      else if(j == 2) value = token;
      j++;
    }

    printf("%s %d %s\n", cmd, key, value);

    if(strcmp(cmd, "p") == 0){
      arr[key] = value;
    }
    else if(strcmp(cmd, "g") == 0){
      printf("%s\n", arr[key]);
    }
    else if(strcmp(cmd, "d") == 0){

    }
    else if(strcmp(cmd, "c") == 0){

    }
    else if(strcmp(cmd, "a") == 0){

    }
    else printf("bad command\n");
    
    free(to_free);
  }

  fclose(db);
  
  return 0;
}