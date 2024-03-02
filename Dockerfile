# 基础镜像
FROM node:16

# 设置工作目录
WORKDIR /app

# 设置代理
ENV http_proxy=http://proxy-server:proxy-port
ENV https_proxy=http://proxy-server:proxy-port

# 将 package.json 和 package-lock.json 文件复制到工作目录
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 安装全局依赖 nodemon
RUN npm install -g nodemon

# 将项目的其他文件复制到工作目录
COPY . .

# 暴露端口，以便外部访问你的应用
EXPOSE 3000

# 使用定义的 npm 命令启动服务
CMD [ "npm", "run", "start" ]
