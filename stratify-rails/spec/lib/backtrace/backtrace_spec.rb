require 'spec_helper'

describe 'backtrace initializer' do
  it 'preserves Stratify gems in the backtrace' do
    collector = Stratify::Collector.create
    archiver = Stratify::Archiver.new(collector)
    expect {archiver.run}.to raise_error { |e|
      cleaned = Rails::backtrace_cleaner.clean(e.backtrace)
      cleaned[0].should include('lib/stratify')
    }
  end
end


