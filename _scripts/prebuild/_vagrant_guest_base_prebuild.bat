@echo off

@powershell -Command "& Set-ExecutionPolicy RemoteSigned"

@powershell -File _vagrant_guest_base_prebuild.ps1

