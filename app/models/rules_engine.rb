class RulesEngine
  attr_accessor :rules

  def initialize(params = {})
    self.rules = params[:rules] || []
  end

  def add(*rules)
    self.rules.push(*rules)
  end

  def process(a, b)
    rules.each do |rule|
      result = rule.call(a, b)

      return result if result
    end

    return
  end
end