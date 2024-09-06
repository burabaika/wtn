@echo off
setlocal

rem Установим кодировку консоли в UTF-8
chcp 65001 >nul

rem Путь к PowerShell скрипту и файлу с токеном относительно текущего каталога (.bat файла)
set SCRIPT_PATH=%~dp0wtn.ps1

rem Проверка наличия аргументов
if "%~1"=="" (
    echo Пожалуйста, введите сообщение.
    exit /b 1
)

if "%~2"=="" (
    echo Пожалуйста, введите chat_id.
    exit /b 1
)

rem Запуск PowerShell скрипта с передачей аргументов
powershell -ExecutionPolicy Bypass -File "%SCRIPT_PATH%" -Message "%~1" -ChatId "%~2"

endlocal
