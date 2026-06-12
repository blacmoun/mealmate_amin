# MealMate 🍳

**Développé par :** Amin Jdidi

MealMate est une application mobile Flutter de découverte culinaire. Elle permet de parcourir des catégories de recettes, de rechercher des plats spécifiques, de consulter les détails (ingrédients, instructions) et de sauvegarder ses recettes préférées en local. Les données sont fournies par l'API publique TheMealDB.

---

## 🚀 Comment lancer l'application

### Prérequis

* **Flutter SDK :** Version 3.5.0 ou supérieure (testé avec la version 3.24.0).
* Un émulateur Android (via Android Studio) ou un appareil physique Android connecté.

### Installation et exécution

1. Clonez ce dépôt sur votre machine locale.
2. Ouvrez un terminal à la racine du projet et installez les dépendances :

```bash
flutter pub get
```

3. Lancez l'application (assurez-vous que votre émulateur est allumé) :

```bash
flutter run
```

---

## 📦 Dépendances utilisées

Conformément à la stack technique imposée, aucune librairie de génération de code ou de gestion d'état complexe n'a été utilisée.

* **provider: ^6.1.2** : Gestion de l'état global (Favoris et Thème).
* **http: ^1.2.2** : Appels réseau vers l'API TheMealDB.
* **shared_preferences: ^2.3.2** : Stockage local persistant des favoris et du mode sombre.
* **url_launcher: ^6.3.1** : Ouverture des liens YouTube dans le navigateur natif.

---

## 🛠️ Choix techniques et architecture

L'application suit une architecture modulaire simple divisée en dossiers (`models`, `providers`, `screens`, `services`, `widgets`) pour séparer clairement l'interface, la logique métier et l'accès aux données.

L'état global est géré via Provider avec des `ChangeNotifier` pour centraliser la logique, évitant ainsi la duplication d'état dans les widgets. L'API TheMealDB est consommée nativement via le package `http`, avec une désérialisation JSON manuelle et robuste (gestion des champs `null` et des tableaux vides).

Enfin, l'interface graphique s'appuie pleinement sur Material 3 (`useMaterial3: true`), en utilisant la navigation native 1.0 (`Navigator.push/pop`) pour une fluidité optimale et un respect strict des contraintes du projet.

---

## 🤖 Utilisation de l'IA

Conformément à la section « Aide autorisée » du cahier des charges, j'ai utilisé l'assistant IA Gemini durant ce projet pour m'accompagner sur les points suivants :

* Génération de la structure de base des fichiers lors de l'initialisation du projet (Semaine 1).
* Conseils de syntaxe pour la création des méthodes `fromJson` robustes afin de gérer les champs manquants de l'API TheMealDB.
* Mise en place de la structure des appels HTTP (`async/await`, `try/catch` et `timeout`) dans le service API.

L'IA a été utilisée comme un guide et un outil d'apprentissage, et j'ai moi-même intégré, testé et validé le code pour m'assurer qu'il respectait la stack technique stricte imposée.


## 📊 Évaluation SUS
Score moyen obtenu : 95 / 100

Analyse : Ce score, largement au-dessus du seuil d'utilisabilité attendu, confirme que la navigation de base et la gestion des favoris sont intuitives pour les testeurs. Néanmoins, pour tutoyer l'excellence, il serait judicieux d'améliorer le contraste visuel du bouton d'ajout aux favoris sur l'écran des détails, afin d'attirer encore plus l'œil dès la première utilisation.