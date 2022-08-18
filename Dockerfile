FROM ubuntu:18.04

COPY ./mha4mysql-manager-0.58.tar.gz /tmp/
COPY ./mha4mysql-node-0.58.tar.gz /tmp/

RUN build_deps='ssh perl libmodule-install-perl libdbd-mysql-perl libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl make' \ 
    && apt-get update \
    && apt-get install -y $build_deps \
    && tar -zxf /tmp/mha4mysql-node-0.58.tar.gz -C /opt \
    && cd /opt/mha4mysql-node-0.58 \
    && perl Makefile.PL \
    && make \
    && make install \
    && tar -zxf /tmp/mha4mysql-manager-0.58.tar.gz -C /opt \
    && cd /opt/mha4mysql-manager-0.58 \
    && perl Makefile.PL \
    && make \
    && make install \
    && cd /opt \
    && rm -rf /opt/mha4mysql-* \
    && apt-get clean
    