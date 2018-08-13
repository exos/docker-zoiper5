FROM ubuntu:latest

ARG USER
ARG UID

RUN apt-get --assume-yes update && \
	apt-get --assume-yes install libxss1 libgconf-2-4 libnss3 libasound2 libgtk2.0-0 lsb-release wget apt-transport-https xterm pulseaudio libpulse-dev && \
	useradd -u $UID -m $USER

RUN mkdir -p /home/$USER/.config && \
	chown -R $USER:$USER /home/$USER/.config

ADD zoiper5_5.2.19_x86_64.deb /tmp
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/zoiper5_5.2.19_x86_64.deb; \
    apt-get -yf install && \
    rm /tmp/zoiper5_5.2.19_x86_64.deb && \
    apt-get clean

ENV PULSE_SERVER /run/pulse/native

USER $USER

CMD zoiper5 
