@echo off
SET SourceFolder=C:\Path\To\Your\Source\Files
SET ExeName=YourExeName.exe
SET ConfName=YourConfig.conf

:: Copy the executable and configuration file to the AppData folder
xcopy "%SourceFolder%\%ExeName%" "%APPDATA%" /Y
xcopy "%SourceFolder%\%ConfName%" "%APPDATA%" /Y

:: Create a shortcut in the user's Startup folder
SET StartupShortcut=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%ExeName%.lnk
SET Script="%TEMP%\temp.vbs"

:: Create a VBScript that will create the actual shortcut
(
echo Set oWS = WScript.CreateObject("WScript.Shell") 
echo sLinkFile = "%StartupShortcut%" 
echo Set oLink = oWS.CreateShortcut(sLinkFile)
echo oLink.TargetPath = "%APPDATA%\%ExeName%"
echo oLink.Arguments = "-conf %APPDATA%\%ConfName%"
echo oLink.Save
) > %Script%

:: Run the VBScript
cscript /nologo %Script%

:: Clean up the VBScript
del %Script%

echo Your program has been installed and will run at startup.
pause


' Define the paths for source files and target locations
SourceFolder = "C:\Path\To\Your\Source\Files"
ExeName = "YourExeName.exe"
ConfName = "YourConfig.conf"
AppDataPath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%APPDATA%")




curl -X POST http://FlaskApp2/endpoint -H "Content-Type: application/json" -d "{\"env\":\"${env}\", \"cases\":\"${cases}\"}"


' Copy files to the AppData folder
Set fso = CreateObject("Scripting.FileSystemObject")
fso.CopyFile SourceFolder & "\" & ExeName, AppDataPath & "\", True
fso.CopyFile SourceFolder & "\" & ConfName, AppDataPath & "\", True

' Create a shortcut in the Startup folder
StartupFolder = AppDataPath & "\Microsoft\Windows\Start Menu\Programs\Startup"
Set oShell = CreateObject("WScript.Shell")
Set oShortCut = oShell.CreateShortcut(StartupFolder & "\" & ExeName & ".lnk")

oShortCut.TargetPath = AppDataPath & "\" & ExeName
oShortCut.Arguments = "-conf " & AppDataPath & "\" & ConfName
oShortCut.Save

' Optionally start the executable
oShell.Run """" & AppDataPath & "\" & ExeName & """ -conf " & """" & AppDataPath & "\" & ConfName & """", 1, False

' Inform the user
MsgBox "Your program has been installed and will now run at startup and is also starting now.", vbInformation


##############################

import subprocess

# List of commands to execute
commands = [
    'command1',
    'command2',
    'command3',
    # Add more commands as needed
]

# List to hold the output of each command
outputs = []

# Start a shell process
proc = subprocess.Popen('cmd.exe', stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

# Execute each command in the same shell
for cmd in commands:
    # Send the command to the shell
    proc.stdin.write(cmd + '\n')
    proc.stdin.flush()

    # Read the command output
    output = proc.stdout.readline()
    while output:
        outputs.append(output.strip())
        output = proc.stdout.readline()

# Close the shell
proc.stdin.close()
proc.terminate()

# Print the outputs
for output in outputs:
    print(output)

    ###########################################


import os
import filecmp

def list_files(directory):
    """ Recursively list all files and subdirectories in a directory. """
    paths = []
    for root, dirs, files in os.walk(directory):
        for filename in files:
            paths.append(os.path.relpath(os.path.join(root, filename), directory))
    return set(paths)

def compare_directories(dir1, dir2):
    files_dir1 = list_files(dir1)
    files_dir2 = list_files(dir2)

    # Compare file lists
    missing_in_dir2 = files_dir1 - files_dir2
    missing_in_dir1 = files_dir2 - files_dir1

    if missing_in_dir2:
        print(f"Files missing in {dir2}: {missing_in_dir2}")
    if missing_in_dir1:
        print(f"Files missing in {dir1}: {missing_in_dir1}")

    # Compare the content of files that exist in both folders
    for file in files_dir1.intersection(files_dir2):
        filepath1 = os.path.join(dir1, file)
        filepath2 = os.path.join(dir2, file)

        if filecmp.cmp(filepath1, filepath2, shallow=False):
            print(f"File '{file}' is identical in both folders.")
        else:
            print(f"File '{file}' differs.")

# Example usage
compare_directories('path/to/directory1', 'path/to/directory2')

curl -X POST http://FlaskApp2/endpoint -H "Content-Type: application/json" -d "{\"env\":\"${env}\", \"cases\":\"${cases}\"}"




import re
import os

def convert_prints_to_logging(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    # This basic pattern assumes simple print statements. It may need to be more sophisticated to handle all cases.
    pattern = re.compile(r'print\s*\((.*)\)')
    modified_content = pattern.sub(r'logger.info(f"{\1}")', content)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(modified_content)

# Example usage
directory_path = '/path/to/your/project'
for root, dirs, files in os.walk(directory_path):
    for file in files:
        if file.endswith('.py'):
            convert_prints_to_logging(os.path.join(root, file))



curl -X POST http://FlaskApp2/endpoint -H 'Content-Type: application/json' -d '{"env": "'"${env}"'", "cases": "'"${cases}"'"}'
