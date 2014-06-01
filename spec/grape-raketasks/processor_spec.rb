require 'spec_helper'

describe GrapeRakeTasks::Processor do
  describe '#filter_by_api' do
    let(:routes) do
      GrapeRakeTasks::Route.all_routes(Grape::API)
    end

    let(:processor) { described_class.new(routes) }

    shared_examples 'successful API filtering' do
      it 'returns routes belonging to one API' do
        filtered = processor.filter_by_api(filter)
        filtered_apis = filtered.map(&:route_api)
        expect(filtered_apis).to eq [SampleApiOne::API]
      end
    end

    context 'when given a Grape API to filter by' do
      let(:filter) { 'SampleAPIOne::API' }

      it_behaves_like 'successful API filtering'

      context "when filter's case does not exactly match an API" do
        let(:filter) { 'SampleApiOne::API' }

        it_behaves_like 'successful API filtering'
      end

      context 'when API is not nested within another constant' do
        let(:filter) { 'SampleAPIThree' }

        it 'returns routes belonging to that api' do
          filtered = processor.filter_by_api(filter)
          filtered_apis = filtered.map(&:route_api)
          expect(filtered_apis).to include(SampleApiThree)
        end
      end
    end

    context 'when no filter is given' do
      it 'returns routes from every Grape API' do
        unfiltered = processor.filter_by_api
        unfiltered_apis = unfiltered.map(&:route_api)
        expect(unfiltered_apis.length).to eq routes.length
      end
    end
  end
end
