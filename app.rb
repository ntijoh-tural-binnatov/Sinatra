require_relative 'lib/TCP_server'

server = HTTPServer.new(4567)
server.start
