# TODO Newest ubuntu... will need to match the machines used by the company
FROM ubuntu:impish-20210722

# TODO What timezone?
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Ansible prereqs?
RUN apt-get update
RUN apt-get -y install python3 python3-nacl python3-pip libffi-dev
# Install ansible
RUN pip3 install ansible
RUN ansible-galaxy collection install community.postgresql

# vagrant setup
COPY vagrant_setup.yml /root/vagrant_setup.yml
RUN ansible-playbook /root/vagrant_setup.yml

# Copy and run general utilities playbook:
COPY general_setup.yml /root/general_setup.yml
RUN ansible-playbook /root/general_setup.yml

# Copy Bash aliases:
COPY bash_aliases /home/vagrant/.bash_aliases
RUN chown vagrant /home/vagrant/.bash_aliases
RUN chgrp vagrant /home/vagrant/.bash_aliases

COPY vimrc /home/vagrant/.vimrc
RUN chown vagrant /home/vagrant/.vimrc
RUN chgrp vagrant /home/vagrant/.vimrc

EXPOSE 2222

# Run bash to keep container up indefinitely
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["/usr/sbin/sshd", "-D"]
