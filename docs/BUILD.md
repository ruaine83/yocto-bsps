# How to Build a BSP

Instructions to build a BSP from this Repository

## Before You Start

The build process can take a while. Please make sure that you have time and do not plan to interrupt the process.

Prerequisites:

* `docker` installed
  * User must have access to start/stop containers
* A build directory for local builds
  * **MUST** be a local directory. Bitbake cannot build within an NFS or other type of remote-mounted folder
    * This is because it would severely saturate any network connection with traffic to the point of uselessness
  * Must be a absolute path. `./` and `~/` are not allowed
  * Edit the `build-bsp` folder to change the build location
  * The build script will link `./build` to the local folder if at all possile
* A few gigabytes on the disk that the build directory is on, as well as a couple on the disk that holds this repo for the artifacts.
  * Artfacts directory definition must be a absolute path. `./` and `~/` are not allowed

### Folders

Artifacts will be placed in:

`${PWD}/artifacts/<yoto version>/<target product>/`

For example, for a Scarthgap build for a Raspberry Pi 4, the artifacts will be in

`${PWD}/artifacts/scarthgap/pr-raspberrypi4/`

## Build a BSP

The process is relatively simple. All you need to do is run the `build-bsp` script.

It will ask which device you wish to build the BSP for, and will then do all of the prep-work before starting the build process.

Once the build is finished, the output image(s) will be copied into [the artifacts folder](./artifacts).

Upon completion, the BSP is ready to load.

``` shell

$ ./build-bsp 

# ... Will show Requirements download and install ...


Choose a target product:
1) pr-beaglev
2) pr-raspberrypi0
3) pr-raspberrypi3
4) pr-raspberrypi4
5) pr-raspberrypi5
6) raspberrypi4
Enter selection [1-6]:
