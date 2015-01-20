# Headphones on Centos 6.5 docker container

## Docker container for running headphones.
  
  Access via https://localhost:8181
  SSL certificate are enabled with a self-signed certificate.

## Requires 
  Docker 1.3+

## Container setup

  When running these items should be exposed or mapped.
  
  Volumes
    - /var/logs/                for log files
  
    - /mnt/media                mapped to the media files

  Map Ports
    - 8081 ->  8181         Headphones page
  
    - 9001 ->  46091         supervisor page

## To build container

  > docker build --rm=true -t="headphones" .

## To run container

  > docker run --name headphones -v  /mnt/media:/container/media -v /mnt/downloads/completed"]="container/downloads"  -p 46091:9091 -p 8181:8181

## Backup config file

  > CONT=`docker ps -a | grep headphones | awk '{ print $1 }'`
  > docker cp $CONT:/opt/headphones/config.ini $PWD/