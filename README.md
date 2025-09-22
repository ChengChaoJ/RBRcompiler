

---

# RBRcompiler

## 一、构建镜像

这是前置条件，你得先配置好 Docker。

从终端进入 `RBRCOMPILER` 文件夹，输入以下命令：

```bash
docker build --platform linux/arm64 -t my-compiler-app-2.0 .
```

构建完成后，你可以在终端输入以下命令查看现存的镜像：

```bash
docker images
```

## 二、运行试验 1

### 1\. 运行容器

命令如下：

```bash
docker run -it my-compiler-app-2.0:latest /bin/bash
```

### 2\. 进入脚本文件目录

```bash
cd tests/lexer/
```

### 3\. 运行脚本

由于可能出现格式问题，得把 `.sh` 文件转换成正确的格式。执行以下命令：

```bash
dos2unix ./simple_test.sh
```

如果成功，会显示：

```
dos2unix: converting file ./simple_test.sh to Unix format...
```

然后输入以下命令运行脚本：

```bash
./simple_test.sh
```

最后，就会显示实验的结果

---
