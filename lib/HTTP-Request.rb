class Request
  attr_reader :method, :resource, :version, :headers, :params
  
  def initialize(request_string)
    lines = request_string.split("\r\n")
    
    parse_request_line(lines[0])

    parse_headers(lines[1..-1])

    parse_params if @method == 'GET'
  end

  private

  def parse_request_line(line)
    @method, @resource, @version = line.split(' ')
  end

  def parse_headers(lines)
    @headers = lines.each_with_object({}) do |line, hash|
      key, value = line.split(': ')
      hash[key] = value
    end
  end

  def parse_params
    @params = {}
    if @resource.include?('?')
      params_str = @resource.split('?')[1]
      params_str.split('&').each do |param|
        key, value = param.split('=')
        @params[key] = value
      end
    end
  end
end

# request_string = File.read('get-index.request.txt')
# request = Request.new(request_string)

# puts "Method: #{request.method}"
# puts "Resource: #{request.resource}"
# puts "Version: #{request.version}"
# puts "Headers: #{request.headers}"
# puts "Params: #{request.params}"
