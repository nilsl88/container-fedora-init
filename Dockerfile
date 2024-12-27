# Start with the official Fedora base image
FROM fedora:latest

# Install systemd and remove unnecessary services
RUN echo 'max_parallel_downloads=20' | tee -a /etc/dnf/dnf.conf && \
    dnf -y update && \
    dnf -y install systemd procps-ng && \
    dnf clean all && \
    # mask systemd services
    systemctl mask systemd-remount-fs.service dev-hugepages.mount sys-fs-fuse-connections.mount systemd-logind.service getty.target console-getty.service systemd-udev-trigger.service systemd-udevd.service systemd-random-seed.service systemd-machine-id-commit.service

# Configure container init
ENV LANG=C.utf8

# Set stop signal
STOPSIGNAL SIGRTMIN+3

CMD ["/usr/sbin/init"]
