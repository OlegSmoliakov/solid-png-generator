@echo off
	::create folder
set /p location="Enter folder name: " 
mkdir %location%
cd %location%

set /a var = 0 
:start
	set /a var+= 1
    	:: step must be calculated manually
	if %var% EQU 5 goto end
		set /a "temp" = %var%
		cmd /C exit %temp%
		set "HEX=%=ExitCode%"
        set HEX=%HEX:~6,8%
		echo %var% %HEX%
			:: uncomment this to check the funtionality
		magick convert -size 3840x2160 xc:#%HEX%%HEX%%HEX% %var%_%var%_%var%.png
	goto start
:end
echo --------------------------------------------
echo script is completed
pause
exit