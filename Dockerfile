FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum check-update && \
    yum -y update \
    rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"   \
    yum-config-manager --add-repo http://download.mono-project.com/repo/centos/    \
    yum install -y mono-complete git wget yum-utils    \
    yum clean all
    git clone https://github.com/CoiniumServ/CoiniumServ.git
    cd /CoiniumServ
    git submodule init
    git submodule update
    cd build/release
    sh ./build.sh

EXPOSE 8081

# Simple startup script to avoid some issues observed with container restart
#ADD run-httpd.sh /run-httpd.sh
#RUN chmod -v +x /run-httpd.sh

CMD ["mono /CoiniumServ/bin/Release/CoiniumServ.exe"]
