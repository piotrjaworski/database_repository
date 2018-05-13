module DatabaseRepository
  class RecordNotFound < StandardError; end
  class RecordInvalid < StandardError; end
  class RecordNotDestroyed < StandardError; end

  class Base
    class << self
      attr_accessor :entity_class_name

      def entity(entity_class_name)
        @entity_class_name = entity_class_name
      end
    end

    def all
      entity.all
    end

    def build(**attributes)
      entity.new(attributes)
    end

    def find(id)
      entity.find(id)
    rescue ActiveRecord::RecordNotFound => e
      raise DatabaseRepository::RecordNotFound, e.message
    end

    def find_by(**attributes)
      entity.find_by(attributes)
    end

    def find_or_initialize_by(**attributes)
      entity.find_or_initialize_by(attributes)
    end

    def find_or_create_by(**attributes)
      entity.find_or_create_by(attributes)
    end

    def find_or_create_by!(**attributes)
      entity.find_or_create_by!(attributes)
    rescue ActiveRecord::RecordInvalid => e
      raise DatabaseRepository::RecordInvalid, e.message
    end

    def first(limit = nil)
      entity.first(limit)
    end

    def first!
      entity.first!
    rescue ActiveRecord::RecordNotFound => e
      raise DatabaseRepository::RecordNotFound, e.message
    end

    def last(limit = nil)
      entity.last(limit)
    end

    def last!
      entity.last!
    rescue ActiveRecord::RecordNotFound => e
      raise DatabaseRepository::RecordNotFound, e.message
    end

    def create(**attributes)
      entity.create(attributes)
    end

    def create!(**attributes)
      entity.create!(attributes)
    rescue ActiveRecord::RecordInvalid => e
      raise DatabaseRepository::RecordInvalid, e.message
    end

    def update(id, **attributes)
      find(id).tap do |record|
        record.update(attributes)
      end
    end

    def update!(id, **attributes)
      find(id).tap do |record|
        record.update!(attributes)
      end
    rescue ActiveRecord::RecordInvalid => e
      raise DatabaseRepository::RecordInvalid, e.message
    end

    def update_all(**attributes)
      entity.update_all(attributes)
    end

    def delete(id)
      find(id).delete
    end

    def destroy(id)
      find(id).destroy
    end

    def destroy!(id)
      find(id).destroy!
    rescue ActiveRecord::RecordNotDestroyed => e
      raise DatabaseRepository::RecordNotDestroyed, e.message
    end

    def delete_all
      entity.delete_all
    end

    def destroy_all
      entity.destroy_all
    end

    private

    def entity
      @_entity ||= Object.const_get(self.class.entity_class_name || self.class.name.match(/(.*)Repository/)[1])
    end
  end
end
