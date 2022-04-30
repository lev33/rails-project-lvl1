# frozen_string_literal: true

require_relative "hexlet_code/version"

# module
module HexletCode
  autoload :Tag, "hexlet_code/tag.rb"
  autoload :Form, "hexlet_code/form.rb"

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

    Tag.build("form", action: url, method: "post") { inner }
  end
end
