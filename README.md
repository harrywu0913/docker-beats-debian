# Beats - The Lightweight Shippers of the Elastic Stack

[Beats](https://www.elastic.co/beats)

[Filebeat](https://github.com/elastic/beats/tree/master/filebeat)

# 基于library/debian:buster-slim构建filebeat镜像

## 7.3.2.1
  - 多阶段构建
  - 基于library/golang:1.12.4-stretch 构建 filebeat-7.3.2.1 编译环境
  - 基于library/debian:buster-slim 构建 filebeat-7.3.2.1 镜像
