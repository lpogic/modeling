require_relative 'model_field'

module Modeling

  attr_accessor :model_fields

  def model *fields, &initializer
    self.model_fields = model_fields = fields.map{ ModelField.parse _1 }
    define_initialize self, &initializer
    model_fields.each do |field|
      attr_writer field.name if field.writer?
      attr_reader field.name if field.reader?
      attr_tester "#{field.name}?".to_sym, field.instance_variable_name if field.tester?
    end
  end
  
  private

  def attr_tester tester, instance_variable
    define_method tester do
      instance_variable_get(instance_variable) ? true : false
    end
  end

  def self.initialize_arguments fields, *a, **na
    fields.filter(&:initialize_argument?).zip(a).map do |field, arg| 
      name = field.name
      value = na.key?(name) ? na[name] : arg 
      [name, value]
    end.to_h
  end

  def define_initialize initializer_class, &initializer
    define_method :initialize do |*a, **na, &b|
      model_fields = initializer_class.model_fields
      initialize_arguments = Modeling.initialize_arguments model_fields, *a, **na
      super_initialize = proc do |*as, **nas, &bs|
        if as.empty? && nas.empty? && !bs
          super(*(a[initialize_arguments.size..] || []), **na.except(*initialize_arguments.keys), &b)
        else
          super(*as, **nas, &bs)
        end
      end
      model_fields.each do |field|
        if field.instance_variable?
          instance_variable_set field.instance_variable_name, initialize_arguments[field.name]
        end
      end
      if initializer
        instance_exec super_initialize, **initialize_arguments, &initializer
      else
        super(*(a[initialize_arguments.size..] || []), **na.except(*initialize_arguments.keys), &b)
      end
    end
  end
end