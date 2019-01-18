# TL; DR

## FROM

The first step is define what image we want to use to build our API. In this study i'm using the latest LTS (long term support) version 8 of node available from the Docker Hub.

```Dockerfile
FROM node:8
```

## WORKDIR

We need create a directory inside of the container for hold our application code. For this will be using the struction **WORKDIR**.

```Dockerfile
WORKDIR app
```

If the WORKDIR doesn’t exist, it will be created a generic folder for us. And we can use this instruction in multiple times inside of our Dockerfile.

## NPM

Multiple tutorials in the internet show to us a command to install the NPM inside of our container, but this steps is not required anymore. This image comes with Node.js and NPM already installed so the next thing we need to do is to install your app dependencies using the npm binary.

## COPY

The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>.
  
So we need copy the package.json AND package-lock.json, insed of our WORKDIR.

```Dockerfile
COPY package*.json ./
```

After that we use the copy instruction to copy our application source.

```Dockerfile
COPY . .
```

## RUN

The RUN instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.

So use this command to install the project dependencies.

```Dockerfile
RUN npm install
```

## EXPOSE

The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.

The EXPOSE instruction does not actually publish the port. It functions as a type of documentation between the person who builds the image and the person who runs the container, about which ports are intended to be published. To actually publish the port when running the container, use the -p flag on docker run to publish and map one or more ports, or the -P flag to publish all exposed ports and map them to high-order ports.

```Dockerfile
EXPOSE 8080
```

## CMD

The main purpose of a CMD is to provide defaults for an executing container. Here we will use the basic npm start.

```Dockerfile
CMD [ "npm", "start" ]
```

## References

- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/#dockerignore-file)
