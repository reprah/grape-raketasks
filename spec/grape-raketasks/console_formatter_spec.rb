require 'spec_helper'

describe GrapeRakeTasks::ConsoleFormatter do
  let(:formatter) { described_class.new }

  describe '#construct_output' do
    before do
      formatter.stub(format_route: 'formatted route')
    end

    context 'when routes exist' do
      before do
        formatter.construct_output(['a route'])
      end

      it 'adds formatted routes to the buffer' do
        expect(formatter.buffer).to include('formatted route')
      end
    end

    context 'when no routes exist' do
      before do
        formatter.construct_output([])
      end

      it 'adds a message to the buffer' do
        msg = formatter.buffer.first
        expect(msg).to include("You don't have any Grape routes")
      end
    end
  end

  describe '#format_route' do
    let(:route_object) { grape_route_object }

    it 'returns a text representation of a route object' do
      result = formatter.format_route(route_object)
      expect(result).to match(/METHOD:\s+"GET"/)
    end
  end

  describe '#result' do
    before do
      formatter.construct_output([])
    end

    it 'returns the contents of the buffer as a string' do
      expect(formatter.result).to be_a(String)
    end
  end
end
