require "./errors"

module Avram::CompositePrimaryKeyQueryable(T)
  macro included
    def self.find(*args, **named_args)
      new.find(*args, **named_args)
    end

    def find(*args, **named_args)
      ids(*args, **named_args).limit(1).first? || raise Avram::RecordNotFoundError.new(model: table_name, id: (args.to_a + named_args.to_a).to_s)
    end

    {% pk_names = T.constant("PRIMARY_KEY_NAMES") %}
    {% pk_types = T.constant("PRIMARY_KEY_TYPES") %}
    
    def ids(
      {% for pk_name, i in pk_names %}
        {{pk_name.id}} : {{pk_types[i]}},
      {% end %}
    )
      {% for pk_name, i in pk_names %}
        {{ ".".id if i > 0 }}{{ pk_name.id }}({{ pk_name.id }})
      {% end %}
    end
    
    #private def with_ordered_query : self
    #  if query.ordered?
    #    self
    #  else
    #    ids.asc_order
    #  end
    #end
  end
end
