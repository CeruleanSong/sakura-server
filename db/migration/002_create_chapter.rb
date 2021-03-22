require 'sequel'

Sequel.migration do
	change do
		create_table?(:chapter) do
			primary_key(:id, 'int(11)')
			column(:chapter_id, 'varchar(16)', null: false, unique: true)
			column(:origin, 'varchar(256)', null: false, unique: true)
			column(:title, 'varchar(256)', null: true)
			column(:chapter_n, 'float(3)')
			column(:scanlator, 'varchar(32)')
			column(:released, 'datetime')
			column(:created, 'datetime', { default: Sequel.function(:CURRENT_TIMESTAMP) })
			column(:updated, 'timestamp', { default: Sequel.function(:CURRENT_TIMESTAMP) })
		end
		
		run("
			CREATE TRIGGER chapter_updated
			BEFORE INSERT ON chapter
			FOR EACH ROW
			BEGIN
				SET NEW.updated = CURRENT_TIMESTAMP;
			END
		")
	end
end