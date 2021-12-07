# TheEditor

All images build with this repository will be available on [Docker Hub](https://hub.docker.com/u/starostka).

## Images

Detailed images description (every directory matches single image, directory name represents image name).

How to run image? For testing it could be:

```shell
docker run -it starostka/editor:[tag] /bin/zsh
```

For work suggested is **docker-compose.yml** file where configuration will be more tidy. Programming projects should
be mounted from host to **/root/workspace/** directory:

```yml
version: '3.8'

services:
  editor:
    image: starostka/editor:[tag]
    deploy:
      replicas: 1
      resources:
        limits:
          memory: 2G
    volumes:
      - [path_to_projects]:/srv/workspace
```

## Dotfiles and changes to images
When modifying dotfiles in the container. Update the dotfiles in this repository found in the dotfiles directory.
