@echo off
color 02
set _MAINPATH_=%~dp0
set _MPATH_=%_MAINPATH_%CustomPlaylist\

echo #########################################
echo ###### GW2 Custom Playlist Rev 2.0 ######
echo ######     by TheCheatsrichter     ######
echo #########################################

echo.
echo This batch will automatically create folders
echo in which you can place your custom audio files
echo for Guild Wars 2.
echo.
echo Supported formats are:
echo 	*.mp3 *.aiff *.flac *.ogg *.wav
echo.
echo.
echo This batch will:
echo 	*)create subfolders for each playlist
echo 	*)generate playlists in .m3u formats
echo 	*)setup the playlists to work with GuildWars2
echo.
echo 	Press any key to start by creating the Playlist folders
pause


:makedir
echo [+] Building DIR structure ...
If NOT EXIST "%_MPATH_%" mkdir "%_MPATH_%"
If NOT EXIST "%_MPATH_%#Playlists" mkdir "%_MPATH_%#Playlists"

FOR %%G IN (Ambient Battle BossBattle City Defeated MainMenu NightTime Underwater Victory) DO (IF NOT EXIST "%_MPATH_%%%G" (mkdir "%_MPATH_%%%G" & echo [+] %%G folder created! ) else ( echo [*] Folder %%G allready created))
echo.
echo.
echo [!] Please insert your Audiofiles!
pause


:makeplaylists
FOR %%G IN (Ambient Battle BossBattle City Defeated MainMenu NightTime Underwater Victory) DO (
	chdir "%_MPATH_%%%G"
	echo [+] Building %%G.m3u ...
	dir /o:n/a/b/s *.mp3 *.aiff *.flac *.ogg *.wav >"%_MPATH_%#Playlists\%%G.m3u" || (del "%_MPATH_%#Playlists\%%G.m3u" && echo [*] %%G folder is empty...)
	)
	
echo.
echo.
echo [+] Playlists Successfully created!
echo.
:readapply
set /p w=[*]Do you want to apply them now [y/n]?:

:copyplaylists
If NOT EXIST "%HOMEPATH%\Documents\Guild Wars 2" (
	color 0C
	echo [-] %HOMEPATH%\Documents\Guild Wars 2 not found!
	echo [-] Please manually copy the playlist files or force copy process 
	set /p w=[*]Force copy process [y/n]?:
	if not "%w%" == "y" (
		echo [-] Closing batch...
		goto eof
	)
	
)
If NOT EXIST "%HOMEPATH%\Documents\Guild Wars 2\Music" mkdir "%HOMEPATH%\Documents\Guild Wars 2\Music"



if "%w%" == "y" (
	xcopy /y /s "%_MPATH_%#Playlists" "%HOMEPATH%\Documents\Guild Wars 2\Music"  > nul
	echo [+] Playlists successfully applied!
	echo [+] Please restart GuildWars2 if its currently running!
	echo [+] Have fun! Greetings TheCheatsrichter!
	color 0A
	) else (
	echo.
	echo [-] Playlists not applied!
	color 0C
	)
pause
