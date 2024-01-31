# TSSR-Projet3-Groupe_2-BuildYourInfra

## User-guid BillU

### _Semaine_S12_

### _(Date de documentation: 31 Janvier 2024)_
_______________
## **Besoins initiaux du projet:**
L'infrastructure étant composé de plusieurs serveurs et clients de différents OS, des tests de sécurité sont réalisés cette semaine avec différents outils. Un logiciel IDS/IPS est ajouter au réseau afin d'alerter les anomalies sur le réseau.
______________
## **Choix techniques:**
**Snort** est installé sur le réseau en NIDS comme comme système de détection d'introduction.   
**Kali Linux** est utilisé afin de réaliser les différent tests d'intrusion sur les machines ou le réseau.  
**Nmap** est l'outil utilisé afin de réaliser l'attaque _Scan de ports_.  
**Medusa** est utilisé pour l'_Attaque force brute_ sur un serveur Debian.  

______________
______________

# **Nmap**
___________

## **_Présentation_**

**Nmap** : Outils de scan de ports de réseau.
**Pré-requis:** Utilisation d'une machine Kali Linux. Nmap est installé de base sur cette distribution. Dans ce lab, la machine de tests d'intrusion est dans le réseau des machines cibles afin de tester les failles éventuelles de celui-ci.
______________
### **_Utilisation_**

______________
______________

# **Medusa**
______________

## **_Présentation_**

**Medusa** : Outils permettent de forcer une connexion ssh en craquant le mot de passe et un nom de session à partir de listes dictionnaire.
**Pré-requis:** Utilisation d'une machine Kali Linux. Medusa est installé de base sur cette distribution. Dans ce lab, la machine de tests d'intrusiion est dans le réseau des machines cibles afin de tester la sécurté de connexion ssh de celles-ci.
Une liste de nom d'utilisateur aléatoire est généré ainsi qu'une list de mot de passe.
______________
### **_Utilisation_**

______________
______________
