# frozen_string_literal: true

RSpec.describe CucumberGithubFormatter do # rubocop:disable Metrics/BlockLength
  subject { formatter.print_github_message(event) }

  let(:formatter) { described_class.new(config) }
  let(:event) { Struct.new(:result, :test_case).new(result, test_case) }
  let(:test_case) { Struct.new(:location, :name).new(location, 'Test case') }
  let(:location) { Struct.new(:file, :lines).new('file.rb', '1') }
  let(:config) { double(:config) }

  before { allow(config).to receive(:on_event).with(anything) }

  it 'has a version number' do
    expect(CucumberGithubFormatter::VERSION).not_to be nil
  end

  it 'sets event trigger on initialize' do
    expect(config).to receive(:on_event).with(:test_case_finished)
    formatter
  end

  context 'when event failed' do
    let(:result) { Struct.new(:failed?, :exception).new(true, exception) }
    let(:exception) { Exception.new('oops') }

    before { exception.set_backtrace(['file.rb:1']) }

    it 'puts error message' do
      output = "::error file=file.rb,line=1::Test case failed: oops\n"
      expect { subject }.to output(output).to_stdout
    end
  end

  context 'when event is pending' do
    let(:result) { Struct.new(:pending?, :failed?).new(true, false) }

    it 'puts warning message' do
      output = "::warning file=file.rb,line=1::Test case pending\n"
      expect { subject }.to output(output).to_stdout
    end
  end

  context 'when event has different status' do
    let(:result) { Struct.new(:pending?, :failed?).new(false, false) }

    it "doesn't puts anything" do
      expect { subject }.not_to output.to_stdout
    end
  end
end
