FROM python:3.8
LABEL org.opencontainers.image.source https://github.com/openzim/khan-chef

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends locales-all ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app
COPY requirements.txt /app/
RUN pip3 install -U pip
RUN pip3 install -U youtube-dl numpy
RUN pip3 install -r /app/requirements.txt
COPY *.py /app/
RUN printf "#!/bin/bash\ncd /app && python ./sushichef.py \$@\n" > /usr/local/bin/chef && chmod +x /usr/local/bin/chef

CMD ["chef", "-h"]
