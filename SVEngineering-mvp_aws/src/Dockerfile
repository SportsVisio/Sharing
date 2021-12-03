FROM python:3.7.5-slim

WORKDIR /home/kinesis_consumer/src

COPY /requirements.txt .

RUN pip3 install -r requirements.txt

COPY checkpoint/ ./checkpoint
COPY destination/ ./destination
COPY kinesisvideo/ ./kinesisvideo
COPY utils/ ./utils
COPY __init__.py .

# command to run on container start
CMD [ "python3", "./kinesisvideo/continuous_consumer.py" ]