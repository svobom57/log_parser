require_relative '../lib/log_parser'

RSpec.describe LogParser do
  context 'integration' do
    let(:log_path) do
      file = Tempfile.new('complex-log.log')
      file.write(<<MSG
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
/about/2 444.701.448.104
/help_page/1 929.398.951.889
/index 444.701.448.104
/help_page/1 722.247.931.582
/about 061.945.150.735
/help_page/1 646.865.545.408
/home 235.313.352.950
/contact 184.123.665.067
/help_page/1 543.910.244.929
/home 316.433.849.805
MSG
      )
      file.close
      file.path
    end

    it 'integrates well' do
      expect {
        puts `./bin/parse_logs #{log_path}`
      }.to output(
               <<MSG
> Most Views
/help_page/1 5 visits
/home 3 visits
/contact 2 visits
/about/2 1 visits
/index 1 visits
/about 1 visits

> Most Unique Views
/help_page/1 5 unique views
/home 3 unique views
/contact 1 unique views
/about/2 1 unique views
/index 1 unique views
/about 1 unique views
MSG
           ).to_stdout
    end
  end
end
