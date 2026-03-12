# Liunx库相关概念

> gcc 编译的时候默认会去/usr/include /usr/local/include中寻找头文件

## 分文件编程案例

## 库

- 静态库
编译时就打包到可执行文件中
优点：快，发布时文件少
缺点：程序大

- 动态库
运行时动态（临时）的加载到内存中
优点：程序小
缺点：慢

## 库的制作

### 静态库的制作与使用

```bash
# 1. 生成.o文件
gcc -c test.c 
# 2. 生成.a文件（静态库）
ar rcs libtest.a test.o

# 使用静态库
gcc -o test1.out main.c libtest.a 
```

### 动态库的制作与使用

```bash
# 1. 生成.so文件（动态库）
gcc -shared -fPIC test.c  -o libtest.so
# -fPIC 生成位置无关的代码


# 会默认去/usr/lib 下面找动态库
# 环境变量LD_LIBRARY_PATH指定的动态库搜索路径；
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mqtt/MQTT-c/lib
# 使用动态库
gcc -o test2.out main.c -l test -L ./ 
```



## 库的使用



