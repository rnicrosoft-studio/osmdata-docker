FROM debian:11
ENV OSMDATA_VERSION="4e368be0f4ff67f9fdab20e4707e7d7d76301eaa"

#LABEL maintainer="mritd <mritd@linux.com>"
LABEL Name=OSMData Version=${OSMDATA_VERSION}

# we use the Asia/Shanghai timezone by default, you can be modified
# by `docker build --build-arg=TZ=Other_Timezone ...`
ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}

# RUN apk upgrade \
#     && apk add bash tzdata \
#     && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
#     && echo ${TZ} > /etc/timezone \
#     && rm -rf /var/cache/apk/*
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y tzdata wget \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone



# === master/init.sh ===
RUN apt-get install -y \
    apache2 \
    bc \
    certbot \
    cimg-dev \
    cmake \
    g++ \
    gdal-bin \
    git \
    jekyll \
    jq \
    libgdal-dev \
    libosmium2-dev \
    libproj-dev \
    make \
    osmium-tool \
    python3-gdal \
    python3-pyosmium \
    rsync \
    ruby-json \
    ruby-sqlite3 \
    spatialite-bin \
    sqlite3 \
    tmux \
    unzip \
    zip \
    zsh

# === servers/update-planet.yml ===
RUN apt-get install -y \
    bc \
    gdal-bin \
    git \
    jq \
    osmcoastline \
    osmium-tool \
    python3-pyosmium \
    rsync \
    spatialite-bin \
    sqlite3 \
    unzip \
    zip
#     wget !!!

# === update-osmdata.yml ===
RUN apt-get install -y \
    bc \
    gdal-bin \
    git \
    jq \
    osmcoastline \
    osmium-tool \
    postgis \
    postgresql-13 \
    postgresql-13-postgis-3 \
    postgresql-13-postgis-3-scripts \
    python3-gdal \
    python3-pyosmium \
    rsync \
    spatialite-bin \
    sqlite3 \
    unzip \
    zip
# RUN 
#     - [ systemctl, stop, postgresql ]
#     - [ systemctl, disable, postgresql ]
#     - [ ldconfig ]

# === update-anomalies.yml ===
# RUN apt-get install -y \
#     - bc
#     - git
#     - jq
#     - osmium-tool
#     - python-gdal
#     - python3-pyosmium
#     - rsync
#     - spatialite-bin
#     - sqlite3
#     - unzip
#     - zip
# mounts:
#     - [ sdb, /mnt ]

# === update-low-planet.yml ===
# RUN apt-get install -y \
#     git \
#     osmium-tool
# mounts:
#     - [ sdb, /mnt ]

RUN apt-get clean

# === master/init.sh ===
COPY ./master/init.sh /tmp/
RUN chmod +x /tmp/init.sh \
    && /tmp/init.sh

ENV USER=robot



#VOLUME /data
VOLUME ["/data", "/mnt/data", "/home/robot"]
# ENTRYPOINT [""]
