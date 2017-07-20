# frozen_string_literal: true
require_relative '../../test_helper'

class API::V1::City::RepresenterTest < ActiveSupport::TestCase
  let(:subject) { API::V1::City::Representer::Create }
  let(:record) { cities(:basic) }

  it 'should provide its fields' do
    record.divisions << FactoryGirl.create(:division, name: 'foo')
    result = subject.new(record).to_hash
    result['data']['attributes']['label'].must_equal 'Berlin'
    result['included'].second['type'].must_equal 'divisions'
    result['included'].second['attributes']['label'].must_equal 'foo'
  end
end