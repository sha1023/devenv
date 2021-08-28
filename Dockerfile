# TODO Newest ubuntu... will need to match the machines used by the company
FROM ubuntu:impish-20210722

# TODO What timezone?
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Ansible prereqs?
RUN apt-get update
RUN apt-get -y install python3 python3-nacl python3-pip libffi-dev
# Install ansible
RUN pip3 install ansible

# Vagrant ssh support:
RUN apt-get install -y --no-install-recommends ssh sudo

RUN useradd --create-home -s /bin/bash vagrant
RUN echo -n 'vagrant:vagrant' | chpasswd
RUN echo 'vagrant ALL = NOPASSWD: ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" > /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh
RUN sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers
RUN sed -i -e 's/\(UsePAM \)yes/\1 no/' /etc/ssh/sshd_config

RUN mkdir /var/run/sshd

RUN apt-get -y install openssh-client

EXPOSE 2222

# Copy and run Ansible Playbook:
COPY ansible_setup.yml /home/vagrant/ansible_setup.yml
RUN ansible-playbook /home/vagrant/ansible_setup.yml  

# Copy Bash aliases:
COPY bash_aliases /home/vagrant/.bash_aliases

# Run bash to keep container up indefinitely
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["/usr/sbin/sshd", "-D"]
