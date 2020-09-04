FROM fedora

RUN dnf update -y
RUN dnf install -y \
  git \
  ripgrep \
  python3 \
  python3-dnf \
  python3-pip \
  vim

RUN pip install --upgrade pip
RUN pip install "ansible>=2.0,<3.0"

RUN mkdir /sheepdoge-test

WORKDIR /sheepdoge-test

ADD tasks ./tasks
ADD vars ./vars
ADD tests/* ./

RUN chmod u+x test.sh
