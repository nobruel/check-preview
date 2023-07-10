FROM python:3.8-alpine

LABEL "com.github.actions.name"="AWS Amplify PR Previews for Public Repository"
LABEL "com.github.actions.description"="This action deploys your AWS Amplify pull request for your public repository"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/nobruel/check-preview.git"
LABEL "homepage"="https://github.com/nobruel/check-preview"
LABEL maintainer="Bruno Daniel Afonso <nobruel@gmail.com>"

ENV AWSCLI_VERSION='1.18.14'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}
RUN apk --no-cache add curl
RUN apk --no-cache add ca-certificates wget
RUN update-ca-certificates
RUN wget --version

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
#B_URL=$1
#
#echo $B_URL
#
#wget -q --spider $B_URL
#
#if [ $? -ne 0 ] ; then
#  echo "URL $B_URL nao existente"
#fi
