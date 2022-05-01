# frozen_string_literal: true

module HexletCode
  # documentation comment
  class Form
    attr_reader :user, :attributes, :html

    def initialize(user, attributes)
      @user = user
      @attributes = attributes
      @html = []
    end

    def input(name, **attributes)
      value = user.send name
      type = attributes[:as] || :string
      @html << { name: name, attributes: attributes.except(:as), type: type, value: value }
    end

    def submit(value = 'Save', **attributes)
      @html << { name: :commit, attributes: attributes, type: :submit, value: value }
    end
  end
end
