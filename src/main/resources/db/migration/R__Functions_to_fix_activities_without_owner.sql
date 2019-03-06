CREATE OR replace FUNCTION get_default_owner() RETURNS "user" AS $$
declare
	nom "user"%rowtype;
begin
	if not exists (select * from "user" where "user".username = 'Default Owner') then
		insert into "user" (id, username)
		values (nextval('id_generator'), 'Default Owner');
	end if;
	select * from "user"
	where username='Default Owner' INTO nom;
	return nom;
end
$$ LANGUAGE plpgSQL;