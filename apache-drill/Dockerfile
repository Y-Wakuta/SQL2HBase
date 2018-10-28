FROM ubuntu

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

COPY ./apache-drill-1.12.0 /opt/apache-drill

RUN apt-get update

#jdkを取得
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

WORKDIR /opt/apache-drill
RUN chmod +x ./bin/*
#RUN ./drill-embedded ひとまずこれは起動してからて入力で。