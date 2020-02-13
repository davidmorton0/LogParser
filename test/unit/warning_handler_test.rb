require 'test_helper'

class WarningHandlerTest < Minitest::Test
  include TestData

  def test_stores_warnings
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.set_warning_info(warning_info: WARNING_INFO)
    assert_equal TEST_WARNINGS, warning_handler.warnings
  end

  def test_returns_warnings_summary
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.set_warning_info(warning_info: WARNING_INFO)
    assert_equal WARNINGS_SUMMARY, warning_handler.warnings_summary
  end

  def test_returns_important_warnings
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.set_warning_info(warning_info: WARNING_INFO)
    assert_equal WARNINGS_IMPORTANT, warning_handler.important_warnings
  end

  def test_returns_full_warnings
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.set_warning_info(warning_info: WARNING_INFO)
    assert_equal WARNINGS_FULL, warning_handler.full_warnings
  end

  def test_pluralises_multiple_items
    assert_equal 'things', WarningHandler.new().pluralise('thing', 5)
  end

  def test_doesnt_pluralise_single_items
    assert_equal 'thing', WarningHandler.new().pluralise('thing', 1)
  end

  def test_makes_warnings_summary
    assert_equal 'Type: 1 warning', WarningHandler.new().warning_summary('Type', 1)
  end

end
