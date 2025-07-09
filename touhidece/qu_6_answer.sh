#Install httpd
dnf install httpd

#Enable and start the service
systemctl enable --now httpd

#Create a VirtualHost for the Domain and include the default Index Page path
<VirtualHost MACHINE_IP:80>
	ServerName station1.marry.com
	DocumentRoot /var/www/marry.com
<VirtualHost/>

==================================================================================================
# yum install -y httpd
# chkconfig httpd on
# cd /var/www/html
# wget http://ip/dir/example.html
# cp example.com index.html
# vim /etc/httpd/conf/httpd.conf
NameVirtualHost 192.168.0.254:80
<VirtualHost 192.168.0.254:80>
DocumentRoot /var/www/html/
ServerName station.domain40.example.com
</VirtualHost>
