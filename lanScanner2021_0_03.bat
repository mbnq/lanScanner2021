@echo off
color 97
Title LanScanner by mbnq.pl (proxine) v.2021.0.40 ^

	set IP1=0
	set IP2=0
	set IP3=0
	set IP4=0
	set /a found=0

cls

:INTRO
	set /p IPALL=Enter the starting ip^:
	echo:Checking IP Address...
	
REM Splitting given IP address into parts	

	for /f "tokens=1 delims=." %%a in ("%IPALL%") do (
		set IP1=%%a
	)
	for /f "tokens=2 delims=." %%a in ("%IPALL%") do (
		set IP2=%%a
	)
	for /f "tokens=3 delims=." %%a in ("%IPALL%") do (
		set IP3=%%a
	)
	for /f "tokens=4 delims=." %%a in ("%IPALL%") do (
		set IP4=%%a
	)

REM checking if parts are valid, it means between numeric 1 - 255	
	
	IF %IP1% LSS 1 GOTO ERROR01
	IF %IP1% GTR 255 GOTO ERROR01
	IF %IP2% LSS 1 GOTO ERROR01
	IF %IP2% GTR 255 GOTO ERROR01
	IF %IP3% LSS 1 GOTO ERROR01
	IF %IP3% GTR 255 GOTO ERROR01
	IF %IP4% LSS 1 GOTO ERROR01
	IF %IP4% GTR 255 GOTO ERROR01

REM determining user IP address
	
	set ip_address_string="IPv4 Address"
	for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do (
		set USERIP=%%f
		goto STOPCHECK
	)
	:STOPCHECK
	cls
	echo:UserIP^:%USERIP%
	echo:StartingIP^:%IPALL%
	echo:Scanning now!
	echo:
	echo:IP Data^:
	
:PING

REM start scanning

	set IPALL=%IP1%.%IP2%.%IP3%.%IP4%
	
	Title LanScanner by mbnq.pl (proxine) v.2021.0.40 ^| %IPALL%

	for /f "tokens=5 delims= " %%a in ('ping %IPALL% -n 1 -w 100 ^| find /i
	"time="') do (
		set /a found=1
		set zmnA=%%a
		set zmnB=%%b
	)

REM displaying found value
	
	if %found% GTR 0 (echo:%IPALL% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx %zmnA%  %zmnA:~5,3%)
	set /A IP4=%IP4%+1
	set zmnA=
	set zmnB=
	set /a found=0
	
	if %IP4% GEQ 256 GOTO ARP
	
	GOTO PING

:ARP
	echo:
	echo:Arp Data^:
	arp -a -N %USERIP%
	GOTO END
	
:ERROR01	
	echo:Error 01 - not valid IP address!	
	echo:
	GOTO INTRO
:END

	echo:
	echo:Finished.
	Title LanScanner by mbnq.pl (proxine) v.2021.0.40 ^| FINISHED
	
pause > nul
	