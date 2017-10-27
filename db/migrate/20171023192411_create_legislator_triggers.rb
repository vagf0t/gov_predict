
class CreateLegislatorTriggers < ActiveRecord::Migration[5.0]
  def up
    execute '-- Create a trigger function to create people from legislators:

                 CREATE OR REPLACE FUNCTION create_legislator()
                   RETURNS trigger AS
                 $BODY$
                 DECLARE
                   legislator INTEGER;
                   person_id INTEGER;
                   facebook_type_id INTEGER;
                   twitter_type_id INTEGER;
                   country_id INTEGER;
                 BEGIN

                   --Check if legislator exists in people table:

                   SELECT people.id INTO legislator FROM people
                      INNER JOIN social_media_accounts ON people.id = social_media_accounts.person_id
                      WHERE people.name = NEW.first_name
                      AND people.surname = NEW.last_name
                      AND (social_media_accounts.user_id = NEW.facebook_id OR
                           social_media_accounts.user_id = NEW.twitter_username);

                   SELECT countries.id INTO country_id FROM countries LIMIT 1;

                   --Create a person, based on the legislator:

                   IF legislator IS NULL THEN
                     INSERT INTO people(name, surname, country_id, created_at, updated_at)
                       VALUES(NEW.first_name,
                              NEW.last_name,
                              country_id,
                              CURRENT_TIMESTAMP,
                              CURRENT_TIMESTAMP) RETURNING id INTO person_id;

                     --Create Facebook account:
                     IF NEW.facebook_id IS NOT NULL THEN
                       SELECT social_media_types.id INTO facebook_type_id FROM social_media_types
                                              WHERE name = \'Facebook\';
                       INSERT INTO social_media_accounts(user_id, social_media_type_id, person_id, created_at, updated_at)
                         VALUES(NEW.facebook_id, facebook_type_id, person_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
                     END IF;

                     --Create Twitter account:

                     IF NEW.twitter_username IS NOT NULL THEN
                       SELECT social_media_types.id INTO twitter_type_id FROM social_media_types
                           WHERE name = \'Twitter\';
                       INSERT INTO social_media_accounts(user_id, social_media_type_id, person_id, created_at, updated_at)
                         VALUES(NEW.twitter_username, twitter_type_id, person_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
                     END IF;
                   ELSE
                     --Update:

                     UPDATE social_media_accounts
                       SET user_id=NEW.facebook_id
                       WHERE social_media_accounts.person_id = legislator AND
                       social_media_accounts.social_media_type_id =
                       (SELECT id FROM social_media_types WHERE name = \'Facebook\');

                     UPDATE social_media_accounts
                       SET user_id=NEW.twitter_username
                       WHERE social_media_accounts.person_id = legislator AND
                       social_media_accounts.social_media_type_id =
                       (SELECT id FROM social_media_types WHERE name = \'Twitter\');

                   END IF;

                   RETURN NEW;
                 END;
                 $BODY$
                 LANGUAGE plpgsql VOLATILE
                 COST 100;


                 -- Create a trigger function to update people from legislators:

                 CREATE OR REPLACE FUNCTION update_legislator()
                   RETURNS trigger AS
                 $BODY$
                 BEGIN
                   IF NEW.facebook_id <> OLD.facebook_id THEN
                     UPDATE social_media_accounts
                       SET user_id=NEW.facebook_id
                       WHERE social_media_accounts.user_id=OLD.facebook_id AND
                       social_media_accounts.social_media_type_id =
                       (SELECT id FROM social_media_types WHERE name = \'Facebook\');
                   END IF;

                   IF NEW.twitter_username <> OLD.twitter_username THEN
                     UPDATE social_media_accounts
                       SET user_id=NEW.twitter_username
                       WHERE social_media_accounts.user_id=OLD.twitter_username AND
                       social_media_accounts.social_media_type_id =
                       (SELECT id FROM social_media_types WHERE name = \'Twitter\');
                   END IF;

                   RETURN NEW;
                 END;
                 $BODY$
                 LANGUAGE plpgsql VOLATILE COST 100;


                 -- Create a trigger function to delete social media accounts from people:

                 CREATE OR REPLACE FUNCTION delete_legislator_account()
                   RETURNS trigger AS
                 $BODY$
                 BEGIN
                   DELETE FROM social_media_accounts
                    WHERE social_media_accounts.user_id=OLD.facebook_id AND
                     social_media_accounts.social_media_type_id =
                     (SELECT id FROM social_media_types WHERE name = \'Facebook\');

                   DELETE FROM social_media_accounts
                     WHERE social_media_accounts.user_id=OLD.twitter_username AND
                     social_media_accounts.social_media_type_id =
                     (SELECT id FROM social_media_types WHERE name = \'Twitter\');

                   RETURN NEW;
                 END;
                 $BODY$
                 LANGUAGE plpgsql VOLATILE COST 100;


                 --Create a trigger to fire on a legislator insert:

                 CREATE TRIGGER legislator_added
                 AFTER INSERT
                 ON federal_legislators
                 FOR EACH ROW
                 EXECUTE PROCEDURE create_legislator();


                 --Create a trigger to fire on a legislator update:

                 CREATE TRIGGER legislator_updated
                 AFTER UPDATE
                 ON federal_legislators
                 FOR EACH ROW
                 EXECUTE PROCEDURE update_legislator();


                 --Create a trigger to fire on a legislator delete:

                 CREATE TRIGGER legislator_deleted
                 AFTER DELETE
                 ON federal_legislators
                 FOR EACH ROW
                 EXECUTE PROCEDURE delete_legislator_account();'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
