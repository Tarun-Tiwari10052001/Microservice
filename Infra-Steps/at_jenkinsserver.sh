#install java 17
sudo apt install openjdk-17-jre-headless

# add jenkins repo and key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

#install jenkins
sudo apt update
sudo apt install jenkins -y

# check jenkins at localhost:8080
# sudo cat /var/lib/jenkins/secrets/initialAdminPassword  (for intial password)
#install suggested plugin

