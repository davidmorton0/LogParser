require 'test_helper'

class WarningHandlerTest < Minitest::Test

  WARNING_INFO = { warning_type_1: { name: 'Warning Type 1', important: false },
                   warning_type_2: { name: 'Warning Type 2', important: false },
                   warning_type_3: { name: 'Warning Type 3', important: true },
                   warning_type_4: { name: 'Warning Type 4', important: true },
                   warning_type_5: { name: 'Warning Type 5', important: true } }

  TEST_WARNINGS = [{ type: :warning_type_1, message: 'warning message 1' },
                   { type: :warning_type_2, message: 'warning message 2' },
                   { type: :warning_type_2, message: 'warning message 3' },
                   { type: :warning_type_2, message: 'warning message 3' },
                   { type: :warning_type_2, message: 'warning message 3' },
                   { type: :warning_type_3, message: 'warning message 4' },
                   { type: :warning_type_5, message: 'warning message 5' },
                   { type: :warning_type_5, message: 'warning message 6' } ]

WARNINGS_SUMMARY = [ 'Warning Type 1: 1 warning',
                     'Warning Type 2: 4 warnings',
                     'Warning Type 3: 1 warning',
                     'warning message 4',
                     'Warning Type 4: 0 warnings',
                     'Warning Type 5: 2 warnings',
                     'warning message 5',
                     'warning message 6', ]

 WARNINGS_IMPORTANT = [ 'Warning Type 3: warning message 4',
                        'Warning Type 5: warning message 5',
                        'Warning Type 5: warning message 6' ]

  WARNINGS_FULL = [ 'Warning Type 1: warning message 1',
                    'Warning Type 2: warning message 2',
                    'Warning Type 2: warning message 3',
                    'Warning Type 2: warning message 3',
                    'Warning Type 2: warning message 3',
                    'Warning Type 3: warning message 4',
                    'Warning Type 5: warning message 5',
                    'Warning Type 5: warning message 6' ]

  def test_stores_warnings
    warning_handler = WarningHandler.new(TEST_WARNINGS)
    warning_handler.set_warning_info(WARNING_INFO)
    assert_equal TEST_WARNINGS, warning_handler.warnings
  end

  def test_returns_warnings_summary
    warning_handler = WarningHandler.new(TEST_WARNINGS)
    warning_handler.set_warning_info(WARNING_INFO)
    assert_equal WARNINGS_SUMMARY, warning_handler.warnings_summary
  end

  def test_returns_important_warnings
    warning_handler = WarningHandler.new(TEST_WARNINGS)
    warning_handler.set_warning_info(WARNING_INFO)
    assert_equal WARNINGS_IMPORTANT, warning_handler.important_warnings
  end

  def test_returns_full_warnings
    warning_handler = WarningHandler.new(TEST_WARNINGS)
    warning_handler.set_warning_info(WARNING_INFO)
    assert_equal WARNINGS_FULL, warning_handler.full_warnings
  end

end
