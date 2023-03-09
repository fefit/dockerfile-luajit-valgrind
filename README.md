# dockerfile-luajit-valgrind

编译 luajit 支持使用 valgrind 调试的镜像。

## 使用方式

```bash
# entrypoint 会运行 valgrind 命令
# 会提取 --cfile 参数，将参数值对应的c文件进行编译
# 其它情况可以将编译后的动态链接库直接挂载
docker run -it --rm \
-v xxx.lua:xxx.lua \
-v xxx.c:xxx.c \
xiaofuzi123/luajit-valgrind:v2.1 \
--cfile xxx.c \
--tool=memcheck \
luajit xxx.lua \
```
