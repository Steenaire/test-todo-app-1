require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do 
    it 'should make all incomplete tasks complete' do 
      list = List.create()
      task1 = Task.create(complete: false, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should delay the deadline of all tasks by an hour' do
      list = List.create()
      time = 1.hour.from_now
      task1 = Task.create(deadline: time, list_id: list.id)
      task2 = Task.create(deadline: time, list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(time+1.hour)
      end
    end
  end

  describe 'total_duration' do
    it 'should return the sum of all task durations' do
      list = List.create()
      task1 = Task.create(duration: 2, list_id: list.id)
      task2 = Task.create(duration: 1, list_id: list.id)
      expect(list.total_duration).to eq(3)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of incomplete tasks' do
      list = List.create()
      task1 = Task.create(complete: true, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      task3 = Task.create(complete: false, list_id: list.id)
      expect(list.incomplete_tasks).to eq([task2, task3])
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of favorited tasks' do
      list = List.create()
      task1 = Task.create(favorite: true, list_id: list.id)
      task2 = Task.create(favorite: false, list_id: list.id)
      expect(list.favorite_tasks).to eq([task1])
    end
  end


end
