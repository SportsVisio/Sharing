FROM python:3.7.5-slim

# set the working directory in the container
WORKDIR /home/highlights_processing/

# copy the dependencies file to the working directory
COPY /requirements.txt .

# install dependencies
RUN pip3 install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY src/ .

# command to run on container start
CMD [ "python3", "./get_highlights.py" ]