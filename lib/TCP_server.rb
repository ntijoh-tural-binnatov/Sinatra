require_relative 'HTTP-request'
require_relative 'router'
require 'socket'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def start
        server = TCPServer.new(@port)
        puts "LISTENING ON PORT: #{@port}"
        
        router = Router.new
        
        router.add_route("GET", "/index") do
            File.read("./views/index.html")
        end
        
        
        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end
            puts "PORT REQUEST: RECIEVED!"
            puts "-" * 40

            #puts data
            puts "-" * 4
            request = Request.new(data)
            puts request
            #router.match_route(request)
            #Sen kolla om resursen (filen finns)


            # Nedanstående bör göras i en Response-klass
            
            route = router.has_route(request.resource, request.method)

            puts "banan"
            p route    

            if route
                content_type = "text/html"
                content = route[:block].call
                status = 200 
            elsif File.file?("public#{request.resource}")
                #kolla filändelsen (.css, .js), sen if
                
                status = 200
                content_type = "text/css"
                content = File.read("public#{request.resource}")


            else
                content = "<h1>ERROR 404!!</h1>"
                status = 404
            end
            
            session.print "HTTP/1.1 #{status}\r\n"
            session.print "Content-Type: #{content_type}\r\n" #content_type
            session.print "\r\n"
            session.print content
            session.close
        end
    end
end