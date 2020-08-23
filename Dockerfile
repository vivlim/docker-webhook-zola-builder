FROM archlinux:20200705
ARG git_uri
ARG git_branch

RUN useradd -d /home -M -u 1000 zola && chown -R 1000:1000 /home
RUN pacman -Sy --noconfirm git git-lfs python python-pip openssh zola vi
RUN pip install flask

VOLUME /home/out
VOLUME /home/.ssh

COPY ./webhook-listener.py /
COPY ./on_request.sh /

USER 1000
RUN git lfs install

ENV FLASK_APP /webhook-listener.py
ENV FLASK_RUN_HOST 0.0.0.0
ENV GIT_URI $git_uri
ENV GIT_BRANCH $git_branch
EXPOSE 5000
ENTRYPOINT ["flask", "run"]
