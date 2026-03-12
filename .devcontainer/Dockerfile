# 使用最新的 Ubuntu 22.04 C++ 开发容器镜像作为基础
FROM mcr.microsoft.com/devcontainers/cpp:1-ubuntu-22.04

# 配置国内阿里云 apt 源
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# 更新软件包列表并安装必要的开发工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    # C++ 编译器和工具链
    build-essential \
    gcc-11 \
    g++-11 \
    gdb \
    \
    # 构建系统
    cmake \
    ninja-build \
    \
    # 代码质量工具
    clang \
    clang-format \
    clang-tidy \
    cppcheck \
    \
    # 性能分析工具
    valgrind \
    \
    # 语言和字体支持
    locales \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    xfonts-wqy \
    \
    # 其他实用工具
    ccache \
    git \
    ssh \
    curl \
    wget \
    vim \
    nano \
    tmux \
    \
    # 清理缓存以减小镜像大小
    && rm -rf /var/lib/apt/lists/*

# 设置 locale 为 UTF-8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

# 设置环境变量
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# 设置 gcc/g++ 11 为默认编译器
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-11 \
    --slave /usr/bin/gcov gcov /usr/bin/gcov-11

# 配置 ccache 以提高编译性能
RUN mkdir -p /etc/ccache \
    && echo 'max_size = 5G' > /etc/ccache/ccache.conf \
    && echo 'compiler_check = content' >> /etc/ccache/ccache.conf

# 配置 pip 国内源（阿里云）
RUN mkdir -p ~/.pip \
    && echo '[global]' > ~/.pip/pip.conf \
    && echo 'index-url = https://mirrors.aliyun.com/pypi/simple/' >> ~/.pip/pip.conf \
    && echo 'trusted-host = mirrors.aliyun.com' >> ~/.pip/pip.conf

# 设置工作目录
WORKDIR /workspace