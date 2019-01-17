# Dockerizing a Node API

The goal of this project is training how to get a Node.js application into a Docker container.

This guide assumes that you have a working Docker installation and a basic understanding of how a Node.js application is structured.

## Creating the Node.js app

We need create a directory to save all files of our project. So:

```shell
mkdir study-dockerizing-a-node-api
cd study-dockerizing-a-node-api
```

After create the directory, we need a **package.json** to create a Node.js API:

```shell
npm init
```

After that install the express dependencie:

```shell
npm i express --save
```

Now we have a **package.json**:

```json
{
  "name": "study-dockerizing-a-node-api",
  "version": "0.0.1",
  "description": "A repository containing an article and example to start my docker studies",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/mmalaquiasdev/study-dockerizing-a-node-api.git"
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
    "url": "https://github.com/mmalaquiasdev/study-dockerizing-a-node-api/issues"
  },
  "homepage": "https://github.com/mmalaquiasdev/study-dockerizing-a-node-api#readme",
  "dependencies": {
    "express": "^4.16.4"
  }
}
```

## Creating a sample API

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

## Creating Docker ignore file

Before creating a docker image it's intresting to make a file named .dockerignore in the root directory. When this file exists the CLI modifies the context to exclude files and directories that match patterns in it. This will help us avoid unnecessarily sending large or sensitive files and directories to the image when using ADD or COPY command.

So create the file and edit it:

```shell
touch .dockerignore
vim .dockerignore
```

Write the content above:

```shell
node_modules
npm-debug.log
```

This will prevent your local modules and debug logs from being copied into your Docker image.



## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Contributors

See also the list of [contributors](https://github.com/mmalaquiasdev/study-dockerizing-a-node-api/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
