module Entities
  class Disease
    attr_reader :id, :name, :description, :symptoms, :treatments

    def initialize(id:, name:, description:, possible_causes:, symptoms:)
      @id = id
      @name = name
      @description = description
      @symptoms = symptoms
      @treatments = treatments
    end

    def validates!
      raise "Disease name is required" if name.blank?
      raise "Disease description is required" if description.blank?
      raise "Disease symptoms are required" if symptoms.blank?
    end
  end
end
