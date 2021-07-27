# Task 8: Project


## Оглавление

- [Описание](#описание)
- [Подготовка GitLab](#подготовка-gitlab)
  - [Регистрация](#)
  - [Раннеры](#)
  - [Тестовый CI](#)
- [Настройка CI](#настройка-ci)
  - [Знакомство с wagtail](#)
  - [Стадии пайплайна](#)
  - [GitLab Container Registery](#)
- [Подготовка Kubernetes оркестрации](#подготовка-kubernetes-оркестрации)
  - [Настройка GoogleCloud](#)
  - [Настройка kubectl](#)
  - [Развертывание кластера и helm](#)
  - [Подготовка секретов](#)
- [Deploy в Kubernetes](#deploy-в-kubernetes)
  - [Предварительная подготовка приложения](#)
  - [Структура Helm](#)
  - [Деплой в кластер](#)
- [Настройка логирования и мониторинга](#)
  - [Логи - сервисы Logging && Error Reporting](#)
  - [Мониторинг](#)
  - [Grafana](#)
- [Интеграция SonarQube](#)
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

### Часть l - регистрация

1. Регистрация аккаунта [[https://gitlab.com/users/sign_up](https://gitlab.com/users/sign_up)]

2. Создание репозитория под проект:

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img2.jpg)


### Часть ll - Раннеры 

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

### Часть lll - Тестовый CI

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

### Часть l - Знакомство с wagtail

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

### Часть ll - Стадии пайплайна

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

### Часть lll - GitLab Container Registery 

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

### Часть l - Настройка GoogleCloud

В качестве клауд провайдера было решено использовать GoogleCloud. 

После создания аккаунта и активации службы ComputerEngine(Virtual Machines) необходимо установить google cloud sdk. [[Installation instructions](https://cloud.google.com/sdk/docs/install)] 

Установка:

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

### Часть ll - Настройка kubectl

Устанавливаем kubectl:

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

### Часть lll - Развертывание кластера и helm

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
│   ├── hpa-v2.yaml
│   └── service.yaml
├── secret.yaml
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

Для доступа к кластеру с помощью gitlab-раннера, необходимо скопировать файл ~/.kube/config по следующему пути:

```
/home/gitlab-runner/.kube/config
```

### Часть lV - Подготовка секретов 

все значения передаваемые для переменных в файле secret.yaml надо конвертировать в base64: 

```
$ echo -n 'admin' | base64
YWRtaW4=
$ echo -n 'B7wItYlHeRR1' | base64
Qjd3SXRZbEhlUlIx
```

Далее переходим в GitLab - Menu (project or group) -> Settings -> CI/CD -> Variables -> Add variable.
Указываем ключ, значение, тип и флажок защиты. 

Созданные переменные:

![img52](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img52.jpg)

Файл secrets.yaml

```
---
apiVersion: v1
kind: Secret
metadata:
  name: task8-secret
type: Opaque
data:
  SQL_USER: $SECRET_USER
  SQL_PASSWORD: $SECRET_PASSWORD
  POSTGRES_USER: $SECRET_USER
  POSTGRES_PASSWORD: $SECRET_PASSWORD
  SECRET_KEY: $SECRET_KEY

```

Создаем секреты для кластера с помощью команды: 

```
kubectl create -f ./secret.yaml
```

---

## Deploy в Kubernetes 

### Часть l - Предварительная подготовка приложения 

Подготавливаем файлы приложения:

```
$ sudo apt install python3-pip python3-venv  
$ python3 -m venv venv  
$ source venv/bin/activate  
$ pip install --upgrade pip  
$ pip install wagtail  
$ wagtail start app  
$ deactivate  
$ rm -r venv/
```

```
$ echo 'psycopg2-binary==2.8.6' >> app/requirements.txt
```

**$ nano app/app/settings/base.py**

```
...
DATABASES = {
    'default': {
        'ENGINE': os.environ.get("SQL_ENGINE"),
        'NAME': os.environ.get("SQL_DATABASE"),
        'USER': os.environ.get("SQL_USER"),
        'PASSWORD': os.environ.get("SQL_PASSWORD"),
        'HOST': os.environ.get("SQL_HOST"),
        'PORT': os.environ.get("SQL_PORT"),
    }
}
...
```

**$ nano app/.env.test** (минимальное тестовое окружение для проверки образа после сборки)

```
DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]
SQL_ENGINE=django.db.backends.sqlite3
SQL_DATABASE=demo_wagtail
SQL_USER=demouser
SQL_PASSWORD=DemoPass

```

Обновляем этапы тестирования в пайплайне:

```
...
unit_test:
  stage: test
  script:
    - docker run -i --env-file app/.env.test -p 8000:8000 $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:latest python3 manage.py test

status_code_test:
  stage: test
  script:
    - docker run -d --env-file app/.env.test -p 8000:8000 --name $TEST_CONTAINER $CI_REGISTRY/$CI_GROUP/$CI_REP_NAME/$APP_NAME:latest
    - sleep 10
    - response=$( curl --write-out "%{http_code}\n" --silent --output /dev/null $RUNNNER_INSTANCE_URL)
    - docker stop $TEST_CONTAINER
    - docker rm $TEST_CONTAINER
    - if [ $response -eq $STATUS_CODE ]; then echo 'app response is correct'; else echo 'Something is wrong'; exit 1; fi
...
```

### Часть ll - Структура Helm

Структура helm проекта из предыдущего раздела доступна по ссылке [[project-deploy-helm]()]

<details><summary>values.yaml </summary>

```
#docker images:
containers:
  db_image: postgres:latest
  app_image: registry.gitlab.com/group1434/task8-project/app:latest
  grafana_image: grafana/grafana

#db default values 
db: 
  name: postgresql-db
  replicas: 1
  storage: 1Gi 
  env:
    postgres_db: demo_wagtail
    secret: task8-secret
  service:
    name: service-postgresql-db
    port: 5432
    targetPort: 5432

#wagtail default values 
app:
  name: wagtail
  env:
    sql_engine: django.db.backends.postgresql_psycopg2
    debug: '"true"'
    allowed_hosts: localhost 127.0.0.1 [::1]
    sql_port: '"5432"'
  service:
    name: service-wagtail
    port: 8000
    targetPort: 8000
  hpa:  
    minReplicas: 2
    maxReplicas: 4
    resource:
      cpu: 70

#grafana default values
grafana: 
  name: grafana
  replicas: 1
  service:
    name: service-grafana
    port: 3000
    targetPort: 3000

```

</details>

<details><summary>templates/deployment.yaml </summary>

```
# PostgreSQL StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ .Values.db.name }}
spec:
  serviceName: {{ .Values.db.name }}-service
  selector:
    matchLabels:
      app: {{ .Values.db.name }}
  replicas: {{ .Values.db.replicas }}
  template:
    metadata:
      labels:
        app: {{ .Values.db.name }}
    spec:
      containers:
        - name: {{ .Values.db.name }}
          image: {{ .Values.containers.db_image }}
          volumeMounts:
            - name: {{ .Values.db.name }}-disk
              mountPath: /data
          env:
            - name: POSTGRES_DB
              value: {{ .Values.db.env.postgres_db }}
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.db.env.secret }}
                  key: POSTGRES_USER
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.db.env.secret }}
                  key: POSTGRES_PASSWORD
        #    - name: POSTGRES_PASSWORD
        #      value: testpassword
        #    - name: PGDATA
        #      value: /data/pgdata
  # Volume Claim
  volumeClaimTemplates:
    - metadata:
        name: {{ .Values.db.name }}-disk
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: {{ .Values.db.storage }}

--- 
# wagtail Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.app.name }}
spec:
  selector:
    matchLabels:
      project: {{ .Values.app.name }}
 # replicas: 2
  template: 
    metadata:
      labels:
        project: {{ .Values.app.name }}
    spec:
      containers:
        - name: {{ .Values.app.name }}
          image: {{ .Values.containers.app_image }}
          env:
            - name: DEBUG
              value: {{ .Values.app.env.debug }}
            - name: DJANGO_ALLOWED_HOSTS
              value: {{ .Values.app.env.allowed_hosts }}
            - name: SQL_ENGINE
              value: {{ .Values.app.env.sql_engine }}
            - name: SQL_DATABASE
              value: {{ .Values.db.env.postgres_db }}
            - name: SQL_USER
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.db.env.secret }}
                  key: SQL_USER
            - name: SQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.db.env.secret }}
                  key: SQL_PASSWORD
            - name: SQL_HOST
              value: {{ .Values.db.service.name }}
            - name: SQL_PORT
              value: {{ .Values.app.env.sql_port }}

---
# Grafana Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.grafana.name }}
spec:
  selector:
    matchLabels:
      project: {{ .Values.grafana.name }}
  replicas: {{ .Values.grafana.replicas }}
  template: 
    metadata:
      labels:
        project: {{ .Values.grafana.name }}
    spec:
      containers:
        - name: {{ .Values.grafana.name }}
          image: {{ .Values.containers.grafana_image }}

```

</details>

<details><summary>templates/hpa-v2.yaml </summary>

```
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: {{ .Values.app.name }}-scaling
spec:
  scaleTargetRef:
    apiVersion: apps/v2beta1v1
    kind: Deployment
    name: {{ .Values.app.name }}
  minReplicas: {{ .Values.app.hpa.minReplicas }}
  maxReplicas: {{ .Values.app.hpa.maxReplicas }}
  metrics:
  - type: Resource
    resource:
      name: cpu
      targetAverageUtilization: {{ .Values.app.hpa.resource.cpu }}

```

</details>

<details><summary>templates/service.yaml </summary>

```
# PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.db.service.name }}
spec:
  selector:
    app: {{ .Values.db.name }}
  type: LoadBalancer
  ports:
    - port: {{ .Values.db.service.port }}
      targetPort: {{ .Values.db.service.targetPort }}

--- 
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.app.service.name }}
spec:
  selector:
    project: {{ .Values.app.name }}
  type: LoadBalancer
  ports:
    - port: {{ .Values.app.service.port }}
      targetPort: {{ .Values.app.service.targetPort }}

--- 
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.grafana.service.name }}
spec:
  selector:
    project: {{ .Values.grafana.name }}
  type: LoadBalancer
  ports:
    - port: {{ .Values.grafana.service.port }}
      targetPort: {{ .Values.grafana.service.targetPort }}

```
</details>

### Часть lll - Деплой в кластер

Для развертывания кластера модифицируем пайплайн, добавив на этапе деплоя еще одно задание:

```
deploy_to_gcloud:
  stage: deploy
  script:
    - helm upgrade --install app project-deploy-helm/

```

После выполнения всех этапов, наш кластер поднимается (или обновляется) на основании описанного в предыдущей части структуры. 

</details>

<details><summary>templates/service.yaml </summary>

![img53]()

![img54]()

![img55]()

![img56]()

</details>
---

## Настройка логирования и мониторинга

Использованный в качестве клауд провайдера GoogleCloud предоставляет значительные возможности для сбора логов и мониторинга кластеров, что устраняет необходимость конфигурации дополнительных внешних сервисов, также присутствует возможность настроить доступ к собранным данным для внешних сервисов с помощью api. 


### Часть l - Логи

#### Сервис Logging

Служба логгирования гугла имеет гибкие возможности для фильтрации потока и поиска голки в стоге сена.

<details><summary>Logs Explorer</summary>

![img39](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img39.jpg)

</details>

Примеры:

<details><summary>лог ошибок для контейнера БД в кластере:</summary>


![img40](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img40.jpg)

</details>

<details><summary>лог предупреждений одного из подов для wagtail </summary>

![img41](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img41.jpg)

</details>


Создадим предупреждение при ошибках в контейнерах кластера:

![img42](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img42.jpg)

- задаем имя и описание;
- указываем параметры фильтрации [resource.type="k8s_container" severity=ERROR]
- указываем интервал между уведомлениями 
- указываем канал для уведомлений (создание каналов для уведомлений будет рассмотрено в части мониторинга)

![img43](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img43.jpg)

Собранные логи по умолчанию хранятся 30 дней.

#### Сервис Error Reporting 

Задание сервиса оперативно отображать **критические** ошибки в работе кластера, инстансов, подов и т.д. 

<details><summary>Error Reporting</summary>

![img44](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img44.jpg)

<details>


Создаем уведомление при поступлении новых критических ошибок, для этого выбираем: 

![img45](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img45.jpg)

и указываем канал для уведомлений (например e-mail).


### Часть ll - Мониторинг

Служба мониторинга группирует наши ресурсы по категориям и создает дашборды для каждой из них:

<details><summary>default dashboards</summary>

![img46](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img46.jpg)

</details>

Возьмем стандартный дашборд GKE:


<details><summary>GKE dashboard</summary>

![img47](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img47.jpg)

</details>

Выбрав ресурс из списка, можно:

- посмотреть нотификации или создать свои 
- просмотреть метрики 
- просмотреть логи 

<details><summary>container postgresql</summary>

![img48](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img48.jpg)

</details>

В разделе **Alerting** предоставляется возможность ознакомится с поступившими уведомлениями и настроить канали для оповещения. 

<details><summary>alerting</summary>

![img49](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img49.jpg)

</details>

Доступны следующие варианты получения уведомлений:

<details><summary>alerting</summary>

![img50](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img50.jpg)

</details>

Пример полученного уведомления (перейдя по ссылке можно ознакомится с деталями для решения проблемы): 

<details><summary>e-mail</summary>

![img51](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img51.jpg)

</details>


### Часть lll - Grafana 

Для улучшения визуализации и отслеживания данных в режиме реального времени было принято решение интегрировать в проект Grafana.

<details><summary>grafana deploy</summary>

```
---
# Grafana Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.grafana.name }}
spec:
  selector:
    matchLabels:
      project: {{ .Values.grafana.name }}
  replicas: {{ .Values.grafana.replicas }}
  template: 
    metadata:
      labels:
        project: {{ .Values.grafana.name }}
    spec:
      containers:
        - name: {{ .Values.grafana.name }}
          image: {{ .Values.containers.grafana_image }}   

```

</details>

<details><summary>values</summary>

```
#grafana default values
grafana: 
  name: grafana
  replicas: 1
  service:
    name: service-grafana
    port: 3000
    targetPort: 3000
   

```

</details>

<details><summary>service</summary>

```
--- 
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.grafana.service.name }}
spec:
  selector:
    project: {{ .Values.grafana.name }}
  type: LoadBalancer
  ports:
    - port: {{ .Values.grafana.service.port }}
      targetPort: {{ .Values.grafana.service.targetPort }}

```

</details>

Далее нужно создать связь с гулгом, для этого необходимо:

1) Активировать следующие службы: 

- Monitoring API
- Cloud Resource Manager API

2) Создать GCP аккаунт для проекта
В разделе API&Service -> Credentials -> Create Credentials -> Service Account

![img26](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img26.jpg)

Предоставляем нужные права на чтение и создаем профиль:

![img27](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img27.jpg)
![img28](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img28.jpg)

3) Теперь необходимо создать ключ доступа, для этого переходим в IAM&Admin -> выбираем нужный аккаунт 

![img29](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img29.jpg)
![img30](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img30.jpg)

Начнеться автоматическая загрузка .json файла и ключ должен отобразится в списке с активным статусом. 

![img31](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img31.jpg)

На этом подготовка со стороны клауда закончена, перемещаемся в Grafana:

Menu -> Configuration -> Data sources -> Add data source -> Cloud -> Google Cloud Monitoring 

Указываем путь к нашему файлу ключа -> Save & test

![img32](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img32.jpg)

Если тест прошел успешно, можно открывать раздел "Dashboards" из этой страницы и импортировать уже подготовленные дашборды.

![img33](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img33.jpg)

Далее, переходим в Menu -> Dashboards -> Manage :


<details><summary>dashboards</summary>

![img34](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img34.jpg)

![img35](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img35.jpg)

![img36](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img36.jpg)


</details>

Или создаем свои собственные панели:

<details><summary>panels</summary>

![img37](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img37.jpg)

![img38](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d11cebf636b880f96036b01a402d01831ed869b7/task8/img/img38.jpg)

</details>

Но, чтобы в полном объеме раскрыть возможности мониторинга с помощью Grafana, желательно интегрировать prometheus на кластер. 

---

*To be continued...*