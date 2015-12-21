:: install
@echo off

echo Download: Hugo
go get -v github.com/spf13/hugo

echo Install: npm dependencies
npm install

echo Install: bower dependencies
bower install

pause
exit /b