-- ADEL INVEST : configuration d'un espace privé Supabase Storage pour les documents.
-- À exécuter une seule fois dans Supabase > SQL Editor.

-- Crée le bucket privé (10 Mo maximum par fichier).
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'documents',
  'documents',
  false,
  10485760,
  ARRAY[
    'application/pdf',
    'image/jpeg',
    'image/png',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ]
)
ON CONFLICT (id) DO UPDATE
SET public = false,
    file_size_limit = 10485760,
    allowed_mime_types = EXCLUDED.allowed_mime_types;

-- Chaque utilisateur connecté peut déposer et lire uniquement ses propres fichiers.
CREATE POLICY "adel_documents_upload_own"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'documents'
  AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
);

CREATE POLICY "adel_documents_read_own"
ON storage.objects
FOR SELECT
TO authenticated
USING (
  bucket_id = 'documents'
  AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
);

-- Autorise la suppression par le propriétaire du fichier si cette fonction est ajoutée ultérieurement.
CREATE POLICY "adel_documents_delete_own"
ON storage.objects
FOR DELETE
TO authenticated
USING (
  bucket_id = 'documents'
  AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
);
