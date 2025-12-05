@echo off
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File PowerOfTwo.ps1
pause
