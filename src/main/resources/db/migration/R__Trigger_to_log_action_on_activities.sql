--trigger si l'on modifie la table activity
create or replace function audit_modif_tables() returns trigger as $modif_table$
begin
	IF (TG_OP = 'DELETE') THEN
        INSERT INTO action_log SELECT nextval('id_generator'), 'delete', TG_TABLE_NAME, user, old.id;
        RETURN OLD;
    END IF;
    RETURN NULL; -- le résultat est ignoré car il s'agit d'un trigger AFTER
end 
$modif_table$ language plpgsql;