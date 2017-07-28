Docker image for Chef Supermarket
=================================

This Dockerfile installs and configure the Chef Supermarket.


## How to use this image

### Pull the image from Docker hub

```
docker pull sunggun/chef-supermarket
```

### Run the Container

Run :
```bash
docker run -d --privileged \
  --name chef-supermarket \
  -p 443:443 \
  sunggun/chef-supermarket
```

Please check the log when you run/start/restart the chef-supermarket. It takes a while until fully startup.
```bash
docker logs -f chef-supermarket
```

### Using volume for data storage
The Dockerfile defines mount points i order to support storing config, data ,and data backup in your storage.

* `/etc/supermarket` : Chef Supermarket home
* `/var/opt/supermarket` : Data directory for all components


```bash
docker run -d --privileged  \
  --name chef-supermarket  \
  -v <your-chef-supermarket-home-directory>:/etc/supermarket:rw  \
  -v <your-data-directory>:/var/opt/supermarket:rw  \
  -h <your-hostname>  \
  -p 443:443  \
  sunggun/chef-supermarket:3.1.22
```

## Access to the Chef Manage Console

You can access and login to the chef manage console through web browser. 
```
https://<your-host>
```
please use user name `admin` and password `admin123` to login. and don't forget to reset password and key once you login.


## Build the Image

Build latest version : current latest is 3.1.22
```bash
docker build -t chef-supermarket:latest -t chef-supermarket:3.1.22 .
```

To build the `chef-supermarket` image with specific version such as `3.1.22`, you need to pass `CHEF_SUPERMERKET_VERSION` and `CHEF_SUPERMARKET_DOWNLOAD_SHA256` build-arg.
Please find the `VERSION` and `SHA256` for `Ubuntu Linux 14.04 x86_64` from <https://downloads.chef.io/chef-supermarket>

```bash
docker build \
  --build-arg CHEF_SUPERMERKET_VERSION=3.1.22 \
  --build-arg CHEF_SUPERMARKET_DOWNLOAD_SHA256=2d44adb9b52eed57dceccb852a228af35004ca63752a9ff3a961cb3282949153 \
  -t chef-supermarket:3.1.22 \
  .
```

For my workflow :
```bash
docker build \
  --build-arg CHEF_SUPERMERKET_VERSION=3.1.22 \
  --build-arg CHEF_SUPERMARKET_DOWNLOAD_SHA256=2d44adb9b52eed57dceccb852a228af35004ca63752a9ff3a961cb3282949153 \
  -t sunggun/chef-supermarket:3.1.22 \
  .
```
