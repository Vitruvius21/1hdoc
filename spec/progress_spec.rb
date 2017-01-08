require_relative 'spec_helper'
require_relative '../lib/1hdoc/core/progress'

describe HDOC::Progress do
  before do
    @progress = described_class.new(1)
    @progress.set_record(progress: 'Fixed CSS.')
  end

  context '#format' do
    it 'should returns Markdown result' do
      expect(@progress.format).to include('### Day 1')
      expect(@progress.format).to include('**Progress:** Fixed CSS.')
    end
  end
end
