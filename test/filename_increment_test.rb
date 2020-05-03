require "test_helper"

class FilenameIncrementTest < Minitest::Test
  def test_path
    assert_equal FilenameIncrement.new('foo/bar.txt', platform: 'win32').to_s, 'foo/bar (2).txt'
    assert_equal FilenameIncrement.new('foo/bar.txt', platform: 'linux').to_s, 'foo/bar (copy).txt'
    assert_equal FilenameIncrement.new('foo/bar.txt', platform: 'darwin').to_s, 'foo/bar copy.txt'
  end
end
