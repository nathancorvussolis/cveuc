@echo off
pushd %~dp0
setlocal enabledelayedexpansion

if not defined CVEUC exit /b 1
if not defined OUTDIR exit /b 1

if exist %OUTDIR% (
  rd /s /q %OUTDIR%
)
mkdir %OUTDIR%
pushd %OUTDIR%
del /s /q *
popd



echo.
echo Šî–{‹@”\
echo.

%CVEUC% -e -E "euc_lf.txt" "%OUTDIR%\XE_euc_lf.txt"
%CVEUC% -e -W "euc_lf.txt" "%OUTDIR%\XW_euc_lf.txt"
%CVEUC% -e -U "euc_lf.txt" "%OUTDIR%\XU_euc_lf.txt"

%CVEUC% -e -E "euc_crlf.txt" "%OUTDIR%\XE_euc_crlf.txt"
%CVEUC% -e -W "euc_crlf.txt" "%OUTDIR%\XW_euc_crlf.txt"
%CVEUC% -e -U "euc_crlf.txt" "%OUTDIR%\XU_euc_crlf.txt"

%CVEUC% -u -E "utf8_lf.txt" "%OUTDIR%\XE_utf8_lf.txt"
%CVEUC% -u -W "utf8_lf.txt" "%OUTDIR%\XW_utf8_lf.txt"
%CVEUC% -u -U "utf8_lf.txt" "%OUTDIR%\XU_utf8_lf.txt"

%CVEUC% -u -E "utf8_crlf.txt" "%OUTDIR%\XE_utf8_crlf.txt"
%CVEUC% -u -W "utf8_crlf.txt" "%OUTDIR%\XW_utf8_crlf.txt"
%CVEUC% -u -U "utf8_crlf.txt" "%OUTDIR%\XU_utf8_crlf.txt"

%CVEUC% -u -E "utf8_bom_lf.txt" "%OUTDIR%\XE_utf8_bom_lf.txt"
%CVEUC% -u -W "utf8_bom_lf.txt" "%OUTDIR%\XW_utf8_bom_lf.txt"
%CVEUC% -u -U "utf8_bom_lf.txt" "%OUTDIR%\XU_utf8_bom_lf.txt"

%CVEUC% -u -E "utf8_bom_crlf.txt" "%OUTDIR%\XE_utf8_bom_crlf.txt"
%CVEUC% -u -W "utf8_bom_crlf.txt" "%OUTDIR%\XW_utf8_bom_crlf.txt"
%CVEUC% -u -U "utf8_bom_crlf.txt" "%OUTDIR%\XU_utf8_bom_crlf.txt"

%CVEUC% -w -E "utf16_lf.txt" "%OUTDIR%\XE_utf16_lf.txt"
%CVEUC% -w -W "utf16_lf.txt" "%OUTDIR%\XW_utf16_lf.txt"
%CVEUC% -w -U "utf16_lf.txt" "%OUTDIR%\XU_utf16_lf.txt"

%CVEUC% -w -E "utf16_crlf.txt" "%OUTDIR%\XE_utf16_crlf.txt"
%CVEUC% -w -W "utf16_crlf.txt" "%OUTDIR%\XW_utf16_crlf.txt"
%CVEUC% -w -U "utf16_crlf.txt" "%OUTDIR%\XU_utf16_crlf.txt"

%CVEUC% -w -E "utf16_bom_lf.txt" "%OUTDIR%\XE_utf16_bom_lf.txt"
%CVEUC% -w -W "utf16_bom_lf.txt" "%OUTDIR%\XW_utf16_bom_lf.txt"
%CVEUC% -w -U "utf16_bom_lf.txt" "%OUTDIR%\XU_utf16_bom_lf.txt"

%CVEUC% -w -E "utf16_bom_crlf.txt" "%OUTDIR%\XE_utf16_bom_crlf.txt"
%CVEUC% -w -W "utf16_bom_crlf.txt" "%OUTDIR%\XW_utf16_bom_crlf.txt"
%CVEUC% -w -U "utf16_bom_crlf.txt" "%OUTDIR%\XU_utf16_bom_crlf.txt"

pushd "%OUTDIR%"

set ERRORCOUNT=0
for %%f in ( XE_euc_lf.txt XE_euc_crlf.txt XE_utf8_lf.txt XE_utf8_crlf.txt XE_utf8_bom_lf.txt XE_utf8_bom_crlf.txt XE_utf16_lf.txt XE_utf16_crlf.txt XE_utf16_bom_lf.txt XE_utf16_bom_crlf.txt ) do (
  fc /n ..\euc_lf.txt %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
  )
)
if !ERRORCOUNT! equ 0 (
  echo -E : Succeeded.
) else (
  echo -E : Failed.
)

