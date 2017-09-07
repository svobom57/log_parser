require_relative '../lib/log_aggregator'

RSpec.describe LogAggregator do

  let(:aggregator) { LogAggregator.new }

  describe '#add_log' do
    it 'adds logs to the aggregator' do
      aggregator.add_log('/home', '255.255.255.255')
      aggregator.add_log('/home', '255.255.255.255')
      aggregator.add_log('/products', '255.255.255.255')

      expect(aggregator.log_entries.length).to eq 2
    end
  end

  describe '#group_by_views' do
    it 'returns LogGroup' do
      group = aggregator.group_by_views

      expect(group).to be_a(ViewsLogGroup)
    end

    it 'groups the logs by entry views' do
      aggregator.add_log('/products', '255.255.255.255')
      aggregator.add_log('/home', '255.255.255.255')
      aggregator.add_log('/home', '255.255.255.255')

      group = aggregator.group_by_views

      expect(group.length).to eq 2

      expect(group.first.url_path).to eq '/home'
      expect(group.first.views).to eq 2

      expect(group.last.url_path).to eq '/products'
      expect(group.last.views).to eq 1
    end
  end

  describe '#group_by_unique_views' do
    it 'returns LogGroup' do
      group = aggregator.group_by_unique_views

      expect(group).to be_a(UniqueViewsLogGroup)
    end

    it 'groups the logs by unique entry views' do
      aggregator.add_log('/home', '255.255.255.255')
      aggregator.add_log('/home', '255.255.255.255')

      aggregator.add_log('/products', 'localhost')

      group = aggregator.group_by_unique_views

      expect(group.length).to eq 2

      expect(group.first.url_path).to eq '/home'
      expect(group.first.views).to eq 1

      expect(group.last.url_path).to eq '/products'
      expect(group.last.views).to eq 1
    end
  end
end
