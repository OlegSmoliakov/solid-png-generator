@echo off

set /a var = 0 
:start
	set /a var+= 1
    :: step must be calculated manually
	if %var% EQU 256 goto end
		set /a "temp" = %var%
		cmd /C exit %temp%
		set "HEX=%=ExitCode%"
        set HEX=%HEX:~6,8%
		echo %var% %HEX%
		magick convert -size 3840x2160 xc:#%HEX%%HEX%%HEX% %var%_%var%_%var%.png
		:: Code you want to run goes here
	goto start
:end
pause