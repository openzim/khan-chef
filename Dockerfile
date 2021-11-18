FROM python:3.8
LABEL org.opencontainers.image.source https://github.com/openzim/khan-chef

RUN mkdir -p /app
COPY requirements.txt /app/
RUN pip3 install -r /app/requirements.txt
RUN pip3 install -U youtube-dl
COPY *.py /app/
RUN printf "#!/bin/bash\ncd /app && python ./sushichef.py \$@\n" > /usr/local/bin/chef && chmod +x /usr/local/bin/chef

CMD ["chef", "-h"]
