FROM python:3.11-alpine3.19
# Environment variables
ENV PACKAGES=/usr/local/lib/python3.11/site-packages
ENV PYTHONDONTWRITEBYTECODE=1
ENV TIME_ZONE=Asia/Shanghai
ENV BASE_DIR="/home/"

WORKDIR /$BASE_DIR

COPY docs/ .
COPY overrides .
COPY mkdocs.yml .
COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 8000
ENTRYPOINT ["/sbin/tini", "--", "mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]