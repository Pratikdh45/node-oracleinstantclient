FROM oraclelinux:7-slim as builder
WORKDIR /opt/oracle/instantclient_21_4
RUN yum install -y unzip
RUN curl -o basic.zip https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip && \
    curl -o sql.zip https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip && \
    curl -o sdk.zip https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sdk-linux.x64-21.4.0.0.0dbru.zip && \
    unzip -d /opt/oracle basic.zip && \
    unzip -d /opt/oracle sql.zip && \
    unzip -d /opt/oracle sdk.zip && \
    rm -rf *.zip && \
    echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig && \
    cd /opt/oracle/instantclient_21_4 && find . -type f | sort && \
    ln -s /opt/oracle/instantclient_21_4/libclntsh.so.21.1 /usr/lib/libclntsh.so && \
    ln -s /opt/oracle/instantclient_21_4/libocci.so.21.1 /usr/lib/libocci.so && \
    ln -s /opt/oracle/instantclient_21_4/libociicus.so /usr/lib/libociicus.so && \
    ln -s /opt/oracle/instantclient_21_4/libnnz21.so /usr/lib/libnnz21.so && \
    ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 && \
    ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 && \
    ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2



# Get a new image
FROM --platform=linux/amd64 node:12.19.1-buster-slim
RUN npm install -g pm2

# Copy the Instant Client libraries, licenses and config file from the previous image
COPY --from=builder /opt/oracle/instantclient_21_4 /opt/oracle/instantclient_21_4
COPY --from=builder /opt/oracle/instantclient_21_4 /usr/lib/
COPY --from=builder /opt/oracle/instantclient_21_4 /usr/share/
COPY --from=builder /etc/ld.so.conf.d/oracle-instantclient.conf /etc/ld.so.conf.d/oracle-instantclient.conf


RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get install -y tcpdump curl libaio1 && \
    apt-get -y autoremove && apt-get -y clean && \
    ldconfig


ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_4:$LD_LIBRARY_PATH
ENV PATH=$LD_LIBRARY_PATH:$PATH
ENV SQLPATH=$LD_LIBRARY_PATH:$SQLPATH
ENV TNS_ADMIN=/opt/oracle/instantclient_21_4
