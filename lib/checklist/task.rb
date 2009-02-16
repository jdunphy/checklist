module Checklist
  
  class Task < Sequel::Model
    validates_presence_of :name
    
    before_create :create_date
    
    def done?
      done == true
    end
    
    def complete!
      update(:done => true)
    end
    
    def delay!
      update(:task_for => Date.today + 1)
    end
    
    private 
      def create_date
        self.task_for = Date.today
      end
  end
  
end