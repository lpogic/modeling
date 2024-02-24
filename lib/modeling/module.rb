require_relative 'model_argument'

module Modeling

  def model *fields, &initialize
    fields.map!{ ModelArgument.parse _1 }
    initialize_context = Struct.new(nil, *fields.map(&:name))
    define_method :initialize do |*a, **na|
      arguments = fields.zip(a).map do |f, arg|
        value = (f.keyword? ? na[f.name] : nil) || arg
        instance_variable_set f.attribute_name, value if f.attribute?
        value
      end
      initialize_context.new(*arguments).instance_exec &initialize if initialize
    end
    fields.filter{|f| f.setter? }.each do |f|
      attr_writer f.name
    end
    fields.filter{|f| f.getter? }.each do |f|
      attr_reader f.name
    end
    fields.filter{|f| f.tester? }.each do |f|
      define_method "#{f.name}?" do
        !!instance_variable_get(f.attribute_name)
      end
    end
  end

end