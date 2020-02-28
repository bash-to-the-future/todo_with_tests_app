require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should change complete from false to true' do 
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it 'should change complete from true to false' do 
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end
end
