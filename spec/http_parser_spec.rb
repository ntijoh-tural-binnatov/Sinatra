# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Request' do
  describe 'Simple GET request' do
    it 'parses the http verb' do
      @request = Request.new(File.read('get-index.request.txt'))
      @request.method.must_equal 'get'
    end

    it 'parses the resource' do
      @request = Request.new(File.read('get-index.request.txt'))
      @request.resource.must_equal '/'
    end
  end
  describe 'get-requests with url params' do
  end
end
