module Twitter
  class Backpack < ApplicationRecord

    def self.table_name
      'twitter_backpacks'
    end

    belongs_to :user, class_name: '::User', inverse_of: :backpacks
    belongs_to :tweet, class_name: '::Tweet', inverse_of: :backpacks

    scope :text, -> { where(backpack_type: 'texto') }
    scope :audiovisual, -> { where(backpack_type: 'audiovisual') }
    scope :tool, -> { where(backpack_type: 'herramienta') }
    scope :shared, -> { where(backpack_type: 'compartido') }

    def is_text?
      backpack_type == 'texto'
    end

    def is_audiovisual?
      backpack_type == 'audiovisual'
    end

    def is_tool?
      backpack_type == 'herramienta'
    end

    def is_shared?
      backpack_type == 'compartido'
    end

    enum backpack_type: %w[texto audiovisual herramienta compartido], _prefix: true

    def to_s
      backpack_type
    end
  end
end
