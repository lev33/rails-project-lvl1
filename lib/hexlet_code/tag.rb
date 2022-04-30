# frozen_string_literal: true

module HexletCode
  # documentation comment
  class Tag
    def self.build(name, **attributes)
      attributes = attributes.map do |key, value|
        %( #{key}="#{value}")
      end.join

      if %w[br img input].include?(name)
        %(<#{name}#{attributes}>)
      elsif block_given?
        %(<#{name}#{attributes}>#{yield}</#{name}>)
      else
        %(<#{name}#{attributes}></#{name}>)
      end
    end
  end
end
