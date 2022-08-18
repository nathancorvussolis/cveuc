@echo off
pushd %~dp0
setlocal

rem x86 ƒeƒXƒg

set CVEUC="..\Win32\Release\cveuc.exe"
set OUTDIR=x86

call _run_sub.bat

endlocal
popd
