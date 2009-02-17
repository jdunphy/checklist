require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Checklist::Task" do

  it "should be a Sequel::Model" do
    Checklist::Task.superclass.should eql(Sequel::Model)
  end

  describe "a new task" do
    before(:each) do
      @task = Checklist::Task.new(:name => 'write those docs')
    end
    
    it "should have a date" do
      @task.task_for.should be_nil
      @task.save
      @task.task_for.should_not be_nil
      @task.task_for.should eql(Time.today)
    end
  
    it "should require a name" do
      @task.should be_valid
      @task.name = nil
      @task.should_not be_valid
    end
  end
  
  describe "a saved task" do
    before(:each) do
      @task = Checklist::Task.create(:name => 'make a test or something')
    end
    
    it "should not be done" do
      @task.should_not be_done
    end
    
    it "should be completable" do
      @task.complete!
      @task.reload
      @task.should be_done
    end
    
    it "should be delayable" do
      @task.task_for.should eql(Time.today)
      @task.delay!
      @task.reload
      @task.task_for.should eql(Time.today + 60 * 60 * 24)
    end
    
    after(:each) do
      @task.destroy
    end
  end
  
  describe "with two saved tasks" do
    before(:each) do
      Checklist::Task.delete_all
      @task1 = Checklist::Task.create(:name => 'part1')
      @task2 = Checklist::Task.create(:name => 'part2')
    end
    
    it "#today should return two tasks" do
      Checklist::Task.today.all.should include(@task1)
      Checklist::Task.today.all.should include(@task2)
    end
    
    it "#today should return tasks for tomorrow" do
      @task2.delay!
      Checklist::Task.today.all.should include(@task1)
      Checklist::Task.today.all.should_not include(@task2)      
    end
  end
end