FROM    debian:stretch

#       Install Dependencies

RUN     apt update && apt -y install nginx php-fpm wget git apt-transport-https
RUN     wget -q -O - https://updates.atomicorp.com/installers/atomic | bash
RUN     apt update && apt -y install ossec-hids-server

#       Install App

COPY    . /var/www/html/ossec-wui
RUN     chown -R root:www-data /var/www/html/ossec-wui
RUN     find /var/www/html/ossec-wui -type d -exec chmod 0550 "{}" \;
RUN     find /var/www/html/ossec-wui -type f -exec chmod 0440 "{}" \;

#       Configure Nginx

RUN     mv /var/www/html/ossec-wui/docker/nginx-default /etc/nginx/sites-enabled/default
RUN     mv /var/www/html/ossec-wui/docker/start.sh /start.sh
RUN     rm -rf /var/www/html/ossec-wui/docker
RUN     chmod +x /start.sh

CMD     "/start.sh"
