@echo off
	::create folder
set /p folder="Enter the name of the folder where the images will be saved: " 
set folder=%folder: =%
mkdir %folder%
cd %folder%

set localPath=%CD%

set /p resolution="Enter resolution separated by a english 'x' [1920x1080]: "
set resolution=%resolution: =%
	:: replacing cyrillic 'x' to latin 'x'
if not x%resolution:х=%==x%resolution% (
	set resolution=%resolution:х=x%
) 

if not exist "%resolution%" (
	echo ---------------------------- >> %localPath%\list.txt
	echo %resolution% folder contains: >> %localPath%\list.txt
	echo ---------------------------- >> %localPath%\list.txt
)

mkdir %resolution%
cd %resolution%

::skip this, because use all combination	
goto :start_all_combinations

echo:
echo Now, you need set the loop parameters for changing the colours.
echo This program use RGB [0..255] values for each colour.

:start_start
set /p start="Enter the colour change start [0..255] "
if %start% LSS 0 goto start_start
if %start% GTR 255 goto start_start

:start_end
set /p end="Enter the colour change end [0..255]: "
if %end% LSS 0 goto start_end
if %end% GTR 255 goto start_end

set /p step="Enter the colour change step [1..]: "
set step=%step: =%
goto :start_r

:start_all_combinations

	:: RED colour
echo:
echo Now, you need set the loop parameters for changing the RED colour.

:start_start_r
set /p start_r="Enter the START value fo RED colour [0..255]: "
if %start_r% LSS 0 (
	echo 		Wrong value, minimum value is 0
	goto start_start_r
)	
if %start_r% GTR 255 (
	echo 		Wrong value, maximum value is 255
	goto start_start_r
)

:start_end_r
set /p end_r="Enter the FINAL value for RED colour [%start_r%..255]: "
if %end_r% LSS %start_r% ( 
	echo 		Wrong value, minimum value is %start_r% 
	goto start_end_r
)
if %end_r% GTR 255 (
	echo 		Wrong value, maximum value is 255
	goto start_end_r
)

:start_step_r
set /p step_r="Enter the change step for RED colour [1..] : "
set step_r=%step_r: =%
if %step_r% EQU 0 (
	set /a step_r = 256
)
if %step_r% LSS 0 (
	echo 	   Wrong value, step value must be > -1 
	goto start_step_r
)

	:: GREEN colour
echo:
echo Now, you need set the loop parameters for changing the GREEN colour.

:start_start_g
set /p start_g="Enter the START value fo GREEN colour [0..255]: "
if %start_g% LSS 0 (
	echo		Wrong value, minimum value is 0
	goto start_start_g
)
if %start_g% GTR 255 (
	echo		Wrong value, maximum value is 255
	goto start_start_g
)

:start_end_g
set /p end_g="Enter the FINAL value for GREEN colour [%start_g%..255]: "
if %end_g% LSS %start_g% (
	echo 		Wrong value, minimum value is %start_g%
	goto start_end_g
)
if %end_g% GTR 255 (
	echo 		Wrong value, maximum value is 255
	goto start_end_g
)

:start_step_g
set /p step_g="Enter the change step for GREEN colour [1..]: "
set step_g=%step_g: =%
if %step_g% EQU 0 (
	set /a step_g = 256
)
if %step_g% LSS 0 (
	echo 		Wrong value, step must be > -1
	goto start_step_g
)

	:: BLUE colour
echo:
echo Now, you need set the loop parameters for changing the BLUE colour.

:start_start_b
set /p start_b="Enter the START value fo BLUE colour [0..255]: "
if %start_b% LSS 0 (
	echo 		Wrong value, minimum value is 0
	goto start_start_b
)
if %start_b% GTR 255 (
	echo 		Wrong value, maximum value is 255
	goto start_start_b
)

:start_end_b
set /p end_b="Enter the FINAL value for BLUE colour [%start_b%..255]: "
if %end_b% LSS %start_b% (
	echo 		Wrong value, minimum value is %start_b%
	goto start_end_b
)
if %end_b% GTR 255 (
	echo 		Wrong value, maximum value is 255
	goto start_end_b
)

:start_step_b
set /p step_b="Enter the change step for BLUE colour [1..]: "
set step_b=%step_b: =%
if %step_b% EQU 0 (
	set /a step_b = 256
)
if %step_b% LSS 0 (
	echo 		Wrong value, step must be > -1
	goto start_step_b
)

set /a r = %start_r%
set /a g = %start_g%
set /a b = %start_b%

:start_r
if %r% GTR %end_r% goto end_r
	:start_g
	if %g% GTR %end_g% goto end_g
		:start_b
		if %b% GTR %end_b% goto end_b
			cmd /C exit %r%
			set "HEX_r=%=ExitCode%"
			set HEX_r=%HEX_r:~6,8%

			cmd /C exit %g%
			set "HEX_g=%=ExitCode%"
			set HEX_g=%HEX_g:~6,8%

			cmd /C exit %b%
			set "HEX_b=%=ExitCode%"
			set HEX_b=%HEX_b:~6,8%
			
			set out_r=%r%
			set out_g=%g%
			set out_b=%b%

			if %out_r% GTR 99 goto skip_r
			if %out_r% GTR 9 (
				SET out_r=0%out_r%
			) else (
				SET out_r=00%out_r%
			)
			:skip_r

			if %out_g% GTR 99 goto skip_g
			if %out_g% GTR 9 (
				SET out_g=0%out_g%
			) else (
				SET out_g=00%out_g%
			)
			:skip_g

			if %out_b% GTR 99 goto skip_b
			if %out_b% GTR 9 (
				SET out_b=0%out_b%
			) else (
				SET out_b=00%out_b%
			)
			:skip_b

				::loging
			echo R: %r% %HEX_r%		G: %g% %HEX_g%		B: %b% %HEX_b%

				:: uncomment\comment next stroke to enable\disable generation
			magick convert -size %resolution% xc:#%HEX_r%%HEX_g%%HEX_b% %out_r%_%out_g%_%out_b%.png
				
			echo %out_r%_%out_g%_%out_b%.png >> %localPath%\list.txt

			set /a total+= 1
			set /a b+= %step_b%
		goto start_r
		:end_b
		set /a g+= %step_g%
		set /a b= %start_b% 	
	goto start_r
	:end_g
	set /a r+= %step_r%
	set /a g= %start_g%	
	set /a b= %start_b%
goto start_r
:end_r

echo --------------------------------------------
echo total images created: %total%
echo script is completed
echo:
echo you can close this window and check result in the folder
timeout 20 > NUL
exit