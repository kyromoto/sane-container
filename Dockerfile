FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
ENV SANE_CONFIG_DIR=/usr/local/etc/scanbd/sane.d/

RUN apt-get update && apt-get install -y \
    scanbd \
    sane \
    sane-utils \
    usbutils

RUN cp -R /etc/sane.d /usr/local/etc/scanbd && \
    sed '/^net\|^ *net/!s/^/#/' /etc/sane.d/dll.conf > /etc/sane.d/dll.conf && \
    sed -e 's/# connect_timeout = 60/connect_timeout = 3/' -e 's/# localhost/localhost/' /etc/sane.d/net.conf > /etc/sane.d/net.conf && \
    echo 'SUBSYSTEM == "usb", ATTR {idVendor} == "04c5", ATTR {idProduct} == "159f", ACTION == "add", GROUP = "scanner", MODE = "0664"' > /etc/udev/rules.d/11-fujitsu-ix1500.rules


CMD ["/usr/local/sbin/scanbd", "-df", "-c", "/usr/local/etc/scanbd/scanbd.conf"]