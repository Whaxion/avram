abstract class Avram::Migrator::Columns::PrimaryKeys::Base
  macro inherited
    private getter name : String
  end

  abstract def column_type

  def build(composite : Bool = false) : String
    %(  #{name} #{column_type}#{" PRIMARY KEY" if !composite})
  end
end
