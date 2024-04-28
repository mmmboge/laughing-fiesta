FROM python:3.11-alpine3.19
# Environment variables
ENV PACKAGES=/usr/local/lib/python3.11/site-packages
ENV PYTHONDONTWRITEBYTECODE=1
ENV TIME_ZONE=Asia/Shanghai
ENV BASE_DIR="/home/"

WORKDIR /$BASE_DIR

COPY docs/ docs/
COPY overrides/ overrides/
COPY mkdocs.yml .
COPY requirements.txt .

RUN \
  apk upgrade --update-cache -a \
&& \
  apk add --no-cache \
    cairo \
    freetype-dev \
    git \
    git-fast-import \
    jpeg-dev \
    openssh \
    tini \
    zlib-dev \
&& \
  apk add --no-cache --virtual .build \
    gcc \
    libffi-dev \
    musl-dev 

RUN pip install -r requirements.txt

EXPOSE 8000
ENTRYPOINT ["/sbin/tini", "--", "mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]