package { "apache2" : ensure => installed }
->
service { "apache2" : ensure => running }
->
package { "php5" : ensure => installed }
->
package { "mysql-server" : ensure => installed }
->
service { "mysql" : ensure => running }
->
package { "php5-mysql" : ensure => installed }
package { "libapache2-mod-php5" : ensure => installed }
package { "php5-mcrypt" : ensure => installed }

exec { "mysqladmin -u root password abcd1234 && touch /tmp/file1" :
                       path => "/usr/bin",
                       creates => "/tmp/file1",
 }

exec { "wget https://raw.githubusercontent.com/roybhaskar9/chefwordpress-1/master/wordpress/files/default/mysqlcommands && touch /tmp/file2" :
        path => "/usr/bin",
        cwd => "/var",
        creates => "/tmp/file2",
}
exec { "mysql -uroot -pabcd1234 < /var/mysqlcommands && touch /tmp/file3" :
                 path => "/usr/bin",
                 creates => "/tmp/file3",
}
exec { "wget https://wordpress.org/latest.zip && touch /tmp/fil4" :
                   path => "/usr/bin",
                   cwd => "/var",
                   creates => "/tmp/fil4",
}
->
package { "unzip" : ensure => installed }
->
exec { "unzip /var/latest.zip && touch /tmp/file5" :
            path => "/usr/bin",
            creates => "/tmp/file5",
            cwd => "/var",
}

exec { "cp -R /var/wordpress/* /var/www/html && touch /tmp/file6" :
                  path => "/bin",
                  creates => "/tmp/file6",
}
exec { "wget https://raw.githubusercontent.com/roybhaskar9/chefwordpress-1/master/wordpress/files/default/wp-config-sample.php -O wp-config.php && touch /tmp/file7" :
               path => "/usr/bin",
               cwd => "/var/www/html",
}
->
exec { "service apache2 restart" :
        path => "/usr/bin",
}
file {"/var/www/html/index.html": ensure => absent }
