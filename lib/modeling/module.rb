require 'forwardable'
require_relative 'exception'
require_relative 'model_field'
require_relative 'model_initializer'

module Modeling

  attr :model_fields

  def model *fields, rest: :positional_, keyword: :keyword_, block: :block_, &initializer
    @model_fields = fields.map{|f| ModelField.parse f }
    instance_variables_definition = @model_fields.map do |field| 
      if field.nil_instance_variable?
        "@#{field.name} = nil"
      elsif field.instance_variable?
        "@#{field.name} = #{field.name}"
      end
    end.join "\n"
    direct_super = "super #{ "*#{rest}," if rest } #{ "**#{keyword}," if keyword } &#{ block || "nil" }"
    initialize_body = if initializer
      model_initialize = "initialize_#{self.name.tr ":", "_"}"
      private define_method(model_initialize, initializer)
      if initializer.arity == 0
        "#{direct_super}; #{model_initialize}"
      else
        super_caller = "proc{|a, na, b| super *a, **na, &b }"
        params = "#{ rest || "nil" }, #{ keyword || "nil" }, #{ block || "nil" }"
        mi = "Modeling::ModelInitializer.new(self.class.model_fields, #{super_caller}, binding, #{params})"
        "#{model_initialize} #{mi}"
      end
    else
      direct_super
    end
    class_eval <<~CODE
      def initialize(
        #{ @model_fields.map{|f| "_#{f.name} = nil, " }.join }
        #{ "*#{rest}," if rest }
        #{ @model_fields.map{|f| "#{f.name}: _#{f.name}," }.join }
        #{ "**#{keyword}," if keyword }
        #{ "&#{block}" if block }
      )
        #{instance_variables_definition}
        #{initialize_body}
      end
    CODE
    @model_fields.each do |field|
      attr_writer field.name if field.writer?
      attr_reader field.name if field.reader?
    end
  end
end