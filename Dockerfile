FROM jupyter/datascience-notebook
MAINTAINER dbgannon
RUN pip install --upgrade pip
USER root
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

USER jovyan
COPY bash_profile /home/jovyan/.bash_profile
COPY pubkey.pub /
RUN mkdir /home/jovyan/.ssh
COPY pubkey /home/jovyan/.ssh/.
COPY /pubkey.pub /home/jovyan/.ssh/authorized_keys

USER root
COPY fixonlyjul.jl /home/jovyan/.
COPY installPyCall.jl /home/jovyan/.
COPY finalfix.sh /
RUN /finalfix.sh
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
