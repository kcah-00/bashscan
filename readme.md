# BashScan - Un outil de scan réseau en Bash

BashScan est un utilitaire de scan réseau développé en Bash, conçu pour remplacer des outils de scan traditionnels tels que **Nmap**. Il permet de détecter les hôtes actifs, de scanner les ports ouverts et de fournir des informations sur les services en cours d'exécution sur les cibles spécifiées.

L'objectif de BashScan est d'offrir une solution légère, simple et facile à modifier pour ceux qui préfèrent utiliser des scripts Bash ou qui souhaitent personnaliser leur propre outil de scan réseau.

## Fonctionnalités

- **Scan des hôtes actifs** : Découvrez rapidement les hôtes répondant sur un réseau.
- **Scan des ports** : Détectez les ports ouverts sur les hôtes spécifiés (TCP/UDP).
- **Identification des services** : Obtenez des informations sur les services en cours d'exécution sur les ports ouverts.
- **Mode rapide et détaillé** : Choisissez entre un scan rapide des ports communs ou un scan plus approfondi de tous les ports disponibles.
- **Personnalisable** : Entièrement codé en Bash, il est facile de modifier et d’adapter l’outil selon vos besoins spécifiques.

## Prérequis

- **Bash** (version 4.0 ou supérieure)
- **Netcat (nc)** : Utilisé pour l'analyse des ports.
- **ping** : Utilisé pour la détection des hôtes.

## Installation

Clonez le dépôt GitHub sur votre machine locale :

```bash
git clone https://github.com/kcah-00/bashscan.git
cd bashscan

supertest@naitways.com
