@echo off
REM Build React AzanUI
cd AzanUI
npm install --legacy-peer-deps
npm run build

REM Build AzanUI server executable
npm install -g pkg
npx pkg AzanUI/server.js --targets node18-win-x64 --output dist/AzanUI.exe --config AzanUI/package.json
npx rcedit dist/AzanUI.exe --set-icon icon.ico


cd ..
pyinstaller AzanSchedular.spec
echo Build complete. Check the dist folder for AzanScheduler.exe and AzanUI.exe
pause

npx pkg  --icon icon.ico