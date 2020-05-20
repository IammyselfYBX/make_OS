#include "print.h"
#include "init.h"
#include "debug.h"
int main(void) {
   put_str("In kernel\n");
   init_all();
   ASSERT(1==2);
   put_str("\n        By Ybx\n");
   while(1);
   return 0;
}
