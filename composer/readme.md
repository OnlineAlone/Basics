

```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```


```
sudo php composer.phar config -g github-oauth.github.com 9e5aecf37388b5f3f0c333a4d43158ec188c4544
sudo php composer.phar update --no-plugins --no-scripts

sudo php composer.phar install --no-plugins --no-scripts
sudo php composer.phar update --no-plugins --no-scripts

```
