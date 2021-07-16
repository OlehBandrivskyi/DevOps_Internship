# Task 8: Project


## Оглавление

- [Подготовка GitLab](#подготовка-gitlab)
- [Настройка CI](#настройка-ci)
- To be continued...

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


*To be continued...*