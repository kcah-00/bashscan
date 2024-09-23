#!/bin/bash

# Couleurs pour un affichage plus clair
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Fonction d'affichage de l'aide
usage() {
  echo -e "${YELLOW}Usage: $0 [options] <target>"
  echo -e "Options:"
  echo -e "  -H <subnet>     : Scanner les hôtes actifs dans une plage IP (ex: 192.168.1.0/24)"
  echo -e "  -p <ports>      : Scanner des ports spécifiques (ex: 22,80,443)"
  echo -e "  -r              : Scan rapide des ports communs"
  echo -e "  -a              : Scan complet de tous les ports (1-65535)"
  echo -e "  -h              : Afficher l'aide"
  echo -e "${NC}"
  exit 1
}

# Vérifie si Netcat est installé
check_dependencies() {
  if ! command -v nc > /dev/null; then
    echo -e "${RED}Netcat (nc) est requis mais n'est pas installé.${NC}"
    exit 1
  fi
}

# Fonction pour scanner les hôtes actifs
scan_hosts() {
  echo -e "${GREEN}Scanning active hosts on subnet: $1${NC}"
  for ip in $(seq 1 254); do
    ping -c 1 -W 1 "$1.$ip" &> /dev/null && echo -e "${GREEN}Host up: $1.$ip${NC}"
  done
}

# Fonction pour scanner des ports spécifiques
scan_ports() {
  target=$1
  ports=$2
  echo -e "${GREEN}Scanning ports $ports on target $target${NC}"
  IFS=',' read -ra PORT_LIST <<< "$ports"
  for port in "${PORT_LIST[@]}"; do
    nc -zv "$target" "$port" &> /dev/null && echo -e "${GREEN}Port $port open on $target${NC}" || echo -e "${RED}Port $port closed on $target${NC}"
  done
}

# Fonction pour un scan rapide des ports communs
quick_scan() {
  target=$1
  common_ports=(22 80 443 21 25 53 110 143 3306 8080)
  echo -e "${GREEN}Quick scanning common ports on target $target${NC}"
  for port in "${common_ports[@]}"; do
    nc -zv "$target" "$port" &> /dev/null && echo -e "${GREEN}Port $port open on $target${NC}" || echo -e "${RED}Port $port closed on $target${NC}"
  done
}

# Fonction pour un scan complet (tous les ports 1-65535)
full_scan() {
  target=$1
  echo -e "${GREEN}Full scanning all ports (1-65535) on target $target${NC}"
  for port in $(seq 1 65535); do
    nc -zv "$target" "$port" &> /dev/null && echo -e "${GREEN}Port $port open on $target${NC}"
  done
}

# Analyse des arguments
if [ "$#" -lt 1 ]; then
  usage
fi

# Vérifie les dépendances
check_dependencies

# Variables
while getopts "H:p:rah" opt; do
  case $opt in
    H) subnet="$OPTARG";;
    p) ports="$OPTARG";;
    r) quick=1;;
    a) full=1;;
    h) usage;;
    *) usage;;
  esac
done
shift $((OPTIND -1))

# Cible à scanner
target=$1

# Exécution du scan selon les options fournies
if [ -n "$subnet" ]; then
  scan_hosts "$subnet"
elif [ -n "$ports" ]; then
  if [ -z "$target" ]; then
    usage
  fi
  scan_ports "$target" "$ports"
elif [ -n "$quick" ]; then
  if [ -z "$target" ]; then
    usage
  fi
  quick_scan "$target"
elif [ -n "$full" ]; then
  if [ -z "$target" ]; then
    usage
  fi
  full_scan "$target"
else
  usage
fi
