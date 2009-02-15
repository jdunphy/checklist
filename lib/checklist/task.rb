module Checklist
  
  class Task < Sequel::Model
    validates_presence_of :name
    
    before_save :create_date
    
    def done?
      done == true
    end
    
    private 
      def create_date
        self.task_for = Time.today
      end
  end
  
end