@ECHO OFF
for /f "delims=" %%i in ('hostname') do (set localhost=%%i)
for /f "tokens=1,2* usebackq" %%f in (`getmac /nh`) do (set mac=%%f & goto next)
:next

echo.

echo Registration information:

echo.

echo     rhost="%localhost%"
echo     rmac="%mac:~0,-1%"

echo.

echo Please report the this to the administrator.
echo Press any key to close...
pause>nul