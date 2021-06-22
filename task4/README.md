# Task 3: Ansible

**Условие:**
>Развернуть три виртуальные машины в облаке. На одну из них (control_plane) установить Ansible.

**Решение:**

На AWS EC2 развернуто 3 инстанса, и на один из которых установлен Ansible:

![img1](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img2.jpg)

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img1.jpg)


**Условие:**
>Ping pong - выполнить встроенную команду ансибла ping. Пинговать две другие машины.

**Решение:**

Файл [[hosts](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_task1_3/hosts.txt)]и [[ansible.cfg](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_task1_3/ansible.cfg)]


```
ansible all -m ping
```

Результат:


![img3](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img3.jpg)


**Условие:**
>Мой Первый Плейбук - написать плейбук по установке Docker на две машины и выполнить его.

**Решение:**

Плейбук по установке Docker доступен по ссылке [[playbooktask3.yml]](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_task1_3/playbooktask3.yml)

Результат выполнения:

![img4](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img6.jpg)


**Условие:**
>EXTRA 1. Написать плейбук по установке Docker и одного из (LAMP/LEMP стек, Wordpress, ELK, MEAN - GALAXY нельзя) в Docker.
>EXTRA 2. Вышесказанные плейбуки не должны иметь дефолтных кредов к базам данных и/или админке.

**Решение:**

Создано две группы инстансов (для работы с БД и ВП отдельно)  [[hosts](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_extra_task1_2/hosts.txt)].

[[Dockerfile](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_extra_task1_2/dockerfiles/wp/Dockerfile)] для WP и [[env.list.example]](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/eb517a1d5491db67c52b96583ee4b7d0e1c660e9/task4/ansible_extra_task1_2/dockerfiles/wp/env.list.example). 

[[Dockerfile](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_extra_task1_2/dockerfiles/db/Dockerfile)] для DB и [[env.list.example)](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/ansible_extra_task1_2/dockerfiles/db/env.list.example).

Плейбук доступен по ссылке [[playbookextra.yml]](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/eb517a1d5491db67c52b96583ee4b7d0e1c660e9/task4/ansible_extra_task1_2/playbookextra.yml).

Результат:

![img5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img9.jpg)
![img6](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img7.jpg)

**Условие:**
>EXTRA 3.  Для исполнения плейбуков должны использоваться dynamic inventory (GALAXY можно)


**Решение:**

Для работы с dynamic inventory был установлен Inventory Plugins Amazon AWS Collection.

```
ansible-galaxy collection install amazon.aws
```
[[inv_awsc_ec2.yml]](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/eb517a1d5491db67c52b96583ee4b7d0e1c660e9/task4/ansible_extra_task3/inv_aws_ec2.yml)

![img7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img13.jpg)

Плейбук обновлен в соответствии с новыми группами [[playbookextra3.yml]](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/eb517a1d5491db67c52b96583ee4b7d0e1c660e9/task4/ansible_extra_task3/playbookextra3.yml)

Запуск плейбука:
```
 ansible-playbook playbookextra3.yml -i inv_aws_ec2.yml --limit group_ans_user
```

Результат:

![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img10.jpg)

![img9](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/26e3c1fc7c34cc2425496658697d592ebb5b3c51/task4/img/img11.jpg)

