module FC
  module Rack
    class NoSuchServer   < StandardError; end
    class NoSuchVolume   < StandardError; end
    class NoSuchSnapshot < StandardError; end
    class NoSuchMount    < StandardError; end
  end
end
