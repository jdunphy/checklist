module Checklist
  
  class Task < Sequel::Model
    validates_presence_of :name
    
    before_create :create_date
    before_create :set_priority
    
    def_dataset_method(:today) do
      filter(:task_for => Time.today).order(:priority.asc)
    end
    
    def done?
      done == true
    end
    
    def complete!
      update(:done => true)
    end
    
    def delay!
      update(:task_for => Date.today + 1)
    end
    
    def update_priority(new_priority)
      return if new_priority == priority
      if new_priority > priority
        self.class.today.filter('priority >= ? and priority < ?', priority, new_priority).update(:priority => :priority - 1)
      else
        self.class.today.filter('priority >= ? and priority < ?', new_priority, priority).update(:priority => :priority + 1)
      end
      update(:priority => new_priority)
    end
    
    private 
    
      def create_date
        self.task_for = Date.today
      end
      
      def set_priority
        current_last= self.class.today.last
        self.priority = current_last ? current_last.priority + 1 : 1
      end
  end
  
end