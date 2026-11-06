@echo off
title SystemConfig
:: Made by Lacc
echo ===== CPU =====
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"

echo.
echo ===== GPU =====
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"

echo.
echo ===== RAM =====
powershell -NoProfile -Command "'{0} GB' -f [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)"

echo.
echo ===== MOTHERBOARD =====
powershell -NoProfile -Command "Get-CimInstance Win32_BaseBoard | Select-Object -ExpandProperty Product"

echo.
echo ===== NETWORK =====
echo IPv4:
ipconfig | findstr "IPv4"

echo IPv6:
ipconfig | findstr "IPv6"

echo DNS:
powershell -NoProfile -Command "Get-DnsClientServerAddress | Where-Object {$_.ServerAddresses.Count -gt 0} | Format-Table InterfaceAlias, ServerAddresses -AutoSize"

echo.
echo ===== DISK INFORMATION =====
powershell -NoProfile -Command "Get-Volume | Select-Object DriveLetter, FileSystemLabel, FileSystem, @{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}}, @{N='FreeGB';E={[math]::Round($_.SizeRemaining/1GB,2)}} | Format-Table -AutoSize"

echo.
echo ===== BIOS =====
powershell -NoProfile -Command "Get-CimInstance Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate | Format-List"

echo.
echo ===== CPU CORES =====
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed | Format-List"

echo.
echo ===== NETWORK ADAPTERS =====
powershell -NoProfile -Command "Get-NetAdapter | Format-Table Name, InterfaceDescription, Status, MacAddress -AutoSize"

echo.
echo ===== DISPLAY =====
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Format-List CurrentHorizontalResolution, CurrentVerticalResolution, CurrentRefreshRate"

echo.
echo ===== CPU USAGE =====
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object LoadPercentage"

echo.
echo ===== MEMORY USAGE =====
powershell -NoProfile -Command "Get-CimInstance Win32_OperatingSystem | Select-Object @{N='UsedRAM_GB';E={[math]::Round(($_.TotalVisibleMemorySize-$_.FreePhysicalMemory)/1MB,2)}}, @{N='FreeRAM_GB';E={[math]::Round($_.FreePhysicalMemory/1MB,2)}}"

echo.
echo ===== DEVELOPER TOOLS =====

where python
where node
where npm
where git
where docker
where code
where java
where gcc
where php
where composer

echo.
echo ===== SYSTEM ERRORS =====
wevtutil qe System /c:10 /rd:true /f:text

echo.
echo ===== WINDOWS DEFENDER =====
powershell -NoProfile -Command "Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled"

echo.
echo ===== FIREWALL =====
netsh advfirewall show allprofiles
echo.

echo ===== WINDOWS HOTFIXES =====
powershell -NoProfile -Command "Get-HotFix | Select-Object -First 10 HotFixID, InstalledOn"

echo.
echo ===== OTHER =====
echo USER: %USERNAME%
echo COMPUTER'S NAME: | hostname




pause