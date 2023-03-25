@echo off
	::create folder
set /p location="Enter folder name: " 
mkdir %location%
cd %location%
set /p resolution="Enter resolution separated by a english 'x': "
set resolution=%resolution: =%
mkdir %resolution%
cd %resolution%

echo:
echo Now you need set loop parameters for color changing.
echo This program use RGB [0..255] values for each color.

:start_start
set /p start="Enter the color change start: "
if %start% LSS 0 goto :start_start
if %start% GTR 255 goto :start_start

set /p step="Enter the color change step: "

:start_end
set /p end="Enter the color change end: "
if %start% LSS 0 goto :start_end
if %start% GTR 255 goto :start_end

	:: replacing cyrillic 'x' to latin 'x'
if not x%resolution:х=%==x%resolution% (
	set resolution=%resolution:х=x%
) 

set /a var = %start% 
:start
	
    	:: step must be calculated manually
	if %var% GTR %end% goto end
		set /a "temp" = %var%
		cmd /C exit %temp%
		set "HEX=%=ExitCode%"
        set HEX=%HEX:~6,8%
		echo %var% %HEX%
			:: uncomment this to check the funtionality
		magick convert -size %resolution% xc:#%HEX%%HEX%%HEX% %var%_%var%_%var%.png
	set /a var+= %step%
goto start
:end

echo --------------------------------------------
echo script is completed
pause
exit