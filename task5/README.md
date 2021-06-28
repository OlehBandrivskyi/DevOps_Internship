# Task 5: Jenkins

**Условие:**
>1.Установить Jenkins (Jenkins должен быть установлен  в Docker контейнере).
>2.Установить необходимые плагины (если потребуются на ваше усмотрение).

**Решение:**

Установка Jenkins выполнена с рекомендованным набором плагинов. 
Запуск с помощью команды: 

```
docker run -u jenkins:992 -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker -v /home/ec2-user/jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
```

**Условие:**
>3.Настроить несколько билд агентов.

**Решение:**

Билд агенты созданы с помощью Docker в качестве Cloud, для этого в файле /lib/systemd/system/docker.service, заменена строка ExecStart на:

```
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
```

Далее созданы билд агенты:

![img1](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img1.jpg)

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img2.jpg)

![img3](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img3.jpg)


**Условие:**
>4.Создать Freestyle project. Который будет в результате выполнения на экран выводить текущее время.

**Решение:**

Запуск:

![img4](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img4.jpg)

Результат:

![img5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img5.jpg)

**Условие:**
>5.Создать Pipeline который будет на хосте выполнять команду docker ps -a.

**Решение:**

Pipeline для пункта 5 [[Jenkinsfile_5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d3727902f1081444a71cb4dd02069e9c360ccfc7/task5/pipelanes/Jenkinsfile_task5)]

Результат:

![img7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img7.jpg)

**Условие:**
>6.Создать Pipeline который будет выкачивать из вашего репозитория код и будет собирать докер образ из вашего Dockerfile (который вы писали во время знакомства с докером).

**Решение:**

Pipeline для пункта 6 [[Jenkinsfile_6](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d3727902f1081444a71cb4dd02069e9c360ccfc7/task5/pipelanes/Jenkinsfile_task6)]

Результат:

![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img8.jpg)


**Условие:**
>7.Передать переменную PASSWORD=QWERTY! В зашифрованном виде в докер контейнер.


**Решение:**

Pipeline для пункта 7 [[Jenkinsfile_7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d3727902f1081444a71cb4dd02069e9c360ccfc7/task5/pipelanes/Jenkinsfile_task7)]

Результат:

![img9](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img9.jpg)


**Условие:**
>Extra 1. Написать pipeline который будет на дополнительной виртуальной машине запускать докер контейнер из вашего докерфайла.

**Решение:**

Билд агент с меткой *docker_agent_2* был создать на отдельном инстансе EC2. 
Для выполнения pipeline с предыдущего пункта выполнено перенаправление:

```
    agent { label 'docker_agent_2' }
```


**Условие:**
>Extra 2.Написать ансибл скрипт который будет разворачивать дженкинс.

**Решение:**

Плейбук доступен по ссылке [[PlaybookExtra2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d3727902f1081444a71cb4dd02069e9c360ccfc7/task5/playbookextra2.yml)].

Результат:

![img10](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img10.jpg)

**Условие:**
>Extra 2. Развернуть локальный docker registry загрузить в него докер образ, выгрузить докер образ из docker registry и запустить контейнер на окружении (с использованием Jenkinsfile)

**Решение:**

Jenkinsfile доступен по ссылке [[Jenkisfile](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d3727902f1081444a71cb4dd02069e9c360ccfc7/task5/Jenkinsfile)].

Результат:

![img15](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img15.jpg)
![img16](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img16.jpg)
![img17](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img17.jpg)


**Условие:**
>Extra 4. Настроить двухстороннюю интеграцию между Jenkins и вашим Git репозиторием. Jenkins проект будет запускаться автоматически при наличии изменений в вашем репозитории а также в Git будет виден статус последней сборки из дженкинса (успешно/неуспешно/в процессе).

**Решение:**

1.В GitHub создано Access Token и Webhook для Jenkins
2.В Jenkins создано связь с GitHub:

![img18](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img18.jpg)

3.В проекте добавлен триггер сборки на репозиторий
4.Послесборочные операции:
![img19](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img19.jpg)

Результат:
![img20](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img20.jpg)
![img21](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/e4b3c00920926fc878afad4ecfb1f9c275d95ad0/task5/img/img21.jpg)