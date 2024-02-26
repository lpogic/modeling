require_relative 'model_field'

module Modeling

  def model *fields, &initializer
    model_fields = fields.map{ ModelField.parse _1 }
    define_initialize model_fields, &initializer
    model_fields.each do |f|
      attr_writer f.name if f.setter?
      attr_reader f.name if f.getter?
    end
  end
  
  private

  def self.model_arguments fields, *a, **na
    fields.zip(a).map{|f, arg| [f.name, na.key?(f.name) ? na[f.name] : arg]}.to_h
  end

  def define_initialize fields, &initializer
    define_method :initialize do |*a, **na, &b|
      model_arguments = Modeling.model_arguments fields, *a, **na
      super *(a[model_arguments.size..] || []), **na.except(*model_arguments.keys), &b
      fields.each do |f|
        instance_variable_set f.attribute_name, model_arguments[f.name] if f.assign?
      end
      instance_exec **model_arguments, &initializer if initializer
    end
  end

end