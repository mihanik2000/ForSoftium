/*
****************************************************************************************************************************
��ਯ� ��� 㤠����� 䠩��� �� ��������
****************************************************************************************************************************
�室
- %~0 - ��� SpecialFolder, � ���ன 㤠�塞 䠩�
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
	
- %~1 - ��� 䠩��, ����� 㤠�塞
		%~0 � %~1 ����� �������஢���.
		%~0 ��� %~1 ����� ���� ����묨, � ⠪�� ��砥 �� �㦭� 㪠�뢠�� � ���� "" ��� "."
****************************************************************************************************************************

�ਬ�� �ᯮ�짮����� 

cscript file_delete "." "%USERPROFILE%\Desktop\Myfile.txt"

*/

var a,b,sh,fso

if (WScript.Arguments.length!=2){
	WScript.Echo("Wrong arguments!!!")
	WScript.Quit()
}

a=WScript.Arguments(0)
b=WScript.Arguments(1)

if (a=="."){a=""}
if (b=="."){b=""}

sh=WScript.CreateObject("WScript.Shell")
	MyPath=sh.SpecialFolders(a)
	MyPath=MyPath+b

fso=WScript.CreateObject("Scripting.FileSystemObject")
	WScript.Echo("Deleting file: " + MyPath)
	fso.DeleteFile (MyPath, true)
