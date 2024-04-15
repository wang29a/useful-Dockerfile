FROM ubuntu
RUN apt-get -y update && \
  apt-get -y install \
  build-essential \
  clang-14 \
  clang-format-14 \
  clang-tidy-14 \
  cmake \
  doxygen \
  git \
  pkg-config \
  zlib1g-dev \
  libelf-dev \
  libdwarf-dev
RUN apt-get install -y make
RUN apt-get install -y git curl htop man vim tmux sudo
RUN apt-get install -y bear
RUN apt-get install -y gdb

RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get -y update && \
 apt-get -y install software-properties-common && \
 apt-get -y update && \
 apt-add-repository ppa:fish-shell/release-3 && \
 apt-get -y update && \
 apt-get -y install fish

ARG USER=z
ARG GROUP=z
ARG PASS=z
ENV HOME=/home/${USER}
ENV CODE=${HOME}/code
ENV TERM=screen-256color
RUN \
 groupadd ${GROUP} \
 && useradd -g ${GROUP} -m ${USER} \
 && (echo "${USER}:${PASS}" | chpasswd) \
 && gpasswd -a ${USER} sudo \
 && mkdir -p ${CODE} \
 && chown -R ${USER}:${GROUP} ${CODE}
COPY ./.tmux.conf ${HOME}
COPY ./.vimrc ${HOME}
USER ${USER}
WORKDIR ${CODE}
