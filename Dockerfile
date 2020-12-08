FROM ubuntu:20.04

RUN apt-get update && apt-get install -y wget tar unzip gcc make g++ bzip2 curl

# MeCab & MeCab-ipadic
RUN apt-get install -y mecab libmecab-dev mecab-ipadic-utf8

# CRF++
RUN wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7QVR6VXJ5dWExSTQ" -O CRF++-0.58.tar.gz
RUN tar -xzf CRF++-0.58.tar.gz
RUN cd CRF++-0.58; ./configure; make; make install; ldconfig

# Cabocha
RUN DOWNLOAD_URL="https://drive.google.com`curl -c cookies.txt \
    'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU' \
    | sed -r 's/"/\n/g' |grep id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU |grep confirm |sed 's/&amp;/\&/g'`" \
    && curl -L -b cookies.txt -o /cabocha-0.69.tar.bz2 "$DOWNLOAD_URL"
RUN tar jxf cabocha-0.69.tar.bz2
RUN cd cabocha-0.69; ./configure --with-charset=utf8; make; make install; ldconfig

RUN rm -rf CRF++-0.58.tar.gz CRF++-0.58 cabocha-0.69.tar.bz2 cabocha-0.69
