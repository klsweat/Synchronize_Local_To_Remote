Get-EventSubscriber | Unregister-Event

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "U:\Local_Folder"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $false  
#$watcher.NotifyFilter = [IO.NotifyFilters]::LastWrite

$Buffer = "";

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
$action = { $path = $Event.SourceEventArgs.FullPath
        $changeType = $Event.SourceEventArgs.ChangeType
        $logline = "$(Get-Date), $changeType, $path"
            
        ### IF EVENT TYPE IS CHANGE   
        if($changeType -eq "Changed"){

            ### STOP DUPLICATE PROCESSES
            ### CHECK TO SEE IF BUFFER EQUAL "CHANGED...."  - IT WONT NOT FIRST TIME AROUND
            ### THIS RUNS SECOND -- RETURN TRUE BECAUSE YOU SET IT DURING THE FIRST RUN
            if ($Buffer -eq "Changed: $($Event.SourceEventArgs.FullPath)") {

                #SET THE BUFFER BACK TO EMPTY
                $Buffer = "";
                
                #START PROCESS OF SYNCHRONIZE FILES
                start-process "U:\winscp575\SyncToRemoteScript.bat"

                #LOG CHANGES TO TEXT FILE
                Add-content "C:\Users\username\desktop\log.txt" -value $logline
            } else {
                ### THIS SHOULD RUN FIRST, IF YOU ARE DUPLICATED PROCESSES RUNNING
                ### SET BUFFER
                $Buffer = "Changed: $($Event.SourceEventArgs.FullPath)" 
            }
        } 


        ### IF EVENT TYPE IS DELETED   
        if($changeType -eq "Deleted"){
            if ($Buffer -eq "Deleted: $($Event.SourceEventArgs.FullPath)") {
                $Buffer = "";
                start-process "U:\winscp575\SyncToRemoteScript.bat"
                Add-content "C:\Users\username\desktop\log.txt" -value $logline
            } else {
                $Buffer = "Deleted: $($Event.SourceEventArgs.FullPath)" 
            }
        } 

        ### IF EVENT TYPE IS RENAMED   
        if($changeType -eq "Renamed"){
            if ($Buffer -eq "Renamed: $($Event.SourceEventArgs.FullPath)") {
                $Buffer = "";
                start-process "U:\winscp575\SyncToRemoteScript.bat"
                Add-content "C:\Users\username\desktop\log.txt" -value $logline
            } else {
                $Buffer = "Renamed: $($Event.SourceEventArgs.FullPath)" 
            }
        } 

        ### IF EVENT TYPE IS CREATED                   
        if($changeType -eq "Created"){
            if ($Buffer -eq "Created: $($Event.SourceEventArgs.FullPath)") {
                $Buffer = "";
                start-process "U:\winscp575\SyncToRemoteScript.bat"
                Add-content "C:\Users\username\desktop\log.txt" -value $logline
            } else {
                $Buffer = "Created: $($Event.SourceEventArgs.FullPath)" 
            }
        } 
        
        ### PRINT BUFFER TO PS CONSOLE
        Write-Host $Buffer.ToString() 

        ### Deletes Event from Event Que
        $Event | Remove-Event

        }    
        
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
Register-ObjectEvent -InputObject $watcher -EventName Changed -SourceIdentifier ChangedFile -Action $action
Register-ObjectEvent -InputObject $watcher -EventName Created -SourceIdentifier CreatedFile -Action $created
Register-ObjectEvent -InputObject $watcher -EventName Deleted -SourceIdentifier DeletedFile -Action $action
Register-ObjectEvent -InputObject $watcher -EventName Renamed -SourceIdentifier RenamedFile -Action $action

### THIS KEEPS THE PS SCRIPT RUNNING IN A LOOP
while ($true) {}
