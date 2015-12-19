FROM ubuntu:trusty
MAINTAINER Daniel R. Kerr <daniel.r.kerr@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
 && apt-get install -qq -y git \
 && apt-get install -qq -y python-dev python-pip python-pillow \
 && apt-get install -qq -y texinfo texlive-base texlive-fonts-extra texlive-fonts-recommended texlive-latex-base texlive-latex-extra texlive-latex-recommended \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN pip install pybtex sphinx sphinx_rtd_theme sphinxcontrib-blockdiag sphinxcontrib-programoutput

RUN git clone https://github.com/google/fonts.git /opt/googlefonts \
 && mkdir -p /usr/share/fonts/truetype/google-fonts/ \
 && find /opt/googlefonts -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; \
 && fc-cache -f > /dev/null \
 && rm -rf /opt/googlefonts \
 && git clone https://github.com/jterrace/sphinxtr.git /opt/sphinxtr

VOLUME ["/root/docs"]

WORKDIR /root/docs
CMD ["make all"]