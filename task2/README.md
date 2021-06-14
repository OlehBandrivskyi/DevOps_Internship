# Task 2: AWS Cloud
## _The Last Markdown Editor, Ever_
URL страницы "Hello World" [[3.120.145.171](http://3.120.145.171/)]

## Exta tasks
**Условие:**
>Выполнить п.3-5 с инстансами созданными в разных VPC. (связность должна быть как по внешним, так и по внутренним IP)	

**Решение:**
1. Создано два отдельных VPC в разных регионах и с разными диапазонами CIDRs, с их последующим соединением:

![img1](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/8bc8a1476c88c874e4c1f8e0cb1fb718a9137573/task2/img/img1.jpg)

2. Настроено маршрутизацию трафика между подсетями VPC:

![img2](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/8bc8a1476c88c874e4c1f8e0cb1fb718a9137573/task2/img/img2.jpg)

3. Проверка соединения с помощью SSH из инстанса A (_VPC1_Frankfurt_amazonlinux_) к инстансу В (_VPC2_London_Ubuntu_) по внутреннему IP: 

![img3](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/8bc8a1476c88c874e4c1f8e0cb1fb718a9137573/task2/img/img3.jpg)

4. Проверка связи по внешнему ІР: 

![img4](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/8bc8a1476c88c874e4c1f8e0cb1fb718a9137573/task2/img/img4.jpg)

**Условие:**
> Написать BASH скрипт для установки веб сервера (nginx/apache) и веб страницы с текстом “Hello World”, и информацией о текущей версией операционной системы


**Решение:**
[[extraTask2.sh](https://github.com/OlehBandrivskyi/DevOps_Internship/blob/8bc8a1476c88c874e4c1f8e0cb1fb718a9137573/task2/extraTask2.sh)]

**Условие:**
> Выполнить п.6 не заходя “руками” по SSH на EC2 instance.

**Решение:**
> Сделать веб страницу с текстом “Hello World” и информацией о текущей версией операционной системы;
 убедиться что веб сервер доступен из интернета и вы можете увидеть свою страницу “Hello World” в браузере; 
 
 Добавление скрипта [**extraTask2**] на этапе конфигурации, он буде исполнен при первом запуске инстанса.
 
> убедиться что из инстанса без nginx/apache вы можете увидеть “Hello World” инстанса c nginx/apache.

Аналогично для инстанса без nginx/apache: 
```
curl -o check.txt http://3.120.145.171 &&  aws s3 cp check.txt s3://cont-task2bucket/
```
Результат доступен на по [ссылке на S3](https://cont-task2bucket.s3.eu-west-2.amazonaws.com/check.txt)
