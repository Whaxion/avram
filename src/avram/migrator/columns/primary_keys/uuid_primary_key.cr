require "./base"

module Avram::Migrator::Columns::PrimaryKeys
  class UUIDPrimaryKey < Base
    def initialize(@name)
    end

    def column_type : String
      "uuid"
    end

    def build(composite : Bool = false) : String
      %(  #{name} #{column_type}#{" PRIMARY KEY" if !composite} DEFAULT gen_random_uuid())
    end
  end
end
