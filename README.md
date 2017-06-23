# docker-debian-stretch
Welcome to my repository for using my 32-bit and 64-bit Docker images based on Debian Stretch.  These Docker images are stored on [Docker Hub](https://hub.docker.com/r/jhsu802701/).

## Incompatibility Warnings
* In the ideal case, your host machine's processor supports 64 bits AND full virtualization (which means meeting the VT-x or AMD-v standard).  In this case, use a 64-bit OS and a 64-bit Docker image.  If you use a 32-bit Docker image in a 64-bit host, you may find that the tmux multiplexing tool and PostgreSQL do not work properly in Docker.
* If your host machine's processor supports only 32 bits OR does not support full virtualization (VT-x or AMD-v), then you must use a 32-bit OS and a 32-bit Docker image.  While you can run a 32-bit virtual environment on a 64-bit host, you may find that the tmux multiplexing tool does not work properly in Docker.
* Certain advanced Rails projects (such as https://github.com/rubygems/rubygems.org) require the use of software that is only available for64-bit systems.  Thus, such projects are incompatible with 32-bit systems.  (This is why no 32-bit Docker image for this specific project is provided.)

## Other Warnings
* When you start the Rails server from an app in your Docker container, enter the command "rails s -b 0.0.0.0". The "-b 0.0.0.0" is ESSENTIAL for viewing your app from the web browser on your host machine. If you simply enter "rails s" or "rails server", you will NOT be able to view your app from the web browser on your host machine.
* Viewing PostgreSQL data on the host machine with pgAdmin requires that the Docker container's PostgreSQL setup be configured to provide output to the IP address 0.0.0.0.  Docker images are preconfigured to take care of this.
* PostgreSQL and other servers are dormant until you or a script acts to start them.  Remember that because there is no virtual machine to boot up, no mechanism is provided to automatically turn on servers.
* PAY ATTENTION to the port numbers when you use your web browser or pgAdmin to view the Rails apps running on your Vagrant boxes. No two apps may share the same port number. As a result, the port number to use in your web browser will NOT always be 3000, and the port number to use in pgAdmin will NOT always be 5432 or 15432. The use of different port numbers for different Docker images allows you to work on multiple projects simultaneously.

## Prerequisites
* If you have not already done so, please install Git.
* If you have not already done so, please install Docker.  For 64-bit Docker, use Docker's official instructions.  For 32-bit Docker, follow the instructions at https://github.com/jhsu802701/docker-32bit-debian-stretch-install to install Docker.

### Editions available
* Minimal (min): This consists of the basic features provided by the debootstrap command plus Sudo, Nano, tmux, and a regular user named "winner".
* Developer (dev): This is the Minimal Editon plus Git, Heroku Toolbelt, Ansible, Chef, Puppet, NVM, Node, and rbenv.  This is a building block for the rbenv-* editions.
* Jekyll rbenv (rbenv-jekyll): This is the Jekyll Docker image for creating static web sites.  It comes with rbenv, the latest version of Ruby, and the latest version of the Jekyll gem.
* General rbenv (rbenv-general): This is a general purpose Docker image for using Ruby on Rails.  It comes with the latest versions of Ruby and Rails plus the versions of Rails used in the last few versions of the Rails Tutorial Sample App.
* RubyMn rbenv (rbenv-rubymn): This includes the versions of Ruby and Rails used by https://github.com/rubymn/ruby.mn-website .
* RubyMn2 rbenv (rbenv-rubymn2): This includes the versions of Ruby and Rails used by https://github.com/jhsu802701/ruby_mn_site .
* RubyGems rbenv (rbenv-rubygems): This includes the versions of Ruby on Rails used by https://github.com/rubygems/rubygems.org .  Due to this project's reliance on software that is only available for 32-bit systems, ONLY the 64-bit version of this Docker image is available.
* LoseMoneyFast rbenv (rbenv-losemoneyfast): This includes the versions of Ruby on Rails used by https://github.com/jhsu802701/losemoneyfast .

### Scripts For Using Images
Just enter sh (script name) to proceed.

| Docker image        | Script for Using 32-bit Image | Script for Using 64-bit Image |
|---------------------|-------------------------------|-------------------------------|
| min                 |32min.sh                       | min.sh                        |
| dev                 |32dev.sh                       | dev.sh                        |
| rbenv-jekyll        |32rbenv-jekyll.sh              | rbenv-jekyll.sh
| rbenv-general       |32rbenv-general.sh             | rbenv-general.sh              |
| rbenv-rubymn        |32rbenv-rubymn.sh              | rbenv-rubymn.sh               |
| rbenv-rubymn2       |32rbenv-rubymn2.sh             | rbenv-rubymn2.sh              |
| rbenv-rubygems      |N/A                            | rbenv-rubygems.sh             |
| rbenv-losemoneyfast |32rbenv-losemoneyfast.sh       | rbenv-losemoneyfast.sh        |

## Building Docker Images
* 32-bit: https://github.com/jhsu802701/docker-32bit-debian-stretch-build
* 64-bit: https://github.com/jhsu802701/docker-64bit-debian-stretch-build
