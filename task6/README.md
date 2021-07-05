# Task 6: Databases

**Условие:**
>1.Развернуть в облаке контейнер с базой данных SQL (MySQL or PostgreSQL)

**Решение:**

Для задания был развернут контейнер с MySQL:

![img1](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img1.jpg)


**Условие:**
>2.Заполнить базу данных. 
>Сделать две таблицы: Students (ID; Student; StudentId) и Result (ID; StudentId; Task1; Task2; Task3; Task4)

**Решение:**

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img2.jpg)

**Условие:**
>EXTRA: 2.1. Написать SQL скрипт, который будет заполнять базу данных и проверять на наличие уже существующих таблиц/записей.

**Решение:**

Для защиты от дублей в поля Students.StudentId и Results.StudentId сделаны с параметром "UNIQUE" и "NOT NULL".
Скрипт на заполнение базы: [[extra2_1.sql](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/d8ff90351e271e9222ceb405a4a7219a97bcb91d/task6/extra2_1.sql)]

**Условие:**
>3.Написать запрос который по вашей фамилии будет находить информацию по выполненным заданиям и выводить результат на экран.

**Решение:**

```
SELECT Students.StudentId, Result.Task1, Result.Task2, Result.Task3, Result.Task4 FROM Internship.Students, Internship.Result WHERE Students.Student='Bandrivskyi' AND Students.StudentId=Result.StudentId;
```

![img3](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img3.jpg)

**Условие:**
>4.Сделайте dump базы данных, удалите существующую и восстановите из дампа.

**Решение:**

![img4](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img4.jpg)

![img5](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img5.jpg)

**Условие:**
>5.Написать Ansible роль для развертывания SQL или noSQL базы данных. Креды не должны храниться в GitHub.
>Extra2. Написать Ansible роль для создания SQL/NoSQL кластера.

**Решение:**

Структура директории:

[[ansible_task6](https://github.com/OlehBandrivskyi/DevOps_Internship/tree/master/task6/ansible_task6)]

![img10](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img10.jpg)

Пример выполнения: 
![img11](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img11.jpg)
![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7cc01db29b9248304fc604dc0970a887840f31c2/task6/img/img8.jpg)


**Условие:**
>3.Написать Pipeline для Jenkins который будет запускать ансибл плейбуки для SQL/NoSQL.

**Решение:**

Для использования pipeline создан отдельный билд-агент с установленным ansible, далее:
Этап 1. Загрузка плейбуков из репозитория;
Этап 2. Запуск плейбуков

![img12](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7a2c926e59c5c59d2bbc51c05104ca1134ecd082/task6/img/img12.jpg)

Результаты:

![img13](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7a2c926e59c5c59d2bbc51c05104ca1134ecd082/task6/img/img13.jpg)
![img14](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/7a2c926e59c5c59d2bbc51c05104ca1134ecd082/task6/img/img14.jpg)
