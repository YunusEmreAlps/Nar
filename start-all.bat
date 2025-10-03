@echo off
echo ==========================================
echo      Starting Nar Microservices
echo ==========================================

echo.
echo [1/3] Starting Discovery Server...
start "Nar Discovery Server" cmd /c "cd discovery-server && gradlew bootRun"
echo Discovery Server is starting on port 5858...
timeout /t 30 /nobreak

echo.
echo [2/3] Starting Config Server...
start "Nar Config Server" cmd /c "cd config-server && gradlew bootRun"
echo Config Server is starting on port 5859...
timeout /t 20 /nobreak

echo.
echo [3/3] Starting API Gateway...
start "Nar API Gateway" cmd /c "cd api-gateway && gradlew bootRun"
echo API Gateway is starting on port 5860...

echo.
echo ==========================================
echo       All Services Are Starting!
echo ==========================================
echo.
echo Service URLs:
echo - Discovery Server: http://localhost:5858
echo - Config Server:    http://localhost:5859
echo - API Gateway:      http://localhost:5860
echo.
echo Check the individual windows for service logs.
echo Press any key to exit this script...
pause >nul