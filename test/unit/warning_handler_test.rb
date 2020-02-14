# frozen_string_literal: true

require 'test_helper'

class WarningHandlerTest < Minitest::Test
  include TestData

  def test_stores_warnings
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.store_warning_info(warning_info: WARNING_INFO)
    assert_equal TEST_WARNINGS.length, warning_handler.warnings.length
  end

  def test_warnings_summary_returns_all_warning_types
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.store_warning_info(warning_info: WARNING_INFO)
    assert warning_handler.warnings_summary[:warning_type_1]
    assert warning_handler.warnings_summary[:warning_type_2]
    assert warning_handler.warnings_summary[:warning_type_3]
    assert warning_handler.warnings_summary[:warning_type_4]
    assert warning_handler.warnings_summary[:warning_type_5]
  end

  def test_warnings_summary_returns_warning_names
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.store_warning_info(warning_info: WARNING_INFO)
    assert_equal 'Warning Type 1',
                 warning_handler.warnings_summary[:warning_type_1][:name]
    assert_equal 'Warning Type 3',
                 warning_handler.warnings_summary[:warning_type_3][:name]
  end

  def test_warnings_summary_returns_warning_importance
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.store_warning_info(warning_info: WARNING_INFO)
    refute warning_handler.warnings_summary[:warning_type_1][:important]
    assert warning_handler.warnings_summary[:warning_type_3][:important]
  end

  def test_warnings_summary_returns_warnings
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.store_warning_info(warning_info: WARNING_INFO)
    assert_equal 1, warning_handler.warnings_summary[:warning_type_1][:warnings]
                                   .length
    assert_equal 4, warning_handler.warnings_summary[:warning_type_2][:warnings]
                                   .length
  end

  def test_warnings_summary_returns_warning_messages
    warning_handler = WarningHandler.new(warnings: TEST_WARNINGS)
    warning_handler.store_warning_info(warning_info: WARNING_INFO)
    assert_match (/message 1/),
                 warning_handler.warnings_summary[:warning_type_1][:warnings][0]
    assert_match (/message 3/),
                 warning_handler.warnings_summary[:warning_type_2][:warnings][2]
  end
end
