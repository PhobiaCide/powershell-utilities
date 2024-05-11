@echo off

set /p compression_level="Enter compression level (0-9): "
if not defined compression_level (
  echo Error: no compression level provided.
  goto :eof
)

for %%i in (*) do (
  if not "%%~nxi"=="%~nx0" (
    "C:\Program Files\7-Zip\7z.exe" a -t7z -mx=%compression_level% "%%~ni.7z" "%%~i"
    if %errorlevel% equ 0 (
      del "%%~i"
    ) else (
      echo Error: compression of "%%~i" failed.
    )
  )
)

pause
