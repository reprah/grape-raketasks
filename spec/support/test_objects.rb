# test objects

def grape_route_object
  g = Grape::Route.new
  g.options = { path: '/', method: 'GET' }
  g
end

class SampleApiOne
  class API < Grape::API
  end
end

class SampleApiTwo < Grape::API
  class API < Grape::API
  end
end

[SampleApiOne::API, SampleApiTwo::API].each do |api|
  api.routes << grape_route_object
end

