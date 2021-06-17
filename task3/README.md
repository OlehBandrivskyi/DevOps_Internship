# Task 3: Docker

Все задания выполнялись в AWS EC2 на базе Ubuntu


**Условие:**
>1.Install docker. (Hint: please use VMs or Clouds  for this.)
>EXTRA 1.1. Write bash script for installing Docker. 

**Решение:**
Bash скрипт для установки Docker на Ubuntu [[extraTask1.1.sh](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d52bd94a043aa8ba969e35007eab90b2412e805e/task3/extraTask1.1.sh)]


**Условие:**
>2.Find, download and run any docker container "hello world". (Learn commands and parameters to create/run docker containers.
>EXTRA 2.1. Use image with html page, edit html page and paste text: <Username> Sandbox 2021

**Решение:**
Запуск контейнера "hello world":
```
docker pull hello-world
```

Установка веб-сервера apache:
```
docker run -d --name my-apache-page -p 8080:80 httpd:2.4
```

Вход в контейнер для изменения страницы:

```
docker exec -it 8759b2355e4 /bin/bash
```

Результат и сохранение контейнера в образ:

![img5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img5.jpg)

![img6](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img6.jpg)


**Условие:**
>3.1. Create your Dockerfile for building a docker image. Your docker image should run any web application (nginx, apache, httpd). Web application should be located inside the docker image. 
>EXTRA 3.1.1. For creating docker image use clear basic images (ubuntu, centos, alpine, etc.)
>3.2. Add an environment variable "DEVOPS=<username> to your docker image 
>EXTRA 3.2.1. Print environment variable with the value on a web page (if environment variable changed after container restart - the web page must be updated with a new value)

**Решение:**

Докерфайл доступен по ссылке [[Dockerfile](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d52bd94a043aa8ba969e35007eab90b2412e805e/task3/Dockerfile)]

Результат:


![img7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img7.jpg)


![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img8.jpg)

![img9](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img9.jpg)

![img10](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img10.jpg)


**Условие:**
>4.Push your docker image to docker hub (https://hub.docker.com/). Create any description for your Docker image. 
>EXTRA 4.1. Integrate your docker image and your github repository. Create an automatic deployment for each push. (The Deployment can be in the “Pending” status for 10-20 minutes. This is normal).

**Решение:**

![img11](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img11.jpg)

Репозиторий на DockerHub доступен по ссылке [[bandrivskyi/task3](https://hub.docker.com/repository/docker/bandrivskyi/task3)]

Создание автоматического деплоя:
![img12](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/6f1b77c7dc21c4bff8be60feec3e80378a9efdd2/task3/img/img12.jpg)


**Условие:**
>5.Create docker-compose file. Deploy a few docker containers via one docker-compose file. 
>-   first image - your docker image from the previous step. 5 nodes of the first image should be run;
>-	second image - any java application;
>-	last image - any database image (mysql, postgresql, mongo or etc.).
>Second container should be run right after a successful run of a database container.
>	EXTRA 5.1. Use env files to configure each service.

**Решение:**

Docker-Compose доступен по ссылке [[docker-compose.yml](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/a757c8ad73cad5e0daff9d3765a13f1b5f64fca1/task3/docker-compose.yml)]

.env.example файл доступен по ссылке [[.env.example](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/a757c8ad73cad5e0daff9d3765a13f1b5f64fca1/task3/.env.example)]

Развертывание:


![img15](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/f706071d36093b877a8af2025a43aad57656d64c/task3/img/img15.jpg)

