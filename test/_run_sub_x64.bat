@echo off
pushd %~dp0
setlocal

rem x64 ƒeƒXƒg

set CVEUC="..\x64\Release\cveuc.exe"
set OUTDIR=x64

call _run_sub.bat

endlocal
popd
