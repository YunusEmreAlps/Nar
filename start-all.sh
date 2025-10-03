#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=========================================="
echo "      Starting Nar Microservices"
echo "=========================================="

# Function to check if port is available
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo -e "${RED}Port $port is already in use!${NC}"
        return 1
    fi
    return 0
}

# Function to wait for service to start
wait_for_service() {
    local port=$1
    local service_name=$2
    local timeout=$3
    
    echo -e "${YELLOW}Waiting for $service_name to start on port $port...${NC}"
    
    for i in $(seq 1 $timeout); do
        if curl -s http://localhost:$port/actuator/health >/dev/null 2>&1; then
            echo -e "${GREEN}$service_name is ready!${NC}"
            return 0
        fi
        sleep 1
        echo -n "."
    done
    
    echo -e "${RED}$service_name failed to start within $timeout seconds${NC}"
    return 1
}

# Check if ports are available
echo "Checking port availability..."
check_port 5858 || exit 1
check_port 5859 || exit 1
check_port 5860 || exit 1

echo -e "${GREEN}All ports are available!${NC}"

# Start Discovery Server first
echo
echo -e "${BLUE}[1/3] Starting Discovery Server...${NC}"
cd discovery-server
./gradlew bootRun > ../logs/discovery-server.log 2>&1 &
DISCOVERY_PID=$!
cd ..
echo "Discovery Server PID: $DISCOVERY_PID"

# Wait for Discovery Server to be ready
wait_for_service 5858 "Discovery Server" 60

# Start Config Server
echo
echo -e "${BLUE}[2/3] Starting Config Server...${NC}"
cd config-server
./gradlew bootRun > ../logs/config-server.log 2>&1 &
CONFIG_PID=$!
cd ..
echo "Config Server PID: $CONFIG_PID"

# Wait for Config Server to be ready
wait_for_service 5859 "Config Server" 45

# Start API Gateway
echo
echo -e "${BLUE}[3/3] Starting API Gateway...${NC}"
cd api-gateway
./gradlew bootRun > ../logs/api-gateway.log 2>&1 &
GATEWAY_PID=$!
cd ..
echo "API Gateway PID: $GATEWAY_PID"

# Wait for API Gateway to be ready
wait_for_service 5860 "API Gateway" 45

echo
echo "=========================================="
echo -e "${GREEN}       All Services Are Running!${NC}"
echo "=========================================="
echo
echo "Service Information:"
echo "┌─────────────────┬──────┬────────────────┬─────────────────────────────────┐"
echo "│ Service         │ Port │ PID            │ URL                             │"
echo "├─────────────────┼──────┼────────────────┼─────────────────────────────────┤"
echo "│ Discovery Server│ 5858 │ $DISCOVERY_PID │ http://localhost:5858           │"
echo "│ Config Server   │ 5859 │ $CONFIG_PID    │ http://localhost:5859           │"
echo "│ API Gateway     │ 5860 │ $GATEWAY_PID   │ http://localhost:5860           │"
echo "└─────────────────┴──────┴────────────────┴─────────────────────────────────┘"
echo
echo "Log files are available in the 'logs' directory."
echo
echo "To stop all services, run: ./stop-all.sh"
echo "Or manually kill processes: kill $DISCOVERY_PID $CONFIG_PID $GATEWAY_PID"

# Create PID file for easy cleanup
echo "$DISCOVERY_PID $CONFIG_PID $GATEWAY_PID" > .nar-pids

# Wait for any service to exit
echo
echo -e "${YELLOW}Services are running. Press Ctrl+C to stop all services...${NC}"

# Function to cleanup on exit
cleanup() {
    echo
    echo -e "${YELLOW}Stopping all services...${NC}"
    kill $DISCOVERY_PID $CONFIG_PID $GATEWAY_PID 2>/dev/null
    rm -f .nar-pids
    echo -e "${GREEN}All services stopped.${NC}"
    exit 0
}

# Set trap to cleanup on script exit
trap cleanup SIGINT SIGTERM

# Wait for all background jobs
wait