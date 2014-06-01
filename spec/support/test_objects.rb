# test objects

def grape_route_object
  g = Grape::Route.new
  g.options = { path: '/', method: 'GET' }
  g
end

module SampleApiOne
  class API < Grape::API
  end
end

module SampleApiTwo
  class API < Grape::API
  end
end

class SampleApiThree < Grape::API
end

Grape::API.subclasses.each do |api|
  api.routes << grape_route_object
end
