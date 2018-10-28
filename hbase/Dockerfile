FROM ubuntu


ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

COPY ./hbase-1.3.1 /opt/hbase

RUN apt-get update

#jdkを取得
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

WORKDIR /opt/hbase/bin
RUN chmod +x *
#RUN bash start-hbase.sh 現時点では手入力