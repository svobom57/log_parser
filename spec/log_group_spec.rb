require_relative '../lib/log_group'

RSpec.describe LogGroup do
  describe '#print' do

    context ViewsLogGroup do
      it 'prints the logs to STDOUT' do
        aggr1 = double(:aggregate_log_entry, entry: '/home', views: 5)
        aggr2 = double(:aggregate_log_entry, entry: '/products', views: 10)
        group = ViewsLogGroup.new([aggr1, aggr2])

        expect(STDOUT).to receive(:puts).with('/home 5 visits')
        expect(STDOUT).to receive(:puts).with('/products 10 visits')

        group.print
      end
    end

    context UniqueViewsLogGroup do
      it 'prints the logs to STDOUT' do
        aggr1 = double(:aggregate_log_entry, entry: '/home', views: 5)
        aggr2 = double(:aggregate_log_entry, entry: '/products', views: 10)
        group = UniqueViewsLogGroup.new([aggr1, aggr2])

        expect(STDOUT).to receive(:puts).with('/home 5 unique views')
        expect(STDOUT).to receive(:puts).with('/products 10 unique views')

        group.print
      end
    end

    it 'raises RuntimeError when called on abstract LogGroup' do
      group = LogGroup.new([])

      expect{ group.print }.to raise_error RuntimeError
    end
  end
end
