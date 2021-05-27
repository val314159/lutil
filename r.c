#include<stdio.h>
#include<string.h>
#include"ripemd160.h"
int main(int argc, char*argv[]){
  unsigned char hash[20];
  unsigned char msg[] = "";
  ripemd160(msg, strlen((char*)msg), hash);
  for(int n=0; n<20; n++) printf("%02x", hash[n]);
  printf("\n");  
}
