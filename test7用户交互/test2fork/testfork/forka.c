#include <stdio.h>
#include <unistd.h>
int main()
{
    int pid = fork();
    if(-1 == pid){
        return -1;
    }
    printf("Who an i?, my pid is %d\n", getpid());

    return 0;
}