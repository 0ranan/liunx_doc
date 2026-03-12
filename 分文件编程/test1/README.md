# 分文件编程案例1

## 案例运行指令（直接运行）

```bash
gcc -o test1.out main.c test.c
./test1
```


## 案例运行指令 （静态库的制作与使用）

```bash
# 1. 生成.o文件
gcc -c test.c 
# 2. 生成.a文件（静态库）
ar rcs libtest.a test.o

# 使用静态库
# gcc -o test1.out main.c libtest.a 
gcc main.c -l test -L ./ 
```

## 


## 案例源码讲解
本案例分为了三个文件

主函数文件：main.c

```c
#include <stdio.h>
#include "test.h"

int main()
{
    test();
    return 0;
}
```

头文件：test.h

```c
void test();
```

实现文件：test.c

```c
#include <stdio.h>
#include "test.h"

void test()
{
    printf("hello test\n");
}
``` 
