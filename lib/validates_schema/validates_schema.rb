class ActiveRecord::Base
  
  class << self
    
    def inherited(klass)
      super(klass)
      begin
        add_schema_based_validations(klass)
        return # it worked, so just return
      rescue ActiveRecord::StatementInvalid => e
        # puts "e.message: #{e.message}"

        begin
          # The ActiveRecord::StatementInvalid could be a result
          # of an abstract superclass, so let's reset the table name
          # and try again:
          klass.reset_table_name
          add_schema_based_validations(klass)
          return # it worked, so just return
        rescue ActiveRecord::StatementInvalid => e
          # puts "e.message: #{e.message}"
        end
      end # rescue ActiveRecord::StatementInvalid
      
      # Ok, so it failed, let's add a hook around setting
      # the table name and try that. Hopefully all should be well then.
      unless klass.respond_to?(:set_table_name_with_schema_validations)
        klass.class_eval do
          class << self
            def set_table_name_with_schema_validations(*args)
              set_table_name_without_schema_validations(*args)
              return if abstract_class
              begin
                add_schema_based_validations(self)
              rescue ActiveRecord::StatementInvalid => e
                # apparently it just doesn't want to work,
                # so forget about it!
                # puts "e.message: #{e.message}"
              end
            end
            alias_method_chain :set_table_name, :schema_validations
          end
        end
      end
      
    end # inherited
    
    def add_schema_based_validations(klass = self)
      klass.reset_column_information
      # puts klass
      # puts "klass.arel_table: #{klass.arel_table.inspect}"
      validations = []
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
          validations << "validates :#{detail.name.to_sym}, #{options.inspect}"
          klass.class_eval do
            validates detail.name.to_sym, options || {}
          end
        end
      end
      # uncomment to see a list of generated validations:
      # unless validations.empty?
      #   puts "#{klass}:"
      #   validations.each do |line|
      #     puts "  #{line}"
      #   end
      # end
    end # add_schema_based_validations
    
  end # class << self
  
end # ActiveRecord::Base
