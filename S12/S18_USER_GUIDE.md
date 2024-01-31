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
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tutos_S12/Nmap.png?raw=true)
___________

## **_Présentation_**

**Nmap** : Outils de scan de ports de réseau.  
**Pré-requis:** Utilisation d'une machine Kali Linux. Nmap est installé de base sur cette distribution. Dans ce lab, la machine de tests d'intrusion est dans le réseau des machines cibles afin de tester les failles éventuelles de celui-ci.
______________
### **_Utilisation_**
Nmap se lance simplement en appellant le logiciel dans un terminale: nmap <options> <AdresseIP_cible>.  
Toutes les options d'utillisations sont sur le site [officiel](https://nmap.org/man/fr/man-briefoptions.html).
______________
Déterminer les hôtes en ligne d'un réseau avec l'option -sP:
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tutos_S12/Nmap%20-sP.png?raw=true)

____________________
Tester les ports ouverts et déterminer les services en écoute et leur version avec l'option -sV:
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tutos_S12/Nmap%20-sV.png?raw=true)
______________________
Déteminer l'OS de la cible avec l'option -O, et -sS afin de pas laisser de trace du scan sur la machine cible:
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tutos_S12/Nmap%20-O.png?raw=true)
______________
Afin de tester des ports spécifique, utiliser l'option -p:
```bash
nmap -p 22; 80; 443; 8080 172.18.1.*
```
**Le wildcard à la fin permet de spécifier tout le réseau 172.18.1.0/24**

Il est également possible de scanner une plage de ports avec la commande suivante pour les ports de 1 à 1000 en exemple:
```bash
nmap -p 1-1000 172.18.1.1
```
______________
______________

# **Medusa**
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tutos_S12/Medusa.png?raw=true)
______________

## **_Présentation_**

**Medusa** : Outils permettent de forcer une connexion ssh en craquant le mot de passe et un nom de session à partir de listes dictionnaire.
**Pré-requis:** Utilisation d'une machine Kali Linux. Medusa est installé de base sur cette distribution. Dans ce lab, la machine de tests d'intrusiion est dans le réseau des machines cibles afin de tester la sécurté de connexion ssh de celles-ci.
Une liste au format txt de noms d'utilisateurs aléatoire est généré ainsi qu'une list de mots de passe.
______________
### **_Utilisation_**
L'utilisation de Medusa se fait par un terminale. Avant de commencer le test, s'assurer d'être dans le même emplacement que les fichiers qui seront utilisés lors de l'attaque.
Dans cette exemple, l'emplacement est le **Desktop**:
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tutos_S12/Desk_Kali.png?raw=true)
Lancer la commande sous le format : >medusa -h <AdresseIP_cible> -U <Fichiers_txtUsers> -P <Fichier_txtMotDePasse> -M ssh
______________
______________
