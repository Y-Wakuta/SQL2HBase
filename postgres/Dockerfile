FROM ubuntu

WORKDIR /home
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENV POSTGRES_HOME=/usr/local/pgsql
ENV PGLIB=$POSTGRES_HOME/lib
ENV PGDATA=$POSTGRES_HOME/data
ENV MANPATH="$MANPATH":$POSTGRES_HOME/man
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH":"$PGLIB"

RUN apt-get update

#jdkを取得
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

#sourceでpostgresを取得
RUN wget https://ftp.postgresql.org/pub/source/v10.2/postgresql-10.2.tar.gz
RUN gunzip postgresql-10.*.tar.gz
RUN tar xf postgresql-10.2.tar

#pgxs用ファイルを取得
RUN apt-get install -y postgresql-server-dev-all
RUN apt-get install -y postgresql-common
RUN apt-get install -y postgresql-client-*
RUN apt-get install -y postgresql

#JDBCを取得
WORKDIR ./postgresql-10.2/contrib
RUN apt-get install -y git
RUN git clone git://github.com/atris/JDBC_FDW.git

#postgresをビルド
WORKDIR ./JDBC_FDW
RUN make USE_PGXS=1 clean
RUN ln -s /usr/lib/jvm/java-8-oracle/jre/lib/amd64/server/libjvm.so /usr/lib/libjvm.so
RUN apt install -y mlocate
RUN updatedb
RUN locate libjvm.so
RUN apt-get install -y gcc
RUN make USE_PGXS=1 install

COPY ./drill-jdbc-all-1.12.0.jar /opt

RUN ../../configure --without-readline

COPY ./start_postgres.sh /docker-entrypoint-initdb.d/

#これはまだ起動した後に手動で入力してる
RUN /etc/init.d/postgresql start 