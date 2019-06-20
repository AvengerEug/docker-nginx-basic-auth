# Docker ngxin basic auth

## 实现原理
1. 拉取带linux环境的nginx镜像(这里推荐 nginx:1.11.9-alpine镜像)
2. 在制作镜像时安装basic auth的依赖: apache2-utils
3. 将配置好的nginx配置文件 copy至镜像中ngxin能访问到镜像的地方
4. 使用docker自带功能(ENTRYPOINT), 在镜像启动时执行指定shell脚本, 将用户自定义的用户名和密码设置到nginx basic auth的指定地方
5. 使用build.sh脚本完成镜像的自动build、run过程(可指定宿主机端口、镜像tag、auth username、auth password)
