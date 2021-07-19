# Task 8: Project


## Оглавление

- [Описание](#описание)
- [Подготовка GitLab](#подготовка-gitlab)
- [Настройка CI](#настройка-ci)
- [Подготовка Kubernetes оркестрации](#подготовка-kubernetes-оркестрации)
- [Deploy в Kubernetes](#deploy-в-kubernetes)
- To be continued...

---

## Описание

Разработка проекта ведется совместными усилиями с @AlexandrRekun [[github.com/rekusha](https://github.com/rekusha/exadel)] 

Рабочий репозиторий [[@GitLab/task8-project](https://gitlab.com/group1434/task8-project)]


### Постановка задачи:

**Важные моменты:**

1. В первую очередь это работа в командах. Таск идет на команду, не сдал (не смог пояснить, как работает) один - не сдали все в команде.

2. После того как вы закончите работу в группах вам нужно будет провести презентацию инфраструктуры.

**Tasks:**

1. Выбрать себе приложение из списка (выбирайте посвежее): https://github.com/unicodeveloper/awesome-opensource-apps
2. Выбрать CI/CD. Вы можете выбирать любой вариант, но мы рекомендуем посмотреть вот тут:  
 https://pages.awscloud.com/awsmp-wsm-dev-workshop-series-module3-evolving-to-continuous-deployment-ty.html 
3. Выбрать Cloud провайдера для вашей инфраструктуры.


**Основные вещи на которые стоит обратить внимание:**


* Итеграция с git;
* Настройка CI/CD;
* Приложение/я должны быть в контейнерах;
* Контроль и бэкап баз данных по расписанию;
* Настройка логирования и мониторинга для указанных сервисов;
* Настроить безопасный доступ;
* В качестве оркестрации использовать Kubernetes (рекомендуется клауд провайдер);
* Проект должен быть документирован, step-by-step гайды по развертыванию с нуля;
* EXTRA: Настройка SonarQube.


---


## Подготовка GitLab 

В качестве инструмента для CI было решено использовать GitLab.

### Часть l

1. Регистрация аккаунта [[https://gitlab.com/users/sign_up](https://gitlab.com/users/sign_up)]

2. Создание репозитория под проект:

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img2.jpg)


### Часть ll

1. Для работы раннеров понадобится токен, его можно получить следующим образом: 

Репозиторий -> Settings -> CI/CD -> Runners -> Specific runners {registration token}

2. Установка раннера на удаленный инстанс или ВМ: [[Installing GitLab Runner](https://docs.gitlab.com/runner/install/linux-repository.html#installing-gitlab-runner)] 

3. Настройка раннеров

Создано два раннера: на системе, в докере.

<details><summary>runners</summary>

![img3](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img3.jpg)

![img4](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img4.jpg)

</details>

Cозданные раннеры должны отобразится в GitLab. Репозиторий -> Settings -> CI/CD -> Runners -> Available specific runners:

![img5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img5.jpg)

### Часть lll

Для проверки первого раннера использован шаблонный пайплайн (CI/CD -> Editor): 
<details><summary>.gitlab-ci.yml</summary>

```
before_script:
  - echo "Before script section"
  - echo "For example you might run an update here or install a build dependency"
  stage: build
  script:
    - echo "Do your build here"
  tags:
    - amz2Shell

test1:
  stage: test
  script:
    - echo "Do a test here"
    - echo "For example run a test suite"
  tags:
    - amz2Shell

test2:
  stage: test
  script:
    - echo "Do another parallel test here"
    - echo "For example run a lint test"
  tags:
    - amz2Shell

deploy1:
  stage: deploy
  script:
    - echo "Do your deploy here"
  tags:
    - amz2Shell
```
</details>

**Результат:**

<details><summary>screenshoots</summary>

![img6](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img6.jpg)

![img7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img7.jpg)

![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img8.jpg)

</details>

Аналогичным образом проверка докер-раннера: 
 
.gitlab-ci.yml
```
check:
  stage: build
  script:
     - echo "Docker verion:"
     - docker -v 
  tags:
     - amz2Docker1
```

![img9](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img9.jpg)  


---


## Настройка CI

### Часть l

В качестве opensource проекта использованы исходники [[wagtail](https://github.com/wagtail/wagtail)] (CMS на Django).

Репозиторий на GitLab имеет следующую структуру: 
<details><summary>tree </summary>

```
.
├── app
│   ├── app
│   │   ├── __init__.py
│   │   ├── settings
│   │   │   ├── base.py
│   │   │   ├── dev.py
│   │   │   ├── __init__.py
│   │   │   └── production.py
│   │   ├── static
│   │   │   ├── css
│   │   │   │   └── app.css
│   │   │   └── js
│   │   │       └── app.js
│   │   ├── templates
│   │   │   ├── 404.html
│   │   │   ├── 500.html
│   │   │   └── base.html
│   │   ├── urls.py
│   │   └── wsgi.py
│   ├── Dockerfile
│   ├── home
│   │   ├── __init__.py
│   │   ├── migrations
│   │   │   ├── 0001_initial.py
│   │   │   ├── 0002_create_homepage.py
│   │   │   └── __init__.py
│   │   ├── models.py
│   │   ├── static
│   │   │   └── css
│   │   │       └── welcome_page.css
│   │   └── templates
│   │       └── home
│   │           ├── home_page.html
│   │           └── welcome_page.html
│   ├── manage.py
│   ├── requirements.txt
│   └── search
│       ├── __init__.py
│       ├── templates
│       │   └── search
│       │       └── search.html
│       └── views.py
├── .gitignore
└── .gitlab-ci.yml
```

</details>

Ознакомится с пайплайном можно по ссылке - [[.gitlab-ci.yml](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/master/task8/.gitlab-ci.yml)]  

*Поскольку не указан тег-раннера, используется настроенный по умолчанию раннер из предыдущего раздела.*

Результат выполнения: 

![img10](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/114766b5b34fc6a3cb13bcb1824d3c8b04dec83e/task8/img/img10.jpg)

### Часть ll

CI состоит из трех этапов: 
- build
- test
- deploy

На первом этапе происходит сборка артефакта из исходников. 

```
 docker build -t $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:latest app/
```

Собранный артефакт отправляется на тестирование, которое состоит из двух работ:

1) Юнит-тест контейнера позволяет удостоверится, что приложение в контейнере присутствует. 

```
docker run -i $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:latest python3 manage.py test
```

2) Проверим развертывание и доступность нашего приложения посредством проверки корректности ответа на запрос к нему.

```
...
response=$( curl --write-out "%{http_code}\n" --silent --output /dev/null $RUNNNER_INSTANCE_URL)
if [ $response -eq $STATUS_CODE ]; then echo 'app response is correct'; else echo 'Something is wrong'; exit 1; fi
...
```

### Часть lll

После успешного билда и проверки артефактов их следует надежно сохранить в ожидании последующих манипуляций. Для этого был использован репозиторий GitLab для приватных докер-образов. 

Отправляем наш артефакт в репозиторий:

```
docker push $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:latest
```

Для версионности и возможности последующего доступа к предыдущим версиям сборки в репозиторий также добавляется артефакт с тегом [ID-коммита(SHORT_SHA)]:

```
docker tag $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:latest $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:$CI_COMMIT_SHORT_SHA
docker push $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:$CI_COMMIT_SHORT_SHA
```

Просмотреть доступные артефакты можно следующим образом GitLab -> Repository -> Packages & Registries -> Container Registry 

<details><summary>examples</summary>

![img11](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/114766b5b34fc6a3cb13bcb1824d3c8b04dec83e/task8/img/img11.jpg)

![img12](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/114766b5b34fc6a3cb13bcb1824d3c8b04dec83e/task8/img/img12.jpg)

</details>


---


## Подготовка Kubernetes оркестрации

### Часть l

В качестве клауд провайдера было решено использовать GoogleCloud. 

После создания аккаунта и активации службы ComputerEngine(Virtual Machines) необходимо установить google cloud sdk. [[Installation instructions](https://cloud.google.com/sdk/docs/install)] 

Установка на RedHot

```
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
```

```
sudo yum install google-cloud-sdk
```

Далее необходимо выполнить инициализацию:

```
gcloud init
```

![img13](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img13.jpg)

![img14](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img14.jpg)

Активируем Kubernetes:

```
gcloud services enable container.googleapis.com
```

![img16](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img16.jpg)

### Часть ll

Устанавливаем kubectl (RedHot):

```
sudo yum install kubectl
```

![img15](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img15.jpg)


Устанавливаем Helm Charts (версию архива под свою OS можно найти здесь - [[github/helm/releases](https://github.com/helm/helm/releases/tag/v3.6.3)] )

```
wget https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz
tar -xf helm-v3.6.3-linux-amd64.tar.gz
cd linux-amd64/
sudo mv helm /bin/
```

### Часть lll

Создаем кластер (по умолчанию используется e2-medium): 

``` 
gcloud container clusters create cluster_name
```
![img17](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img17.jpg)
![img18](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img18.jpg)

Пример структуры проекта:

```
.project-deploy-helm
│
├── Chart.yaml
├── templates
│   ├── deployment.yaml
│   └── service.yaml
└── values.yaml
```

Деплой проекта:

``` 
helm update --install app project-deploy-helm/
```
![img23](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img23.jpg)

В качестве примера произведен деплой PostgreSQL

![img25](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/b84553e87cefe576b79c1be5122b5b99905d1583/task8/img/img25.jpg)

- удаление проекта:

``` 
helm uninstall app
```
- удаление кластера:

``` 
gcloud container clusters delete project8 
```

### Часть lV

Подготовка секретов


---

## Deploy в Kubernetes 


---

*To be continued...*