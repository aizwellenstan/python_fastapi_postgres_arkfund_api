FROM python:3.7-slim
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TERM xterm

RUN apt-get install -y vim less
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# requirements.txtにリストされたパッケージをインストールする
ADD requirements.txt .
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

COPY app ./app
# FastAPIを8000ポートで待機
CMD ["uvicorn", "app.main:APP", "--reload", "--host", "0.0.0.0", "--port", "8000"]