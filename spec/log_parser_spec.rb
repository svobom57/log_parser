require 'tempfile'
require_relative '../lib/log_parser'

RSpec.describe LogParser do
  describe '#parse' do
    context 'file exists' do
      let(:log_path) do
        file = Tempfile.new('test-log.log')
        file.write(
            <<MSG
/help_page/1 126.318.035.038
/contact 184.123.665.067
MSG
        )
        file.close
        file.path
      end
      let(:log_parser) { LogParser.new(log_path) }

      it 'parses log file entries into aggregator' do
        log_aggregator = double(:log_aggregator)
        allow(LogAggregator).to receive(:new).and_return(log_aggregator)

        expect(log_aggregator).to receive(:add_log).with('/help_page/1', '126.318.035.038')
        expect(log_aggregator).to receive(:add_log).with('/contact', '184.123.665.067')

        log_parser.parse
      end

      it 'returns an aggregator instance' do
        expect(log_parser.parse).to be_a LogAggregator
      end
    end

    context 'file does not exist' do
      it 'aborts gracefully' do
        expect {
          LogParser.new('non-existent-log.log')
        }.to raise_error SystemExit
      end
    end
  end
end
