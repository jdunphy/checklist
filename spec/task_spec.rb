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
  end
end