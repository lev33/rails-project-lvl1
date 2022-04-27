# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_does_something_useful
    expected = File.read("test/fixtures/test_it_does_something_useful.html")
    pp expected
    user = User.new name: "rob", job: "hexlet", gender: "m"
    result = HexletCode.form_for user do |f|
      # Проверяет есть ли значение внутри name
      f.input :name
      # Проверяет есть ли значение внутри job
      f.input :job, as: :text
    end
    pp result
    assert expected == result
  end

  def test_field_does_not_exist_error
    user = User.new job: "hexlet"
    assert_raises NoMethodError do
      HexletCode.form_for user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        # Поля age у пользователя нет
        f.input :age
        f.submit
      end
    end
  end
end
