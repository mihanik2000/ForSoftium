<h1>ForSoftium</h1>

## Назначение репозитория

Репозиторий содержит скрипты, которые помогают автоматизировать процесс подготовки планшетов для работы в учебном классе школы <a href="https://софтиум.дети/" target="_blank">"Софтиум"</a>.

![Замечания](https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/img/note.png) **Замечания:**

- Репозиторий находится работе, поэтому отсутствие ошибок не гарантируется.
- Вы можете использовать данный репозиторий на свой собственный риск. Репозиторий предоставляется «как есть». Создатель репозитория не принимает на себя никакой ответственности, в том числе за соответствие репозитория вашим целям.

## Алгоритм использования

![Важно](https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/img/important.png) **ВАЖНО!!!**

Настоятельно рекомендуется использовать скритпы настройки на свежеустановленной ОС Windows 10/11.

- Загружаем полный дистрибутив по ссылке - https://repo.mihanik.net/ForSoftium.zip
- Распаковываем архив.
- Копируем распакованный полный дистрибутив репозитория на флешку.
- Вставляем влешку в настраиваемый ПК.
- Подключаем настраиваемый ПК к интернету. Это важно, т.к. во время работы скриптов нужен периодический доступ к Интернету.
- От имени администратора запускаем скрипт **"admin-Offline_Install.bat"**.
  Этот скрипт делает все необходимые настройки ПК, устанавливает всё необходимое программное обеспечение, помогает установить имя компьютера, включает "защитника Windows".
- Перезагружаем ПК и заходим под пользователем Softium (пароль: 321)
- Ждём пока отработает скрипт настройки профиля пользователя (в течение 1-2 минут "моргнёт" чёрное окно консоли cmd)
- Перезагружаем ПК и заходим под пользователем Softium (пароль: 321)
- Готово.

![Важно](https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/img/important.png) **ВАЖНО!!!**

В профиле пользователя **Softium** удаляются все файлы и папки созданные пользователем во время работы. Не очищается всего одна папка: **Документы**.

## Структура репозитория

**\	- 	Корень.**
	Здесь расположены основные скрипты. 

**Scripts - каталог**
	Папка для вспомогательных скриптов.
	
**Distr - каталог.**
	Это корневая папка для вспомогательных скриптов, файлов с настройками и дистрибутивами устанавливаемых программ.
	
**Distr\x32 - Каталог.**
	Этот каталог содержит дистрибутивы для 32-х разрядных операционных систем.

**Distr\x64 - Каталог.**
	Этот каталог содержит дистрибутивы для 64-х разрядных операционных систем.

**Distr\noarch - Каталог.**
	Этот каталог содержит дистрибутивы и прочие файлы, которые не зависят от разрядности установленной операционной системы.
	
**Distr\img - Каталог.**
	Тут лежат разные картинки.

![Важно](https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/img/important.png) **ВАЖНО!!!**
	Установочные дистрибутивы программ не размещены в данном репозитории.

## Полный дистрибутив + установочные файлы

Полный архив со скриптами и установочными дистрибутивами можно скачать тут: 

https://clck.ru/3AkSaZ

Видео того, как работает репозиторий

https://vk.com/video24886612_456239104?list=dd99bccf9e6fb63836

## Некоторые пояснения/замечания
![Замечания](https://raw.githubusercontent.com/mihanik2000/ForSoftium/main/Distr/img/note.png)

1. Во время работы скрипт создаёт пользователя `Softium` с паролем `321` и активирует учётную запись встроенного администратора, задав ему пароль `AdminPass`

2. Исполняемые и дополнительные файлы создаются в каталоге `C:\ProgramData\Softium`

3. Скрипты автоматически выполняемые при входе пользователя расположены в "common startup", т.е. в каталоге `%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\`

4. Ярлыки на запуск учебных программ располежены в "common desktop", т.е. на общем рабочем столе, для того, чтобы дети не могли их удалить или переименовать ради забавы. Напомню, что ярлыки общего рабочего стола могут менять только администраторы.

## Полезные ссылки

Установочные дистрибутивы Windows для планшетов можно найти тут:

ftp://ftp.irbis.su/%23fw.tablets.windows/

