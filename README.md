# Rendu TP 04 : Services & DaemonSet

Ce document recense les commandes et fichiers utilisés pour réaliser le TP 04.

## 1. Déploiement Impératif (CLI)

### Commandes manuelles
```bash
kubectl create deployment redis --image=redis
kubectl create deployment hasher --image=dockercoins/hasher:v0.1
kubectl create deployment rng --image=dockercoins/rng:v0.1
kubectl create deployment webui --image=dockercoins/webui:v0.1
kubectl create deployment worker --image=dockercoins/worker:v0.1
```

### Challenge : Script de déploiement
Le fichier `deploy_app_coins.sh` automatise cette tâche.

![Déploiement Impératif](demo_imperative.gif)


### Exposition des services internes
Sans ces services, les composants ne peuvent pas communiquer entre eux (le worker ne trouve pas rng/hasher/redis).
```bash
kubectl expose deployment redis --port 6379
kubectl expose deployment rng --port 80
kubectl expose deployment hasher --port 80
```

### Exposition WebUI (NodePort)
```bash
kubectl expose deploy/webui --type=NodePort --port=80
```

---

## 2. Déploiement Déclaratif (YAML)

Le fichier `app-coins.yaml` regroupe l'ensemble de l'application (Deployments + Services).

![Déploiement Déclaratif](demo_declarative.gif)


---

## 3. DaemonSet (RNG)

Le fichier `rng.yaml` convertit le déploiement `rng` en DaemonSet pour assurer une instance par noeud.

![RNG DaemonSet](demo_daemonset.gif)
