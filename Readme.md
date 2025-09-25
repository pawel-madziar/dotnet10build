# dotnet10build
docker image for building dotnet 10 lambda functions

## Build image
Run inside Dockerdile folder
```sh
docker build --no-cache -t ghcr.io/pawel-madziar/dotnet10build:latest .
```

## Push image to github packeges repo

### Login to GitHub docker repo
```sh
echo xxxx-github-api-key | docker login ghcr.io -u pawel-madziar --password-stdin
```

### push image
```sh
docker push ghcr.io/pawel-madziar/dotnet10build:latest
```

### pull image
```sh
docker pull ghcr.io/pawel-madziar/dotnet10build:latest
```



