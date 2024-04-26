# LinuxMonitoring v2.0

Мониторинг и исследование состояния системы в реальном времени.


## Contents
1. [Requirements](#requirements)
2.  [Результат](#результат)
3. [Chapter I](#chapter-i) \
    3.1. [Генератор файлов](#part-1-генератор-файлов)  
    3.2. [Засорение файловой системы](#part-2-засорение-файловой-системы)  
    3.3. [Очистка файловой системы](#part-3-очистка-файловой-системы)  
    3.4. [Генератор логов](#part-4-генератор-логов)  
    3.5. [Мониторинг](#part-5-мониторинг)  
    3.6. [GoAccess](#part-6-goaccess)  
    3.7. [Prometheus и Grafana](#part-7-prometheus-и-grafana)  
    3.8. [Готовый дашборд](#part-8-готовый-дашборд)  
    3.9. [Дополнительно. Свой node_exporter](#part-9-дополнительно-свой-node_exporter)  



## Requirements
- **Bash**

- **GoAccess**

- **Prometheus**

- **Grafana**

## Результат
- Part 1-6: Реализованные скрипты лежат в директории [src/Scripts](src/Scripts/), где 0x название папки, которое соотвествует скрипту.
- Part 7-9: [Отчет](src/REPORT.md) о выполнении находится по пути `src/REPORT.md`

## Chapter I

Проект состоит из 3 задач:
- Part 1-3: реализация bash-скриптов для работы с файловой системой(засорение и очистка файловой системы)
- Part 4-6: написание bash-скриптов для создания логов `nginx` и для их обработки, использование утиллиты `GoAccess`
-  Part 7-9: Установка и настройка Grafana и Prometheus, создание дашбордов, уставновка готового дашборда и реализация своего node exporter`a.


## Part 1. Генератор файлов

**== Задание ==** \
Написать bash-скрипт. Скрипт запускается с 6 параметрами. Пример запуска скрипта: \
`main.sh /opt/test 4 az 5 az.az 3kb` 

**Параметр 1** - это абсолютный путь. \
**Параметр 2** - количество вложенных папок. \
**Параметр 3** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
**Параметр 4** - количество файлов в каждой созданной папке. \
**Параметр 5** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
**Параметр 6** - размер файлов (в килобайтах, но не более 100).  

Имена папок и файлов должны состоять только из букв, указанных в параметрах, и использовать каждую из них хотя бы 1 раз.  
Длина этой части имени должна быть от 4 знаков, плюс дата запуска скрипта в формате DDMMYY, отделённая нижним подчёркиванием, например: \
**./aaaz_021121/**, **./aaazzzz_021121** 

При этом, если для имени папок или файлов были заданы символы `az`, то в названии файлов или папок не может быть обратной записи: \
**./zaaa_021121/**, т.е. порядок указанных символов в параметре должен сохраняться.

При запуске скрипта в указанном в параметре 1 месте, должны быть созданы папки и файлы в них с соответствующими именами и размером.  
Скрипт должен остановить работу, если в файловой системе (в разделе /) останется 1 Гб свободного места.  
Записать лог файл с данными по всем созданным папкам и файлам (полный путь, дата создания, размер для файлов).

**[Решение](src/Scripts/01/main.sh)**
## Part 2. Засорение файловой системы

**== Задание ==**

Написать bash-скрипт. Скрипт запускается с 3 параметрами. Пример запуска скрипта: \
`main.sh az az.az 3Mb`

**Параметр 1** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
**Параметр 2** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
**Параметр 3** - размер файла (в Мегабайтах, но не более 100).  

Имена папок и файлов должны состоять только из букв, указанных в параметрах, и использовать каждую из них хотя бы 1 раз.  
Длина этой части имени должна быть от 5 знаков, плюс дата запуска скрипта в формате DDMMYY, отделённая нижним подчёркиванием, например: \
**./aaazz_021121/**, **./aaazzzz_021121** 

При этом, если для имени папок или файлов были заданы символы `az`, то в названии файлов или папок не может быть обратной записи: \
**./zaaa_021121/**, т.е. порядок указанных в параметре символов должен сохраняться.

При запуске скрипта, в различных (любых, кроме путей содержащих **bin** или **sbin**) местах файловой системы, должны быть созданы папки с файлами.
Количество вложенных папок - до 100. Количество файлов в каждой папке - случайное число (для каждой папки своё).  
Скрипт должен остановить работу, когда в файловой системе (в разделе /) останется 1 Гб свободного места.  
Свободное место в файловой системе определять командой: `df -h /`  

Записать лог файл с данными по всем созданным папкам и файлам (полный путь, дата создания, размер для файлов).  
В конце работы скрипта, вывести на экран время начало работы скрипта, время окончания и общее время его работы. Дополнить этими данными лог файл.

**[Решение](src/Scripts/02/main.sh)**
## Part 3. Очистка файловой системы

**== Задание ==**

Написать bash-скрипт. Скрипт запускается с 1 параметром.
Скрипт должен уметь очистить систему от созданных в [Part 2](#part-2-засорение-файловой-системы) папок и файлов 3 способами:

1. По лог файлу
2. По дате и времени создания
3. По маске имени (т.е. символы, нижнее подчёркивание и дата).  

Способ очистки задается при запуске скрипта, как параметр со значением 1, 2 или 3.


**[Решение](src/Scripts/03/main.sh)**
## Part 4. Генератор логов

**== Задание ==**

Написать bash-скрипт, генерирующий 5 файлов логов **nginx** в *combined* формате.
Каждый лог должен содержать информацию за 1 день.

За день должно быть сгенерировано случайное число записей от 100 до 1000.
Для каждой записи должны случайным образом генерироваться:

1. IP (любые корректные, т.е. не должно быть ip вида 999.111.777.777)
2. Коды ответа (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. Методы (GET, POST, PUT, PATCH, DELETE)
4. Даты (в рамках заданного дня лога, должны идти по увеличению)
5. URL запроса агента
6. Агенты (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

**[Решение](src/Scripts/04/main.sh)**

## Part 5. Мониторинг

**== Задание ==**

Написать bash-скрипт для разбора логов **nginx** из [Части 4](#part-4-генератор-логов) через **awk**.

Скрипт запускается с 1 параметром, который принимает значение 1, 2, 3 или 4.
В зависимости от значения параметра вывести:

1. Все записи, отсортированные по коду ответа
2. Все уникальные IP, встречающиеся в записях
3. Все запросы с ошибками (код ответа - 4хх или 5хх)
4. Все уникальные IP, которые встречаются среди ошибочных запросов 

**[Решение](src/Scripts/05/main.sh)**
## Part 6. **GoAccess**

**== Задание ==**

С помощью утилиты GoAccess получить ту же информацию, что и в [Части 5](#part-5-мониторинг)

Открыть веб интерфейс утилиты на локальной машине.\
**[Решение](src/Scripts/06/main.sh)**

## Part 7. **Prometheus** и **Grafana**

**== Задание ==**

##### Установить и настроить **Prometheus** и **Grafana** на виртуальную машину
##### Получить доступ к веб интерфейсам **Prometheus** и **Grafana** с локальной машины

##### Добавить на дашборд **Grafana** отображение ЦПУ, доступной оперативной памяти, свободное место и кол-во операций ввода/вывода на жестком диске

##### Запустить ваш bash-скрипт из [Части 2](#part-2-засорение-файловой-системы)
##### Посмотреть на нагрузку жесткого диска (место на диске и операции чтения/записи)

##### Установить утилиту **stress** и запустить команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
##### Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ
**[Решение](src/REPORT.md)**

## Part 8. Готовый дашборд

**== Задание ==**

##### Установить готовый дашборд *Node Exporter Quickstart and Dashboard* с официального сайта **Grafana Labs**

##### Провести те же тесты, что и в [Части 7](#part-7-prometheus-и-grafana)

##### Запустить ещё одну виртуальную машину, находящуюся в одной сети с текущей
##### Запустить тест нагрузки сети с помощью утилиты **iperf3**

##### Посмотреть на нагрузку сетевого интерфейса

**[Решение](src/REPORT.md)**
## Part 9. Свой *node_exporter*

**== Задание ==**

Написать bash-скрипт, который собирает информацию по базовым метрикам системы (ЦПУ, оперативная память, жесткий диск (объем)).
Скрипт  должнен формировать html страничку по формату **Prometheus**, которую будет отдавать **nginx**. \
Саму страничку обновлять можно как внутри bash-скрипта или программы (в цикле), так и при помощи утилиты cron, но не чаще, чем раз в 3 секунды.

##### Поменять конфигурационный файл **Prometheus**, чтобы он собирал информацию с созданной вами странички.

##### Провести те же тесты, что и в [Части 7](#part-7-prometheus-и-grafana)

**[Решение](src/REPORT.md)**