set ERRORCOUNT=0
for %%f in ( XW_euc_lf.txt XW_euc_crlf.txt XW_utf8_lf.txt XW_utf8_crlf.txt XW_utf8_bom_lf.txt XW_utf8_bom_crlf.txt XW_utf16_lf.txt XW_utf16_crlf.txt XW_utf16_bom_lf.txt XW_utf16_bom_crlf.txt ) do (
  fc /n /u ..\utf16_bom_crlf.txt %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
  )
)
if !ERRORCOUNT! equ 0 (
  echo -W : Succeeded.
) else (
  echo -W : Failed.
)

set ERRORCOUNT=0
for %%f in ( XU_euc_lf.txt XU_euc_crlf.txt XU_utf8_lf.txt XU_utf8_crlf.txt XU_utf8_bom_lf.txt XU_utf8_bom_crlf.txt XU_utf16_lf.txt XU_utf16_crlf.txt XU_utf16_bom_lf.txt XU_utf16_bom_crlf.txt ) do (
  fc /n ..\utf8_lf.txt %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
  )
)
if !ERRORCOUNT! equ 0 (
  echo -U : Succeeded.
) else (
  echo -U : Failed.
)

popd



echo.
echo Unicode ¨ EUC-JIS-2004 ŒÝŠ·«
echo.

%CVEUC% -u -E "euc-jis-2004-with-char-u8.txt" "%OUTDIR%\_ECC_euc-jis-2004-with-char-u8.txt"

%CVEUC% -e -U                       "euc-jis-2004-with-char.txt"   "%OUTDIR%\_EC_euc-jis-2004-with-char.txt"
iconv -f EUC-JIS-2004 -t UTF-8      "euc-jis-2004-with-char.txt" > "%OUTDIR%\_EI_euc-jis-2004-with-char.txt"
nkf --ic=EUC-JIS-2004 --oc=UTF-8 -x "euc-jis-2004-with-char.txt" > "%OUTDIR%\_EN_euc-jis-2004-with-char.txt"

%CVEUC% -u -E "%OUTDIR%\_EC_euc-jis-2004-with-char.txt" "%OUTDIR%\_ECC_euc-jis-2004-with-char.txt"
%CVEUC% -u -E "%OUTDIR%\_EI_euc-jis-2004-with-char.txt" "%OUTDIR%\_EIC_euc-jis-2004-with-char.txt"
%CVEUC% -u -E "%OUTDIR%\_EN_euc-jis-2004-with-char.txt" "%OUTDIR%\_ENC_euc-jis-2004-with-char.txt"

pushd "%OUTDIR%"

set ERRORCOUNT=0
for %%f in ( _ECC_euc-jis-2004-with-char-u8.txt _ECC_euc-jis-2004-with-char.txt _EIC_euc-jis-2004-with-char.txt _ENC_euc-jis-2004-with-char.txt ) do (
  fc /n ..\euc-jis-2004-with-char.txt %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
    echo Failed. %%f
  )
)
if !ERRORCOUNT! equ 0 (
  echo Succeeded.
) else (
  echo Failed.
)

popd



echo.
echo Unicode ¨ EUC-JP ŒÝŠ·«
echo.

%CVEUC% -j -U                 "euc-jp.txt"    "%OUTDIR%\_JC_euc-jp.txt"
iconv -f EUC-JP -t UTF-8      "euc-jp.txt" >  "%OUTDIR%\_JI_euc-jp.txt"
nkf --ic=EUC-JP --oc=UTF-8 -x "euc-jp.txt" >  "%OUTDIR%\_JN_euc-jp.txt"
uconv -f EUC-JP -t UTF-8      "euc-jp.txt" >  "%OUTDIR%\_JU_euc-jp.txt"

%CVEUC% -u -J "%OUTDIR%\_JC_euc-jp.txt" "%OUTDIR%\_JCC_euc-jp.txt"
%CVEUC% -u -J "%OUTDIR%\_JI_euc-jp.txt" "%OUTDIR%\_JIC_euc-jp.txt"
%CVEUC% -u -J "%OUTDIR%\_JN_euc-jp.txt" "%OUTDIR%\_JNC_euc-jp.txt"
%CVEUC% -u -J "%OUTDIR%\_JU_euc-jp.txt" "%OUTDIR%\_JUC_euc-jp.txt"

pushd "%OUTDIR%"

set ERRORCOUNT=0
for %%f in ( _JIC_euc-jp.txt _JNC_euc-jp.txt _JUC_euc-jp.txt ) do (
  fc /n _JCC_euc-jp.txt %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
    echo Failed. %%f
  )
)
if !ERRORCOUNT! equ 0 (
  echo Succeeded.
) else (
  echo Failed.
)

popd



endlocal
popd
