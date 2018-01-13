FROM debian:stable

RUN apt-get -y update && \ 
    apt-get -y dist-upgrade && \
    apt-get -y install cups foomatic-db-compressed-ppds openprinting-ppds samba-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/cupsd && \
    cupsctl --remote-admin --share-printers && \
    echo "ServerAlias *" >> /etc/cups/cupsd.conf && \
    useradd -m -G lp,lpadmin -U print && \
    echo print:print  | chpasswd 

CMD ["/usr/sbin/cupsd", "-f" ]
