REPO = 'git@github.com:nickjholmes/repo.git'
SSH = 'ssh -A -l ubuntu'

desc "Bootstrap Puppet on ENV['CLIENT'] with 
	hostname ENV['HOSTNAME']"
task :bootstrap do
	client = ENV['CLIENT']
	hostname = ENV['HOSTNAME'] || client
	commands = <<BOOTSTRAP
sudo hostname #{hostname} && \
sudo echo #{hostname} >/tmp/hostname.tmp && \
sudo cp -vf /tmp/hostname.tmp /etc/hostname && \
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && \
sudo dpkg -i puppetlabs-release-precise.deb && \
sudo apt-get update && sudo apt-get -y install git 
sudo apt-get update && sudo apt-get -y install puppet && \
it clone #{REPO} puppet && \
sudo puppet apply /home/ubuntu/puppet/manifests/site.pp --modulepath=/home/ubuntu/puppet/modules
BOOTSTRAP
	sh "#{SSH} #{client} '#{commands}'"
end
