# ForSoftium

## Назначение репозитория

Репозиторий содержит скрипты, которые помогают автоматизировать процесс подготовки планшетов для работы в учебном классе школы "Софтиум".

Замечания:
- Репозиторий в работе, поэтому гарантировать полное отсутствие ошибок не могу.
- Настройки одного скрипта могут зависеть от настроек сделанных другими скриптами. Например, скрипты второго шага будут зависеть от настроек, которые сделали скрипты на первом шаге.

## Структура репозитория

**\	- 	Корень.**
	Здесь расположены основные скрипты. 
	Название скрипта содержит номер шага, на котором этот скрипт нужно выполнять, уровень привелегий, с которым нужно запускать скрипт, название скрипта.
	Например, скрипт `step 1 - admin - Turn_Off_Defender` нужно выполнять первым в очереди и от имени администратора.

**Deprecated drafts - каталог.**
	Это "песочница". Здесь лежат всякие черновики, которые в продакшене ****НЕ НАДО ИСПОЛЬЗОВАТЬ!!!***
	
**Distr - каталог.**
	Это корневая папка для вспомогательных скриптов, файлов с настройками и дистрибутивами устанавливаемых программ.
	
**Distr\x32 - Каталог.**
	Этот каталог должен содержать дистрибутивы для 32-х разрядных операционных систем.

```
7z1900.msi
googlechromestandaloneenterprise.msi
npp.7.9.Installer.exe
wget.exe
```	

**Distr\x64 - Каталог.**
	Этот каталог должен содержать дистрибутивы для 64-х разрядных операционных систем.

```
7z1900-x64.msi
googlechromestandaloneenterprise64.msi
npp.7.9.Installer.x64.exe
wget.exe
```

**Distr\noarch - Каталог.**
	Этот каталог должен содержать дистрибутивы и прочие файлы, которые не зависят от разрядности установленной операционной системы.
	
```
AdobeAIRInstaller.exe
animate.ico
animate.swf
BABYTYPE2000.zip
Chrome.reg
computer.lnk
construct2-r279-setup.exe
em_eu_bt26XbG3_installer.msi
file_delete.js
gimp-2.10.20-setup-1.exe
KoduSetup.msi
lnk_create.js
PinnedTaskbar.reg
python-3.8.6.exe
python-3.9.0.exe
Scratch-461.exe
ScratchDesktopSetup3.15.0.exe
Snap-6.1.4.zip
Softium.exe
SWF.max-2.2.exe
Wallpaper.jpg
xnafx40_redist.msi
```

Установочные дистрибутивы программ не размещены в данном репозитории.

## Полный дистрибутив + установочные файлы

Архив со скриптами и установочными дистрибутивами можно скачать тут: 

https://yadi.sk/d/uSVUFP_qllOD9w

## Некоторые пояснения/замечания

1. Во время работы скрипт создаёт пользователя `Softium` с паролем `321` и активирует учётную запись встроенного администратора, задав ему пароль `AdminPass`

2. Исполняемые и дополнительные файлы создаются в каталоге `C:\ProgramData\Softium`

- `C:\ProgramData\Softium\Softium.exe` - программа Softium
- `C:\ProgramData\Softium\Chrome.reg` - назначает Chrome Браузером по умолчанию
- `C:\ProgramData\Softium\Wallpaper.jpg` - обои рабочего стола
- `C:\ProgramData\Softium\PinnedTaskbar.reg` - настройки панели быстрого запуска
- `C:\ProgramData\Softium\lnk_create.js` - вспомогательный  скрипт для создания ярлыков
- `C:\ProgramData\Softium\file_delete.js`  - вспомогательный  скрипт для удаления ярлыков и файлов
- 'C:\ProgramData\Softium\computer.lnk' - ссылка на "Компьютер"
- 'C:\ProgramData\Softium\step 3 - user - CleanUp.bat' - скрипт очистки профиля пользователя

3. Скрипты автоматически выполняемые при входе пользователя расположены в "common startup", т.е. в каталоге `%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\`

4. Ярлыки на запуск учебных программ располежены в "common desktop" для того, чтобы дети не могли их удалить или переименовать ради забавы.

## Полезные ссылки

Установочные дистрибутивы Windows для планшетов можно найти тут:

ftp://ftp.irbis.su/%23fw.tablets.windows/

Настройками Google Chrome можно управлять через реестр.

Подробности тут: https://getadmx.com/?Category=Chrome&Policy=Google.Policies.Chrome::PasswordManagerEnabled&Language=ru-ru

