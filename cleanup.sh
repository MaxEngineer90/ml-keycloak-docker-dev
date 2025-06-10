#!/bin/bash

# Docker Cleanup Script - Entfernt alle Docker Container, Images, Networks, Volumes
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${RED}🧹 Docker Cleanup - ACHTUNG: Entfernt ALLE Docker Daten!${NC}"
echo -e "${RED}======================================================${NC}"
echo -e "${YELLOW}Dies entfernt:${NC}"
echo -e "   - Alle gestoppten Container"
echo -e "   - Alle unbenutzten Images"  
echo -e "   - Alle unbenutzten Networks"
echo -e "   - Alle unbenutzten Volumes"
echo -e "   - Build Cache"
echo -e ""

read -p "Wirklich ALLES löschen? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Abgebrochen.${NC}"
    exit 0
fi

echo -e "${YELLOW}🛑 Stoppe alle laufenden Container...${NC}"
docker stop $(docker ps -aq) 2>/dev/null || echo "Keine laufenden Container"

echo -e "${YELLOW}🗑️ Entferne alle Container...${NC}"
docker rm $(docker ps -aq) 2>/dev/null || echo "Keine Container zum Entfernen"

echo -e "${YELLOW}🗑️ Entferne alle Images...${NC}"
docker rmi $(docker images -aq) -f 2>/dev/null || echo "Keine Images zum Entfernen"

echo -e "${YELLOW}🗑️ System Cleanup (alles)...${NC}"
docker system prune -af --volumes

echo -e "${YELLOW}🗑️ Entferne alle Volumes...${NC}"
docker volume prune -f

echo -e "${YELLOW}🗑️ Entferne alle Networks...${NC}"
docker network prune -f

echo -e "${GREEN}✅ Docker Cleanup abgeschlossen!${NC}"
echo -e "${GREEN}💾 Freier Speicher:${NC}"
docker system df

echo -e "\n${GREEN}🚀 Bereit für einen frischen Start!${NC}"