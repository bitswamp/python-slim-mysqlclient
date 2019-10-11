# python-slim-mysqlclient

Python's `mysqlclient` requires `libmysqlclient-dev` libraries to build and install. This image uses a 2-stage Dockerfile to build a `mysqlclient` wheel, so the final image does not require the `libmysqlclient-dev` libraries or build toolchain.

For comparison, the first stage with the dev dependencies produces a 411MB image. The second stage, where the `mysqlclient` wheel is installed, is only 149MB.
