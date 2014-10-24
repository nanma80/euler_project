require File.expand_path('../lib/loader', __FILE__)
require File.expand_path('../lib/loader_buffer', __FILE__)

require File.expand_path('../lib/cell', __FILE__)
require File.expand_path('../lib/constraint', __FILE__)
require File.expand_path('../lib/grid', __FILE__)

p Loader.execute(testing: true)
