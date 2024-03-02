# 第一阶段：使用完整的 Node 镜像构建应用
FROM node:16 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# 第二阶段：只从小的基础镜像开始，并复制第一阶段的构建结果
FROM node:16-alpine
WORKDIR /app
# 只复制构建出的应用和依赖，删除了所有源代码和构建工具
COPY --from=build /app ./
EXPOSE 3000

# 设置环境变量
ENV http_proxy=http://127.0.0.1:7890
ENV https_proxy=http://127.0.0.1:7890
ENV no_proxy="localhost,127.0.0.1"

CMD [ "npm", "start" ]
