@echo off
	::create folder
set /p folder="Enter folder name: " 
set folder=%folder: =%
mkdir %folder%
cd %folder%

set localPath=%CD%

set /p resolution="Enter resolution separated by a english 'x': "
set resolution=%resolution: =%
	:: replacing cyrillic 'x' to latin 'x'
if not x%resolution:х=%==x%resolution% (
	set resolution=%resolution:х=x%
) 

if not exist "%resolution%" (
	echo ---------------------------- >> %localPath%\list.txt
	echo In this %resolution% folder: >> %localPath%\list.txt
)

mkdir %resolution%
cd %resolution%

echo:
echo Now you need set loop parameters for color changing.
echo This program use RGB [0..255] values for each color.

:start_start
set /p start="Enter the color change start: "
if %start% LSS 0 goto :start_start
if %start% GTR 255 goto :start_start

:start_end
set /p end="Enter the color change end: "
if %end% LSS 0 goto :start_end
if %end% GTR 255 goto :start_end

set /p step="Enter the color change step: "

set /a x = %start% 
:start
if %x% GTR %end% goto end
	cmd /C exit %x%
	set "HEX=%=ExitCode%"
	set HEX=%HEX:~6,8%
	
	set out_x=%x%

	if %out_x% GTR 99 goto skip
	if %out_x% GTR 9 (
		SET out_x=0%out_x%
	) else (
		SET out_x=00%out_x%
	)
	:skip

	echo %x% %out_x% %HEX%

		:: uncomment\comment this to check the funtionality
	:: magick convert -size %resolution% xc:#%HEX%%HEX%%HEX% %out_x%_%out_x%_%out_x%.png
		
	echo %out_x%_%out_x%_%out_x%.png >> %localPath%\list.txt

	set /a x+= %step%
goto start
:end

echo --------------------------------------------
echo script is completed
pause
exit