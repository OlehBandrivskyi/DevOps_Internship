# Task 8: Project

В качестве инструмента для CI было решено использовать GitLab.

## Подготовка GitLab 

### Часть l

1. Регистрация аккаунта (https://gitlab.com/users/sign_up)
2. Создание группы
![img1]()

3. Репозиторий под проект 
![img2]()

### Часть ll

1. Для работы раннеров понадобится токен, его можно получить следующим образом: 
Репозиторий -> Settings -> CI/CD -> Runners -> Specific runners {registration token}

2. Установить раннер на удаленный инстанс или ВМ:
Инструкция по установке для разних дистрибутивов Linux [Installing GitLab Runner](https://docs.gitlab.com/runner/install/linux-repository.html#installing-gitlab-runner)] 

3. Настройка раннеров
Создано два раннера: на машине, в докере.

![img3]()
![img4]()

Cозданные раннеры должны отобразится в GitLab Репозиторий -> Settings -> CI/CD -> Runners -> Available specific runners:

![img5]()

### Часть lll

Для проверки первого раннера использован следующий пайплайн(CI/CD -> Editor): 
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
![img5]()
![img6]()
![img7]()
![img8]()

Аналогиным образом проверка докер раннера: 
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


*To be continued...*
