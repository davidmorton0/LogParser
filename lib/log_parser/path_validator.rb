class PathValidator

  VALID_PATH = '^(/[a-zA-Z0-9.$_+\\-!*(),\']+/?)*/?$'

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def valid_path?
    !!path.match(VALID_PATH)
  end

end
