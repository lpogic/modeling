require 'forwardable'
require_relative 'exception'
require_relative 'model_field'

module Modeling

  class << self
    attr_accessor :keywords
  end

  attr :model_fields

  def model *fields, keywords: Modeling.keywords, &initialize_block
    initialize_string = fields.last.is_a?(String) ? fields.pop : ""
    @model_fields = fields.map do |field| 
      if field == :<
        if superclass.respond_to? :model_fields
          superclass.model_fields.map{ ModelField.parse "#{it.name}!" }
        else
          superclass.method(:initialize).parameters.filter_map{ case it[0] when :req then ModelField.parse "#{it[1]}!" end }
        end
      else
        ModelField.parse field
      end
    end.flatten
    instance_variables_definition = @model_fields.filter(&:instance_variable?).map{|f| "@#{f.name} = #{f.name}" }.join "\n"
    initialize_block = private define_method("initialize_#{self.name.tr ":", "_"}", initialize_block) if initialize_block
    initialize_super = @model_fields.filter(&:super_argument?).map{|f| f.name }.then{ _1.empty? && initialize_string != "" ? "" : "super(#{_1.join ","})"}
    arguments = keywords ? 
      @model_fields.map{|f| "_#{f.name} = nil, " }.join + @model_fields.map{|f| "#{f.name}: _#{f.name}" }.join(",") :
      @model_fields.map{|f| "#{f.name} = nil" }.join(",")
    class_eval <<~xx
      def initialize(#{ arguments })
        #{initialize_super}
        #{instance_variables_definition}
        #{initialize_string}
        #{initialize_block}
      end
    xx
    @model_fields.each do |field|
      attr_writer field.name if field.writer?
      attr_reader field.name if field.reader?
    end
  end
end
