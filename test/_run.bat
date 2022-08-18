@echo off
pushd %~dp0
setlocal

echo.
echo ======== x86 テスト ========
call _run_sub_x86.bat

echo.
echo ======== x64 テスト ========
call _run_sub_x64.bat


endlocal
popd

echo.
pause
