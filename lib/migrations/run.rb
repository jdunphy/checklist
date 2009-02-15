module Checklist
  class Migrations < Sequel::Migration
    def up
      create_table :tasks do
        primary_key :id
        varchar     :name
        boolean     :done, :default => false
        datetime    :task_for
      end
    end

    def down
      drop_table :tasks
    end
  end
end

Checklist::Migrations.apply(DB, :up)