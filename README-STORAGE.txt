ADEL INVEST — Activation du dépôt de documents

1. Dans Supabase, ouvrez SQL Editor > New query.
2. Ouvrez CONFIGURATION-STORAGE.sql, copiez tout son contenu dans l'éditeur SQL et cliquez sur Run.
3. Vérifiez dans Storage que le bucket « documents » existe et qu'il est privé.
4. Remplacez le fichier index.html du dépôt GitHub par celui de ce dossier.
5. Publiez les changements sur GitHub Pages et reconnectez-vous à l'espace porteur.
6. Ouvrez Mes documents ou cliquez sur « Joindre un document » depuis Mon projet.

Formats acceptés : PDF, JPG, JPEG, PNG, DOC, DOCX, XLS, XLSX.
Taille maximale : 10 Mo par fichier.

Sécurité : les fichiers sont stockés dans le chemin user_id/fiche_id/nom_fichier.
Le bucket est privé ; l'ouverture se fait avec une URL signée temporaire (60 secondes).
Les politiques Storage de CONFIGURATION-STORAGE.sql limitent lecture et dépôt au propriétaire.

Important : cette version conserve les documents dans Supabase Storage. Elle n'ajoute pas de ligne
à la table public.documents, car le schéma exact de cette table n'a pas été fourni. La page
« Mes documents » lit directement Storage pour éviter d'inventer des noms de colonnes SQL.
Les administrateurs ne disposent pas encore d'un accès transversal aux fichiers des porteurs.
