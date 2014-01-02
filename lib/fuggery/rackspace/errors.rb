module Fuggery
  module Rackspace
    class NoSuchServer   < StandardError; end
    class NoSuchVolume   < StandardError; end
    class NoSuchSnapshot < StandardError; end
    class NoSuchMount    < StandardError; end
    class DoingStuff     < StandardError; end
  end
end
