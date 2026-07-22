# Quickstart to dockerizing a Node API

The goal of this project is training you in how to get a Node.js application running into a Docker container.

This guide assumes that you have a working Docker installation and a basic understanding of how a Node.js application is structured.

## Creating the Node.js app

We need to create a directory to save all files of our project. So:

```shell
$ mkdir quickstart-dockerizing-a-node-api
$ cd quickstart-dockerizing-a-node-api
```

After create the directory, we need a **package.json** to create a Node.js API:

```shell
$ npm init
```

After that install the express dependency:

```shell
$ npm i express --save
```

Edit and create a new script to start the node server in the **package.json**:

```json
"start": "node index.js",
```

Now we have a **package.json**:

```json
{
  "name": "quickstart-dockerizing-a-node-api",
  "version": "0.0.1",
  "description": "A repository containing an article and example to start my docker studies",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/malaquiasdev/quickstart-dockerizing-a-node-api.git"
  },
  "keywords": [
    "Docker",
    "node",
    "study",
    "api"
  ],
  "author": "Mateus Malaquias",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/malaquiasdev/quickstart-dockerizing-a-node-api/issues"
  },
  "homepage": "https://github.com/malaquiasdev/quickstart-dockerizing-a-node-api#readme",
  "dependencies": {
    "express": "^4.19.2"
  }
}
```

### Creating a sample API

Now create a **index.js** file that defines a web app using the Express.js framework:

```javascript
const express = require('express');

const PORT = 8080;
const HOST = '0.0.0.0';

const app = express();

app.get('/', (req, res) => {
  res.send('Hello world\n');
});

app.listen(PORT, HOST);

console.log(`Running on http://${HOST}:${PORT}`);
```

## Creating a Dockerfile

A Dockerfile is a text document that contains all the commands that a user could call on the command line to assemble an image. Using `docker build` users can create an automated build that executes several command-line instructions in succession.

Create an empty file called Dockerfile:

```shell
$ touch Dockerfile
```

Open this file with your favorite text editor. And lets go!

```shell
$ vim Dockerfile
```

Your Dockerfile should look like this:

```Dockerfile
# syntax=docker/dockerfile:1

# Node runtime version
FROM node:24-alpine

# Set NODE_ENV to production so npm and the app itself skip dev-only
# dependencies and behavior (e.g. Express serves leaner error pages)
ENV NODE_ENV=production

# The api directory inside of the docker image
WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are
# copied to the docker image. --chown=node:node makes the non-root "node"
# user (see below) the owner of these files from the start
COPY --chown=node:node package*.json ./

# Install the API dependencies with NPM using the lockfile for reproducible
# builds. --omit=dev skips devDependencies since this is a production image
RUN npm ci --omit=dev && npm cache clean --force

# Copy the project to the docker image, keeping the same ownership
COPY --chown=node:node index.js ./

# Run the container as the unprivileged "node" user (built into the
# official image) instead of root, reducing the blast radius of a
# container compromise
USER node

# Informe to the docker, the door let's use
EXPOSE 8080

# Let Docker (and orchestrators like Kubernetes/ECS) know whether the app
# is actually serving requests, not just whether the process is alive
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://127.0.0.1:8080', (res) => process.exit(res.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"

CMD ["npm", "start"]
```

[TL; DR Docker attributes](https://github.com/malaquiasdev/quickstart-dockerizing-a-node-api/blob/master/docker-attributes.md)

## Building your image

Go to the directory that has your Dockerfile and execute the following command to build the Docker image.

```shell
$ docker build -t <your username>/node-hello-world .
```

## Run the image

Running your image with `-d` runs the container in `detached` mode, leaving the container running in the background. The `-p` flag redirects a public port to a private port inside the container.

```shell
$ docker run -p 8080:8080 -d <your username>/node-hello-world
```

## Test

Open your web browser or postman application and make a request to the URL above:

```
http://localhost:8080
```

Or use the curl application inside the terminal.

```shell
$ curl -i localhost:8080
```

You need to see a simple Hello world message.

I hope this tutorial helped you get up  and running a simple Node.js application on Docker.

##  BONUS: Creating Docker ignore file

Before creating a docker image it's intresting to make a file named .dockerignore in the root directory. When this file exists the CLI modifies the context to exclude files and directories that match patterns in it. This will help us avoid unnecessarily sending large or sensitive files and directories to the image when using ADD or COPY command.

So create the file and edit it:

```shell
$ touch .dockerignore
$ vim .dockerignore
```

Write the content above:

```
node_modules
npm-debug.log*
.git
.gitignore
Dockerfile
.dockerignore
*.md
.env*
```

This will prevent your local modules and debug logs, as well as your `.git` history, the `Dockerfile`/`.dockerignore` themselves, markdown docs, and any `.env` files (which may contain secrets), from being copied into your Docker image.

## References

- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Dockerizing a Node.js web app](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/)
- [Trying Docker for the First Time 📖 Many Learnings!](https://www.youtube.com/watch?v=2tvbkCW4OIY)

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Contributors

See also the list of [contributors](https://github.com/malaquiasdev/quickstart-dockerizing-a-node-api/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
