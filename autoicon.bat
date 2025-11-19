@echo off
REM ============================================================
REM  setup_icons_splash.bat
REM  Objetivo:
REM   - Asegurar estructura de assets para icono y splash:
REM       * assets\icons\icono.jpg  -> launcher icon
REM       * assets\splash\splash.jpg -> splash screen
REM   - Agregar dependencias:
REM       * flutter_launcher_icons
REM       * flutter_native_splash
REM   - Configurar bloques en pubspec.yaml (nivel raiz) SOLO para Android:
REM       * flutter_launcher_icons
REM       * flutter_native_splash
REM   - Ejecutar:
REM       1) flutter pub get
REM       2) dart run flutter_launcher_icons
REM       3) dart run flutter_native_splash:create
REM       4) flutter run
REM
REM  Diseño splash:
REM   - Solo Android
REM   - Fondo blanco (#ffffff)
REM   - Imagen de splash: assets/splash/splash.jpg
REM   - Android 12 usa la misma imagen y color
REM ============================================================

setlocal EnableExtensions EnableDelayedExpansion

REM --- Validación: debe existir pubspec.yaml
if not exist "pubspec.yaml" (
  echo [ERROR] No se encontro pubspec.yaml en el directorio actual.
  echo         Ejecuta este script desde la RAIZ del proyecto Flutter.
  exit /b 1
)

echo [INFO] Inicio: %DATE% %TIME%

REM ------------------------------------------------------------
REM PASO 0) Preparar carpetas e imagenes
REM   - Crear assets\icons y assets\splash
REM   - Mover:
REM       icono.jpg  (raiz) -> assets\icons\icono.jpg
REM       splash.jpg (raiz) -> assets\splash\splash.jpg
REM ------------------------------------------------------------
echo.
echo [PASO 0] Preparando estructura de assets (icons y splash) y moviendo imagenes

REM Crear carpetas necesarias
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "New-Item -ItemType Directory -Path 'assets\icons' -Force | Out-Null; New-Item -ItemType Directory -Path 'assets\splash' -Force | Out-Null;"

REM Mover icono.jpg -> assets\icons\icono.jpg
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$src = 'icono.jpg';" ^
  "$dst = 'assets\icons\icono.jpg';" ^
  "if (Test-Path $src) {" ^
  "  if (Test-Path $dst) {" ^
  "    Write-Host '[INFO] Ya existe ' $dst ' ; no se sobreescribe.';" ^
  "  } else {" ^
  "    Move-Item -LiteralPath $src -Destination $dst;" ^
  "    Write-Host '[OK] Movido ' $src ' -> ' $dst;" ^
  "  }" ^
  "} else {" ^
  "  Write-Host '[INFO] No se encontro icono.jpg en la raiz; continuando...';" ^
  "}"

REM Mover splash.jpg -> assets\splash\splash.jpg
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$src = 'splash.jpg';" ^
  "$dst = 'assets\splash\splash.jpg';" ^
  "if (Test-Path $src) {" ^
  "  if (Test-Path $dst) {" ^
  "    Write-Host '[INFO] Ya existe ' $dst ' ; no se sobreescribe.';" ^
  "  } else {" ^
  "    Move-Item -LiteralPath $src -Destination $dst;" ^
  "    Write-Host '[OK] Movido ' $src ' -> ' $dst;" ^
  "  }" ^
  "} else {" ^
  "  Write-Host '[INFO] No se encontro splash.jpg en la raiz; continuando...';" ^
  "}"

REM Avisos
if not exist "assets\icons\icono.jpg" (
  echo [AVISO] No se encontro assets\icons\icono.jpg (icono para launcher).
)

if not exist "assets\splash\splash.jpg" (
  echo [AVISO] No se encontro assets\splash\splash.jpg (imagen para splash).
)

