# TODO Newest ubuntu... will need to match the machines used by the company
FROM ubuntu:impish-20210722

# TODO What timezone?
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Ansible prereqs?
RUN apt-get update
RUN apt-get -y install python3 python3-nacl python3-pip libffi-dev
# Install ansible
RUN pip3 install ansible


# Copy and run Ansible Playbook:
COPY ansible_setup.yml /home/vagrant/ansible_setup.yml
RUN ansible-playbook /home/vagrant/ansible_setup.yml  

# vagrant setup
COPY vagrant_setup.yml /home/vagrant/vagrant_setup.yml
RUN ansible-playbook /home/vagrant/vagrant_setup.yml  

# Copy Bash aliases:
COPY bash_aliases /home/vagrant/.bash_aliases
RUN chown vagrant /home/vagrant/.bash_aliases
RUN chgrp vagrant /home/vagrant/.bash_aliases

EXPOSE 2222

# Run bash to keep container up indefinitely
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["/usr/sbin/sshd", "-D"]
