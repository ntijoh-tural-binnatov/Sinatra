class Router
    def initialize
        @routes = []
    end
    
    def add_route(method, route, &block)
        @routes << {method: method , route: route, block: block} 
    end
    
    #has_route("/index") #=> true
    #has_route("/banan") #=> false
    def has_route(resource, method)
        p "registered routes: #{@routes}\r\n" 
        p "incoming request: #{resource},#{method}"
        i = 0
        while i < @routes.length
            if @routes[i][:route] == resource &&  @routes[i][:method] == method
                return @routes[i]
            end
            i += 1
        end
        return false
    end
end
  