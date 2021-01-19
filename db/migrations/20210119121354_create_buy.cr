class CreateBuy::V20210119121354 < Avram::Migrator::Migration::V1
    def migrate
      create table_for(Buy) do
        primary_key user_id : Int64, product_id : UUID
        add quantity : Int32
      end
    end
  
    def rollback
      drop :buys
    end
  end
  