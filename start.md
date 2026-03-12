# 开始使用本项目

推荐使用 Visual Studio Code 打开本项目，利用其 Remote Development 扩展功能，在开发容器中进行开发。

也可以直接使用 Docker 运行开发容器

## 通过开发容器打开本项目

### 前提条件

1. 安装 [Visual Studio Code](https://code.visualstudio.com/)
2. 安装 [Remote Development 扩展包](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
3. 安装 [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### 使用步骤

1. 打开 Visual Studio Code
2. 点击左侧活动栏的 "Remote Explorer" 图标
3. 在 "Remote Explorer" 面板中，点击右上角的 "Open Folder in Container..."
4. 选择本项目的根目录
5. VS Code 将自动构建开发容器并连接

### 开发容器流程图

```mermaid
graph TD
    A[安装前提条件
VS Code + Remote Development + Docker] --> B[打开 VS Code]
    B --> C[点击 Remote Explorer 图标]
    C --> D[选择 "Open Folder in Container..."]
    D --> E[选择项目根目录]
    E --> F[VS Code 自动构建开发容器]
    F --> G[连接到开发容器]
    G --> H[开始开发]
```

### 开发容器配置说明

- **基础镜像**: Ubuntu 22.04 + C++ 开发环境
- **安装的工具**: gcc, g++, gdb, cmake, ninja-build, clang, clang-format, clang-tidy, ccache, git, ssh, curl, vim
- **挂载配置**: 项目目录、.ssh 目录、.gitconfig 文件
- **安全配置**: 启用 SYS_PTRACE 权限以支持 gdb 调试

## 使用Docker运行开发容器

### 构建Docker镜像

```bash
# 在项目根目录执行
docker build -f .devcontainer/Dockerfile -t linux-cpp-learning .

# - -f .devcontainer/Dockerfile ：指定使用项目中的 Dockerfile
# - -t linux-cpp-learning ：为镜像命名
# - . ：表示构建上下文为当前目录
```

### 运行开发容器

```bash
# 在项目根目录执行
docker run -it --name linux-cpp-dev -v ${PWD}:/workspace -w /workspace --rm linux-cpp-learning

# - -it ：交互式模式运行容器
# - --rm ：容器退出后自动删除
# - -v $(pwd):/workspace ：挂载当前目录到容器的 /workspace 目录
# - -w /workspace ：设置容器的工作目录为 /workspace
# - linux-cpp-learning ：指定要运行的镜像
```
