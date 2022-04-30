# frozen_string_literal: true

require_relative "hexlet_code/version"

# module
module HexletCode
  autoload :Tag, "hexlet_code/tag.rb"
  autoload :Form, "hexlet_code/form.rb"

  class Error < StandardError; end

  def self.form_for(user, **attributes)
    form = Form.new(user, attributes)
    yield form
    inner = form.html.map do |item|
      render(item)
    end.join
    url = form.attributes[:url] || "#"
    tag_attributes = { action: url, method: "post" }.merge(form.attributes.except(:url))
    Tag.build("form", **tag_attributes) { inner }
  end

  def self.render(item)
    label = Tag.build("label", for: item[:name]) { item[:name].capitalize }
    case item[:type]
    when :text
      label + Tag.build("textarea", cols: "20", rows: "40", name: item[:name]) { item[:value] }
    when :string
      label + Tag.build("input", name: item[:name], type: "text", value: item[:value])
    when :submit
      Tag.build("input", name: item[:name], type: "submit", value: item[:value])
    end
  end
end
