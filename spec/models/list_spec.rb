require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Shopping List")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)

      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do 
    it 'should snooze each task on list' do 
      list = List.create(name: "Things to Snooze")
      time_stamps = [ Time.now,
                      1.hour.from_now,
                      30.minutes.ago]

      time_stamps.each do |time_stamp|
        Task.create(deadline: time_stamp, list_id: list.id)
      end

      list.snooze_all_tasks!

      list.tasks.each_with_index do |task, index|
        expect(task.deadline).to eq(time_stamps[index] + 1.hour)
      end
    end
  end

  describe '#total_duration' do 
    it 'should return the sum of all task durations for list' do 
      list = List.create(name: "Jokes")
      Task.create(duration: 1, list_id: list.id)
      Task.create(duration: 60, list_id: list.id)
      Task.create(duration: 30, list_id: list.id)

      expect(list.total_duration).to eq(91)
    end
  end

  describe '#incomplete_tasks' do 
    it 'should return a collection of all incomplete tasks' do 
      list = List.create(name: "Packing List")
      task_1 = Task.create(complete: true, list_id: list.id)
      task_2 = Task.create(complete: true, list_id: list.id)
      task_3 = Task.create(complete: false, list_id: list.id)
      task_4 = Task.create(complete: false, list_id: list.id)

      expect(list.incomplete_tasks.length).to eq(2)
      expect(list.incomplete_tasks).to match_array([task_3, task_4])
    end
  end

  describe '#favorite_tasks' do 
    it 'should return a collection of all favorite tasks' do 
      list = List.create(name: "Games List")
      task_1 = Task.create(favorite: true, list_id: list.id)
      task_4 = Task.create(favorite: false, list_id: list.id)
      task_3 = Task.create(favorite: false, list_id: list.id)
      task_2 = Task.create(favorite: true, list_id: list.id)

      expect(list.favorite_tasks.length).to eq(2)
      expect(list.favorite_tasks).to match_array([task_2, task_1])
    end
  end
end
