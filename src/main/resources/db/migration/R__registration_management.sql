create or replace function register_user_on_activity(id_user bigint, id_activity bigint) returns registration as $$
declare
newId bigint;
res_registration registration%rowtype;
begin
newId = nextval('id_generator');
if not exists (select * from registration where user_id = id_user and activity_id = id_activity) then
	insert into registration (id, user_id, activity_id)
	values (newId, id_user, id_activity);

	select * into res_registration from registration
	where registration.id = newId;
	return res_registration;
else
	raise exception 'registration_already_exists';
end if;
end
$$ language plpgsql;

create or replace function unregister_user_on_activity(id_user bigint, id_activity bigint) returns void as $$
begin
	
if exists (select * from registration where user_id = id_user and activity_id = id_activity) then
	delete from registration
	where user_id = id_user and activity_id = id_activity;
else
	raise exception 'registration_not_found';
end if;
end
$$ language plpgsql;