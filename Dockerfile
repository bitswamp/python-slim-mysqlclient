# stage 1 - install build dependencies and build mysqlclient wheel
FROM python:3.6.8-slim AS build-wheel

RUN apt update && apt install -y build-essential default-libmysqlclient-dev git

# target mysql version can be changed here
ARG MYSQLCLIENT_VERSION=v1.4.4
RUN git clone --branch ${MYSQLCLIENT_VERSION} --depth 1 https://github.com/PyMySQL/mysqlclient-python

WORKDIR /mysqlclient-python

# build binary wheel with static dependencies -- can be installed elsewhere without libmysqlclient-dev
RUN python setup.py --static bdist_wheel

RUN mkdir /wheel
RUN mv /mysqlclient-python/dist/*.whl /wheel

# stage 2 - install mysqlclient from wheel
FROM python:3.6.8-slim AS install-wheel

# copy and install wheel from stage 1
COPY --from=build-wheel /wheel /wheel
RUN pip install --no-index --find-links=/wheel mysqlclient
