# SSH into your Conga with a certificate

pi@freewifi:~ $ ssh-keygen -f ~/.ssh/conga.rsa -t rsa -b 2048
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in conga.rsa.
Your public key has been saved in conga.rsa.pub.
The key fingerprint is:
SHA256:lQqueawMd2XV/Vkh9+tTa5Le7+lNEAFBHb13+QszSO8 pi@freewifi
The key's randomart image is:
+---[RSA 2048]----+
|           .+=o= |
|           o .+.+|
|      .   + . o =|
|     . . + .   =*|
|      . S . o .o*|
|     + o   . =o.+|
|  . + +     .o+=o|
|   + +      .E+o+|
|    o        ..==|
+----[SHA256]-----+

joe ~/.ssh/config
Host conga
	Hostname 192.168.x.y
	User root
	Port 22
	IdentityFile /home/pi/.ssh/conga.rsa


ssh-copy-id -i ~/.ssh/conga.rsa conga

password: @3I#sc$RD%xm^2S&

ssh conga
password: @3I#sc$RD%xm^2S&

mv /root/.ssh/authorized_keys /etc/dropbear/

exit

ssh conga -> ok

## References

https://openwrt.org/docs/guide-user/security/dropbear.public-key.auth