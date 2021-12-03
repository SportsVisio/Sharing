# Kinesis Video Steam Consumer Daemon

Daemon utility that continuously consumes the configured Kinesis Video stream.

## Prerequisites
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/)

> Note: This repository requires passing Linter and Unit Tests before committing and pushing respectively. This is achieved with [Husky](https://www.npmjs.com/package/husky) integration with `package.json`

## Spinning up virtual environment

```bash
$ vagrant up
```
> Note: This takes *a while* and will produce some benign red-text messages.

```bash
$ vagrant ssh
```

> IMPORTANT: There is a `.env.example` file that will be copied to a local, untracked `.env` file when the VM spins up for the first time. *You must fill in your AWS credentials here* for the application to be able to connect to AWS services. This file is n

## Running the Consumer App
The application lives in `/var/www`, a mounted virtual drive to the local file system. The code within this repository is mounted in that directory at startup (see `vagrantfile` for volume definitions).

```bash
$ npm run start
```

# Streaming with AWS Docker GStreamer
This virtual environment can also be used to stream videos into Kinesis for local testing and development. To achieve this Docker is used within the VM to spin up an AWS image, [Amazon Kinesis Video Streams CPP Producer](https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp), for streaming directly to Kinesis from either a static file (covered here) or a Network Camera following the documentation. 

## Prerequisites
* IAM Credentials
* Sample media in the `/sample_video` folder in MKV/MOV/EBML format
* Running virtual environment (see above)

## First time setup only; register IAM Credentials on the VM
```bash
$ vagrant ssh
$ aws configure
```
> NOTE: Be sure to choose `us-east-1 ` as your region or streaming will not work correctly. Choose defaults for any other options.

## Authenticate with ECR to get access to Docker image
```bash
$ aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 546150905175.dkr.ecr.us-west-2.amazonaws.com/kinesis-video-producer-sdk-cpp-amazon-linux
```

## Pull Docker image (Ubuntu)
```bash
$ sudo docker pull 546150905175.dkr.ecr.us-west-2.amazonaws.com/kinesis-video-producer-sdk-cpp-amazon-linux:latest
```

## Run Docker image
```bash
sudo docker run -it --network="host" -v /var/www/sample_video:/video 546150905175.dkr.ecr.us-west-2.amazonaws.com/kinesis-video-producer-sdk-cpp-amazon-linux /bin/bash
```
See [AWS Documentation here](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/examples-gstreamer-plugin.html#examples-gstreamer-plugin-docker) for other OS options

## Set environment vars in container
```bash
export LD_LIBRARY_PATH=/opt/awssdk/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/downloads/local/lib:$LD_LIBRARY_PATH
export PATH=/opt/awssdk/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/downloads/local/bin:$PATH
export GST_PLUGIN_PATH=/opt/awssdk/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/downloads/local/lib:$GST_PLUGIN_PATH
export AWS_DEFAULT_REGION=us-east-1
```
> NOTE: Do this every time the container is started

## Run streamer sample app against local file
```bash
AWS_ACCESS_KEY_ID=YOUR_ID AWS_SECRET_ACCESS_KEY=YOUR_KEY ./kvs_gstreamer_audio_video_sample sportsVisio /video/sample.mkv
```
> NOTE: Be *sure to change the placeholders* in the line above with your IAM credentials and local video filename.