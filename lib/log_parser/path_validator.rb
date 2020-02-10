class PathValidator
  include Constants
  
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def valid_path?
    !!path.match(VALID_PATH)
  end

end
