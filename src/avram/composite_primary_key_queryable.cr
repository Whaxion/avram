require "./errors"

module Avram::CompositePrimaryKeyQueryable(T)
  macro included
    def self.find(*ids)
      new.find(ids.to_a)
    end

    def self.find(ids)
      new.find(ids)
    end

    def find(*ids)
      find(ids.to_a)
    end

    def find(ids)
      ids(ids).limit(1).first? || raise Avram::RecordNotFoundError.new(model: table_name, id: ids.to_s)
    end

    {% primary_key_names = T.constant("PRIMARY_KEY_NAMES") %}
    def ids(*args, **named_args)
        {% for pk_name, index in primary_key_names %}
        {{ ".".id if index > 0 }}{{ pk_name.id }}(args.first[{{index}}], **named_args)
        {% end %}
    end

    def ids
      {% for pk_name, index in primary_key_names %}
      {{ pk_name.id }}()
      {% end %}
    end


    private def with_ordered_query : self
      if query.ordered?
        self
      else
        ids.asc_order
      end
    end
  end
end
