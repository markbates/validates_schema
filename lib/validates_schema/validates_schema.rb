class ActiveRecord::Base
  
  class << self
    
    def inherited(klass)
      super(klass)
      # puts klass
      klass.arel_table.columns.each do |c|
        detail = c.column
        next if detail.name == 'id'
        options = {}
        case detail.type
        when :string, :text, :binary
          options[:length] = { :maximum => detail.limit } if detail.limit.present?
        when :integer, :float, :decimal
          options[:numericality] = true
          options[:numericality] = {:only_integer => true} if detail.type == :integer
        end
        options[:presence] = true unless detail.null

        unless options.empty?
          # puts "validates :#{detail.name.to_sym}, #{options.inspect}"
          klass.class_eval do
            validates detail.name.to_sym, options || {}
          end
        end
        
      end
    end
    
  end
  
end
