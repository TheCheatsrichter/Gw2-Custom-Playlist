@echo off
set _MAINPATH_=%~dp0
set _MPATH_=%_MAINPATH_%CustomPlaylist\

echo #################################
echo ###### GW2 Custom Playlist ######
echo ###### by TheCheatsrichter ######
echo #################################

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
pause


:makedir
echo [+] Building DIR structure ...
If NOT EXIST "%_MPATH_%" mkdir "%_MPATH_%"
If NOT EXIST "%_MPATH_%#Playlists" mkdir "%_MPATH_%#Playlists"

FOR %%G IN (Ambient Battle BossBattle City Defeated MainMenu NightTime Underwater) DO (IF NOT EXIST "%_MPATH_%%%G" (mkdir "%_MPATH_%%%G" & echo [+] DIR structure created! ) else ( echo [*] Folder %%G allready created))
echo.
echo.
echo Please insert your Audiofiles!
pause


:makeplaylists
FOR %%G IN (Ambient Battle BossBattle City Defeated MainMenu NightTime Underwater) DO (
	chdir "%_MPATH_%%%G"
	echo [+] Building %%G.m3u ...
	dir /o:n/a/b/s *.mp3 *.aiff *.flac *.ogg *.wav >"%_MPATH_%#Playlists\%%G.m3u" || del "%_MPATH_%#Playlists\%%G.m3u"
	)
echo.
echo.
echo [+] Playlists Successfully created!
:readapply
set /p w=[*]Do you want to apply them now [y/n]?:

:copyplaylists
If NOT EXIST "%HOMEPATH%\Documents\Guild Wars 2" (
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
	echo [+] Have fun! Greetings TheCheatsrichter!
	) else (
	echo [-] Playlists not applied!
	)
:eof
pause