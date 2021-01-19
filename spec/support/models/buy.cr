class Buy < BaseModel
  skip_default_columns

  table do
    primary_key user_id : Int64, product_id : UUID
    column quantity : Int32
  end
end

class BuyQuery < Buy::BaseQuery
end
