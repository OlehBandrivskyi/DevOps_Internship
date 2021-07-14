# Task 8: Project

В качестве инструмента для CI было решено использовать GitLab.

## Подготовка GitLab 

### Часть l

1. Регистрация аккаунта [[https://gitlab.com/users/sign_up](https://gitlab.com/users/sign_up)]

2. Создание группы:

![img1](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img1.jpg)

3. Репозиторий под проект:
![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img2.jpg)

### Часть ll

1. Для работы раннеров понадобится токен, его можно получить следующим образом: 
Репозиторий -> Settings -> CI/CD -> Runners -> Specific runners {registration token}

2. Установка раннера на удаленный инстанс или ВМ: [Installing GitLab Runner](https://docs.gitlab.com/runner/install/linux-repository.html#installing-gitlab-runner)] 

3. Настройка раннеров
Создано два раннера: на системе, в докере.

![img3](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img3.jpg)
![img4](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img4.jpg)

Cозданные раннеры должны отобразится в GitLab. Репозиторий -> Settings -> CI/CD -> Runners -> Available specific runners:

![img5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img5.jpg)

### Часть lll

Для проверки первого раннера использован шаблонный пайплайн (CI/CD -> Editor): 
<details><summary>.gitlab-ci.yml</summary>
<pre>

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

</pre></details>

**Результат:**
<details><summary>screenshots</summary>
<pre>
![img6](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img6.jpg)
![img7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img7.jpg)
![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/4d0025f5090a9ae82ae4ba7870af9d79d0635746/task8/img/img8.jpg)
</pre></details>
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


*To be continued...*
