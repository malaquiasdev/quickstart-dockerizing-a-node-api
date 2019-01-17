# Dockerizing a Node API

The goal of this project is training how to get a Node.js application into a Docker container.

This guide assumes that you have a working Docker installation and a basic understanding of how a Node.js application is structured.

## Creating the Node.js app

We need create a directory to save all files of our project. So:

```
mkdir study-dockerizing-a-node-api
cd study-dockerizing-a-node-api
```

After create the directory, we need a **package.json** to create a Node.js API:

```
npm init
```

After that install the express dependencie:

```
npm i express --save
```

Now we have a **package.json**:

```
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

```
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
