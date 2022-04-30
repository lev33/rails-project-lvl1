# frozen_string_literal: true

require_relative "hexlet_code/version"

# module
module HexletCode
  class Error < StandardError; end

  def self.form_for(user, url: "#")
    form = Form.new(user)
    yield form
    inner = form.html.map do |el|
      case el[:type]
      when :text
        Tag.build("label", for: el[:name]) { el[:name].capitalize } +
          Tag.build("textarea", cols: "20", rows: "40", name: el[:name]) { el[:value] }
      when :string
        Tag.build("label", for: el[:name]) { el[:name].capitalize } +
          Tag.build("input", name: el[:name], type: "text", value: el[:value])
      when :submit
        Tag.build("input", name: el[:name], type: "submit", value: el[:value])
      end
    end.join

    Tag.build("form",  action: url, method: "post") { inner }
  end

  # documentation comment
  class Form
    attr_reader :user, :html

    def initialize(user)
      @user = user
      @html = []
    end

    def input(name, **attributes)
      value = user.send name
      type = attributes[:as] || :string
      @html << { name: name, attributes: attributes.except(:as), type: type, value: value }
    end

    def submit(value = "Save", **attributes)
      @html << { name: :commit, attributes: attributes, type: :submit, value: value }
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
