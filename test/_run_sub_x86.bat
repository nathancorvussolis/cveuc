@echo off
pushd %~dp0
setlocal

rem x86 �e�X�g

set CVEUC="..\Win32\Release\cveuc.exe"
set OUTDIR=x86

call _run_sub.bat

endlocal
popd
