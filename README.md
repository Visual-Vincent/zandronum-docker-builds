# Zandronum Docker Builds
Scripts for building Zandronum for specific Linux distros with the help of Docker containers.

## How to use
1. Install [Docker](https://docs.docker.com/get-docker/)
2. Enter the directory of the Zandronum version which you would like to build
    ```shell
    cd zan3.2
    ```
3. Execute the `build-*.sh` script of your choice (where `*` is the OS you want to build for)
    ```shell
    ./build-AlmaLinux-10.sh
    ```

## Building the client binaries
By default the script builds only the server binaries. If you would like to build the client binaries as well, set the environment variable `ZAN_BUILD_CLIENT` to `1` before running the script.

```shell
ZAN_BUILD_CLIENT=1 ./build-AlmaLinux-10.sh
```

## Extracting the binaries
To retrieve the binaries from the resulting Docker image, you may utilize the `tools/extract-bin.sh` script to extract them into an uncompressed `.tar` file:

```shell
# Extract client binaries
tools/extract-bin.sh client zandronum:3.2-almalinux10 /path/to/destination/zandronum3.2-client.tar

# Extract server binaries
tools/extract-bin.sh server zandronum:3.2-almalinux10 /path/to/destination/zandronum3.2-server.tar
```