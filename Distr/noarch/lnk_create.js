/*
****************************************************************************************************************************
��ਯ� ��� ᮧ����� ��몮� � �ணࠬ��� � 䠩��� �� ��������
****************************************************************************************************************************
�室
- %~0 - ��� SpecialFolder, � ���ன ᮧ��� ���
    AllUsersDesktop
    AllUsersStartMenu
    AllUsersPrograms
    AllUsersStartup
    Desktop
    Favorites
    Fonts
    MyDocuments
    NetHood
    PrintHood
    Programs
    Recent
    SendTo
    StartMenu
    Startup
    Template
	
- %~1 - ��� Folder, � ���ன ᮧ��� ���.
		%~0 � %~1 ����� �������஢���.
		%~0 ��� %~1 ����� ���� ����묨, � ⠪�� ��砥 �� �㦭� 㪠�뢠�� � ���� "" ��� "."
- %~2 - ���� � �����/䠩��
- %~3 - ���� � ࠡ�祩 �����
- %~4 - �������� ��몠
- %~5 - ���� � ������ ��몠
- %~0 - ���ᠭ�� ��몠
****************************************************************************************************************************

�ਬ�� �ᯮ�짮����� 

cscript lnk_create.js "." "%USERPROFILE%\Desktop" "%windir%\system32\notepad.exe" "%HOMEDRIVE%%HOMEPATH%" "��� �������" "%windir%\system32\notepad.exe" "�������"

*/

var a,b,sh

if (WScript.Arguments.length!=7){
	WScript.Echo("Wrong arguments!!!")
	WScript.Quit()
}

a=WScript.Arguments(0)
b=WScript.Arguments(1)

if (a=="."){a=""}
if (b=="."){b=""}

sh=WScript.CreateObject("WScript.Shell")
	MyFolderPart=sh.SpecialFolders(a)
	MyFolderPart=MyFolderPart+b
	lk=sh.CreateShortcut(MyFolderPart+"\\"+WScript.Arguments(4)+".lnk")
	lk.TargetPath = WScript.Arguments(2)
	lk.WorkingDirectory = WScript.Arguments(3)
	lk.WindowStyle = 1
	lk.Hotkey = ""
	lk.IconLocation = WScript.Arguments(5)
	lk.Description = WScript.Arguments(6)
	lk.Arguments = ""
	lk.Save()
