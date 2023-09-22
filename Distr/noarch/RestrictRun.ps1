$User = ".\Softium"
$PWord = ConvertTo-SecureString -String "321" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

$ar = '-command "Start-Process regedit.exe -Verb RunAs -args "/s C:\ProgramData\Softium\RestrictRun.reg""'
Start-Process powershell.exe -Credential $Credential -WindowStyle Hidden -ArgumentList $ar
