FROM amazonlinux

RUN yum -y update \
    && yum -y install httpd \
    && yum install amazon-linux-extras -y \
    && amazon-linux-extras | grep php \
    && amazon-linux-extras enable php7.4  \
    && yum -y clean metadata \
    && yum -y install php php-common php-pear \
    && yum -y install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip} 


WORKDIR /var/www/html

ENV DEVOPS=SuperMario

RUN  echo "Hello, <?php echo getenv('DEVOPS'); ?>"  > /var/www/html/index.php

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80