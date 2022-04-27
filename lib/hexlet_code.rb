# frozen_string_literal: true

require_relative "hexlet_code/version"

# module
module HexletCode
  class Error < StandardError; end

  def self.form_for(user, url: "#")
    Tag.build("form", action: url, method: "post") do
      yield(Form.new(user)) if block_given?
    end
  end

  # documentation comment
  class Form
    attr_reader :user

    def initialize(user)
      @user = user
      @html = ""
    end

    def input(name, **attributes)
      value = user.send name
      @html += case attributes[:as]
               when :text
                 Tag.build("textarea", cols: "20", rows: "40", name: name) { value }
               else
                 Tag.build("input", name: name, type: "text", value: value)
               end
    end
  end

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
