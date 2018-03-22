FROM registry.fedoraproject.org/fedora:28

ENV LANG C.UTF-8

RUN dnf -y update

RUN dnf -y install git \
                   python3 \
		   python3-virtualenv \
		   python2-virtualenv

RUN virtualenv --python=python3.6 /opt/appdaemon

RUN /opt/appdaemon/bin/pip install "appdaemon>=3.0"

RUN mkdir -p /conf

RUN groupadd -g 6002 appdaemon
RUN useradd --uid 6002 --gid appdaemon --home-dir /opt/appdaemon --no-create-home --shell /usr/bin/bash appdaemon
RUN chown -R appdaemon:appdaemon /conf

VOLUME /conf
EXPOSE 8124
EXPOSE 8125
USER appdaemon
WORKDIR /opt/appdaemon
ENTRYPOINT ["/opt/appdaemon/bin/appdaemon", "-c", "/conf"]

# Local Variables:
# indent-tabs-mode: nil
# End:
