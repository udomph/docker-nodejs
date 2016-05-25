FROM centos:7

MAINTAINER udomph "elep.ls@gmail.com"

ENV NODE_VERSION 6.2.0

# Add repo
RUN rm -f /etc/yum.repos.d/*
ADD CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
ADD CentOS-CR.repo /etc/yum.repos.d/CentOS-CR.repo

# Install EPEL release
RUN yum -y install epel-release.noarch
# Install Development Toos
RUN yum -y groupinstall "Development tools"

# Add Node.js repo
RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -

# Install Node.js
RUN yum -y install nodejs

# Install loopback
RUN npm install -g strongloop

# Install Oracle Client
RUN yum -y install libaio
COPY oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
COPY oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
RUN yum -y install /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
RUN npm install -g oracledb

# Install Postgresql client
RUN npm install -g loopback-connector-postgresql

# Install MSSQL Client
RUN npm install -g loopback-connector-mssql

# Install MySQL Client
RUN npm install -g loopback-connector-mysql

# Clean up
RUN yum clean -y all

CMD ["/bin/bash"]
