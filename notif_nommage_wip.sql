DECLARE
	nouvel_auteur auteur.nomauteur % TYPE;
	meme_editeur editeur.nomediteur % TYPE;
	contrat auncontratchez % ROWTYPE;

BEGIN

	nouvel_auteur := NEW.nomauteur;

	SELECT DISTINCT INTO meme_editeur nomediteur
	FROM editeur
	WHERE editeur.nomediteur = nouvel_auteur;

	IF (meme_editeur IS NULL)
	THEN
		RETURN NEW;
	ELSE
		SELECT DISTINCT INTO contrat *
		FROM auncontratchez
		WHERE auncontratchez.lauteur = meme_editeur
		AND auncontratchez.lediteur = meme_editeur;
		
		IF (contrat IS NULL)
		THEN
			RETURN NEW;
		ELSE
			RAISE NOTICE 'L auteur % est chez un éditeur du même nom.', nouvel_auteur;
			RETURN NULL;

END;
