# Task 7: Logging&Monitoring

**Условие:**
>1.Zabbix:

>1.1.Установить на сервер - сконфигурировать веб и базу 

>1.2.Поставить на подготовленные ранее сервера или виртуалки заббикс агенты 

**Решение:**
Веб-интерфейс zabbix сервера:

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img2.jpg)

Установленный заббикс агент на отдельном сервере:

![img6](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img6.jpg)

Список хостов:

![img7](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img7.jpg)


**Условие:**
>1.3 Сделать несколько своих дашбородов, куда вывести данные со своих триггеров (например мониторить размер базы данных из предыдущего задания и включать алерт при любом изменении ее размера - можно спровоцировать вручную)

**Решение:**

Триггер на оповещение об изменении размера базы данных: 

![img8](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img8.jpg)
![img9](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img9.jpg)


**Условие:**
>1.4 Active check vs passive check - применить у себя оба вида - продемонстрировать.

**Решение:**

Демонстрация active_passive check:
![img10](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img10.jpg)


**Условие:**
>1.5 Сделать безагентный чек любого ресурса (ICMP ping)

**Решение:**
Создание безагентного хоста: 

![img11](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img11.jpg)


![img12](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img12.jpg)
![img13](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img13.jpg)


**Условие:**
>1.6 Спровоцировать алерт - и создать Maintenance инструкцию 

**Решение:**

Maintenance инструкция: 

![img14](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img14.jpg)


**Условие:**
>1.7 Нарисовать дашборд с ключевыми узлами инфраструктуры и мониторингом как и хостов так и установленного на них софта

**Решение:**

Пример дашборда для сервера БД: 
![img15](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img15.jpg)

**Условие:**
>2.1.Установить и настроить ELK 
>2.2.Организовать сбор логов из докера в ELK и получать данные от запущенных контейнеров

**Решение:**

Просмотр логов докера с помощью веб-интерфейса Kibana:

![img17](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img17.jpg)


**Условие:**
>2.3Настроить свои дашборды в ELK
>2.5Настроить мониторинг в ELK - получать метрики от ваших запущенных контейнеров

**Решение:**

Для сбора метрики использован Metricbeat, дашборд по контейнерах представлен ниже: 
![img18](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img18.jpg)


**Условие:**
>3.1 Установить Grafana интегрировать с установленным ELK

**Решение:**
После установки Grafana, создание связи с ELK:
![img19](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img19.jpg)


**Условие:**
>3.2 Настроить Дашборды

**Решение:**
Пример дашборда в Grafana:
![img20](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/63b9839d4cf14e0548f7a9233a45ec08422a4a3a/task7/img/img20.jpg)