
# Sync Local Folder to Remote Folder

STOP EDITING FROM YOUR FTP FOLDER!  Here is a fast way to sync your local to remote. Using Power Shell you will be monitoring your local directory for changes and executing a window batch file .bat, that syncs/ uploads your changes made in your local folder to your remote folder.

## Follow these steps:
1. Download WinSCP : https://winscp.net/eng/download.php
2. Create a folder outside of your root folder. I named mine winscp575
3. Create  SyncToRemoteScript.bat file
4. Create SyncToRemoteScript.txt
5. Make sure you have the WinSCP.com file and WinSCP.exe file
6. Create a PowerShell file inside of your folder, you can name it StartMonitoring.ps1.
	- I had trouble trying to save a txt file as Power Shell, but sublime has a nice plugin that you can install that will all you to do this. 
	- Open Sublime
	- Enter Ctrl, Shit, + P on your keyboard
	- Select Install Package Powershell

Please review my scripts in my folder, to find content needed.

Please watch this video on how to setup your SyncToRemoteScript.txt file. It shows you how to get your ***SSH-RSA** key: https://www.youtube.com/watch?v=H3wBJgmXZUg&t=111s

## Run PowerShell | Start Monitoring File Changes

1. Open PowerShell
2. cd into the correct directory where your PowerShell script is located.
3. Type into the console .\StartMonitoring

## Excluding Folders from winSCP batch file.

Add:   -filemask="| select2/; flowchart/; calendar/; rails/; DataTables/; digith_template_builder/; html/; p/; vendor/; unploadjquery/; easyredmine_api_tests/; PR_test/; adLDAP/;"

***AFTER***

your Synchronize directory line for instance: 
synchronize remote U:\Local_Folder /Remote_Folder -filemask="| select2/; flowchart/; calendar/; rails/; DataTables/; digith_template_builder/; html/; p/; vendor/; unploadjquery/; easyredmine_api_tests/; PR_test/; adLDAP/;"

**U:\Local_Folder** is my local folder **/Remote_Folder** is my remote folder

** the WScript.vbs run the .bat file silently in the background, so you don't have multiple command windows popping up.

