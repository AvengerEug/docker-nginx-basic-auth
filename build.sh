
opts="docker_build
"

TAG=${TAG:-'latest'}
PORT=${PORT:-'8080'}
USERNAME=${USERNAME:-'root'}
PASSWORD=${PASSWORD:-'root'}


docker_build() {
  
  containerId=$(docker ps | grep docker-nginx | grep -v grep | awk '{print $1}')
  echo $containerId
  if [ -n "$containerId" ]; then
    echo "Stop docker-nginx image"
    docker stop $containerId
  fi

  dockerId=$(docker images | grep docker-nginx | awk {'print $3'})
  echo $dockerId
  if [ -n "$dockerId" ]; then
    echo "Delete docker nginx-basic-auth-proxy"
    docker rmi $dockerId -f
  fi

  echo “------ build docker images nginx-basic-auth-proxy:$TAG-----------------------”
  docker build -t docker-nginx:$TAG .

  echo "------ docker run docker-nginx:$TAG---------------------"
  nohup docker run -p $PORT:80 -e USERNAME=$USERNAME -e PASSWORD=$PASSWORD docker-nginx:$TAG &
}

usage() {
  echo "USAGE: $0" option key

  echo -e "\nOptions":
  for opt in $opts; do
    echo "   ${opt}"
  done
  
  echo -e ""
}

case "$1" in 
  docker_build)
    docker_build
    ;;
  *)
  
    usage
    ;;
esac
