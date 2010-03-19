class RulesEngine
  attr_accessor :rules

  def initialize(params = {})
    self.rules = params[:rules] || []
  end

  def add(*rules)
    self.rules.push(*rules)
  end

  def process(a, b)
    if a.blank? || b.blank? || !a.instance_of?(Weapon) || !b.instance_of?(Weapon)
      raise ArgumentError, "process must receive two weapons"
    end

    rules.each do |rule|
      result = rule.call(a, b)

      return result if result
    end

    return
  end
end