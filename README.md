# SwiftDIWeb

A web app (using the Kitura web framework) that uses the `SwiftDIHLP` high-level policy module for all business logic.

## Installation

If you haven't already installed `SwiftDIWeb` via the `SwiftDI` parent project, clone it locally:

```bash
$ git clone https://github.com/alexbasson/SwiftDIWeb.git
$ cd SwiftDIWeb
```

## Docker

`SwiftDIWeb` runs in a Docker container; if you don't already have Docker, go get and install [Docker for Mac](https://www.docker.com/products/docker). Once you have Docker installed, you can install the Docker container used for this project:

```bash
$ docker run -itv $(pwd):/SwiftDI --name SwiftDI -w /SwiftDI -p 8089:8089 -p 8090:8090 -p 5984:5984 twostraws/server-side-swift /bin/bash
```

This creates a Docker container named 'SwiftDI', containing the Swift runtime as well as some other software (such as MySQL) you may want to use later. It also performs some port mapping that will allows us to access the web app running in the container from our local browser.

The basic Docker commands you'll need to run `SwiftDIWeb` include:

- `$ docker start SwiftDI`: Starts the Docker container.
- `$ docker attach SwiftDI`: Attaches the Docker container to the current terminal session. You may have to hit Enter a few times before getting the Linux command line prompt.
- `$ docker ps`: Shows all the currently running Docker containers.
- `$ docker ps -a`: Shows all the locally available Docker containers, whether they are currently running or not.
- `$ exit`: From within the container, exits out back to the Mac's terminal and stops the Docker container.

## Building and Running

To build `SwiftDIWeb`, first start and attach the `SwiftDI` Docker container. From within the container:

```bash
$ cd SwiftDIWeb
$ swift build
$ ./.build/debug/SwiftDIWeb
```

The first time you run `swift build`, it will take a minute or two, as it has to fetch all of the dependencies. Future builds will take just a few seconds.

## Testing

As of this writing, the Swift Package Manager does not support testing executable Swift packages on Linux. For this reason, `SwiftDIWeb` has no tests. This is also why the repositories used by `SwiftDIWeb` have been extracted into a separate non-executable Swift library package, `SwiftDIWebRepositories`.
