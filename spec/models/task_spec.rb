require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should switch complete to false if it began as true' do 
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do 
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should switch favorite to true if it began as false' do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it 'should return false if the time now is not past the deadline' do
      task = Task.new(deadline: 1.day.from_now)
      expect(task.overdue?).to eq(false)
    end

    it 'should return true if the time now is past the deadline' do
      task = Task.new(deadline: 1.day.ago)
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority!' do
    it 'should increment the priority by 1 if it is less than 10' do
      task = Task.new(priority: 8)
      task.increment_priority!
      expect(task.priority).to eq(9)
    end

    it 'should not increment the priority if it is 10 or more' do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    it 'should decrement the priority if it is greater than 1' do
      task = Task.new(priority: 2)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end

    it 'should not decrement the priority if it is 1 or less' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should add 1 hour to the deadline' do
      store_time = 1.hour.from_now
      task = Task.new(deadline: store_time)
      task.snooze_hour!
      expect(task.deadline).to eq(store_time+1.hour)
    end
  end

end