REM ------------------------------------------------------------
REM PASO 1) flutter pub add flutter_launcher_icons
REM ------------------------------------------------------------
echo.
echo [PASO 1] Ejecutando: flutter pub add flutter_launcher_icons
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "flutter pub add flutter_launcher_icons"
if errorlevel 1 (
  echo [ERROR] Fallo: flutter pub add flutter_launcher_icons
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 1.1) flutter pub add flutter_native_splash
REM ------------------------------------------------------------
echo.
echo [PASO 1.1] Ejecutando: flutter pub add flutter_native_splash
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "flutter pub add flutter_native_splash"
if errorlevel 1 (
  echo [ERROR] Fallo: flutter pub add flutter_native_splash
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 2) Configuracion flutter_launcher_icons en pubspec.yaml
REM   - Solo si NO existe bloque raiz 'flutter_launcher_icons:'
REM   - Usa assets/icons/icono.jpg
REM ------------------------------------------------------------
echo.
echo [PASO 2] Configurando bloque flutter_launcher_icons en pubspec.yaml

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$path = 'pubspec.yaml';" ^
  "$content = Get-Content $path -Raw;" ^
  "$hasRootIcons = $content -match '(?m)^\s*flutter_launcher_icons:\s*$';" ^
  "if ($hasRootIcons) {" ^
  "  Write-Host '[INFO] Ya existe flutter_launcher_icons: en el pubspec. No se duplica.';" ^
  "} else {" ^
  "  $block = \"`r`nflutter_launcher_icons:`r`n  android: \"\"launcher_icon\"\"`r`n  image_path: \"\"assets/icons/icono.jpg\"\"\";" ^
  "  Add-Content -Path $path -Value $block;" ^
  "  Write-Host '[OK] Bloque flutter_launcher_icons agregado al FINAL del pubspec.yaml';" ^
  "}"

if errorlevel 1 (
  echo [ERROR] No se pudo escribir flutter_launcher_icons en pubspec.yaml
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 2.1) Configuracion flutter_native_splash en pubspec.yaml
REM   - Solo Android, fondo blanco, splash separado
REM   - Usa assets/splash/splash.jpg y Android 12 igual
REM   - Solo si NO existe bloque raiz 'flutter_native_splash:'
REM ------------------------------------------------------------
echo.
echo [PASO 2.1] Configurando bloque flutter_native_splash en pubspec.yaml

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$path = 'pubspec.yaml';" ^
  "$content = Get-Content $path -Raw;" ^
  "$hasRootSplash = $content -match '(?m)^\s*flutter_native_splash:\s*$';" ^
  "if ($hasRootSplash) {" ^
  "  Write-Host '[INFO] Ya existe flutter_native_splash: en el pubspec. No se duplica.';" ^
  "} else {" ^
  "  $block = \"`r`nflutter_native_splash:`r`n  android: true`r`n  ios: false`r`n  web: false`r`n  color: \"\"#ffffff\"\"`r`n  image: \"\"assets/splash/splash.jpg\"\"`r`n  android_12:`r`n    image: \"\"assets/splash/splash.jpg\"\"`r`n    color: \"\"#ffffff\"\"\";" ^
  "  Add-Content -Path $path -Value $block;" ^
  "  Write-Host '[OK] Bloque flutter_native_splash agregado al FINAL del pubspec.yaml';" ^
  "}"

if errorlevel 1 (
  echo [ERROR] No se pudo escribir flutter_native_splash en pubspec.yaml
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 3) flutter pub get
REM ------------------------------------------------------------
echo.
echo [PASO 3] Ejecutando: flutter pub get
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "flutter pub get"
if errorlevel 1 (
  echo [ERROR] Fallo: flutter pub get
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 4) Generar ICONOS
REM ------------------------------------------------------------
echo.
echo [PASO 4] Ejecutando: dart run flutter_launcher_icons
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "dart run flutter_launcher_icons"
if errorlevel 1 (
  echo [ERROR] Fallo: dart run flutter_launcher_icons
  echo         Verifica que assets/icons/icono.jpg exista y YAML sea valido.
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 4.1) Generar SPLASH
REM ------------------------------------------------------------
echo.
echo [PASO 4.1] Ejecutando: dart run flutter_native_splash:create
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "dart run flutter_native_splash:create"
if errorlevel 1 (
  echo [ERROR] Fallo: dart run flutter_native_splash:create
  echo         Revisa la ruta de imagen y el bloque flutter_native_splash.
  exit /b 1
)

REM ------------------------------------------------------------
REM PASO 5) Ejecutar la app
REM ------------------------------------------------------------
echo.
echo [PASO 5] Ejecutando: flutter run
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "flutter run"
if errorlevel 1 (
  echo [ERROR] Fallo: flutter run
  echo         Verifica tener un dispositivo/emulador activo (flutter devices).
  exit /b 1
)

echo.
echo [LISTO] Iconos y splash generados, app lanzada. %DATE% %TIME%
exit /b 0
