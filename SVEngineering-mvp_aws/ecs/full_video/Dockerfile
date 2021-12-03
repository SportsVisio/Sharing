FROM python:3.7.5-slim

# update packages
RUN apt-get -y update

#Install ffmpeg for video processing
RUN apt-get install -y ffmpeg

# set the working directory in the container
WORKDIR /home/video_processing/

# copy the dependencies file to the working directory
COPY /requirements.txt .

# install dependencies
RUN pip3 install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY src/ .

# command to run on container start
CMD [ "python3", "./get_full_video.py" ]