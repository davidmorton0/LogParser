require 'test_helper'

class PathValidatorTest < Minitest::Test

  def test_validates_basic_path
    assert PathValidator.new(path: '/home').valid?
  end

  def test_validates_uppercase_path
    assert PathValidator.new(path: '/HOME').valid?
  end

  def test_validates_2_level_path
    assert PathValidator.new(path: '/home/level').valid?
  end

  def test_validates_5_level_path
    assert PathValidator.new(path: '/home/level/level/level/level').valid?
  end

  def test_validates_path_with_numbers
    assert PathValidator.new(path: '/12345').valid?
  end

  def test_validates_ending_in_forward_slash
    assert PathValidator.new(path: '/home/').valid?
  end

  def test_validates_path_with_dot
    assert PathValidator.new(path: '/index.html').valid?
  end

  def test_validates_path_with_special_characters
    assert PathValidator.new(path: '/$_.+-!*()\',').valid?
  end

  def test_path_must_start_with_forward_slash
    refute PathValidator.new(path: 'home').valid?
  end

  def test_path_cannot_contain_spaces
    refute PathValidator.new(path: '/ home').valid?
  end

  def test_path_cannot_contain_1# "
    refute PathValidator.new(path: '/home"').valid?
  end

  def test_path_cannot_contain_2# <
    refute PathValidator.new(path: '/home<').valid?
  end

  def test_path_cannot_contain_3# >
    refute PathValidator.new(path: '/home>').valid?
  end

  def test_path_cannot_contain_4# #
    refute PathValidator.new(path: '/home#').valid?
  end

  def test_path_cannot_contain_5# %
    refute PathValidator.new(path: '/home%').valid?
  end

  def test_path_cannot_contain_6# {
    refute PathValidator.new(path: '/home{').valid?
  end

  def test_path_cannot_contain_7# }
    refute PathValidator.new(path: '/home}').valid?
  end

  def test_path_cannot_contain_8# |
    refute PathValidator.new(path: '/home|').valid?
  end

  def test_path_cannot_contain_9# ^
    refute PathValidator.new(path: '/home^').valid?
  end

  def test_path_cannot_contain_10# ~
    refute PathValidator.new(path: '/home~').valid?
  end

  def test_path_cannot_contain_11# [
    refute PathValidator.new(path: '/home[').valid?
  end

  def test_path_cannot_contain_12# ]
    refute PathValidator.new(path: '/home]').valid?
  end

  def test_path_cannot_contain_13# `
    refute PathValidator.new(path: '/home`').valid?
  end

end
