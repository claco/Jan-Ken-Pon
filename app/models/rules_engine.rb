class RulesEngine
  attr_accessor :rules

  def initialize(params = {})
    self.rules = params[:rules] || []
  end

  def add(*rules)
    self.rules.push(*rules)
  end

  def process(a, b)
    result = nil

    rules.each do |rule|
      result = rule.call(a, b)

      if result
        return result
        break
      end
    end

    return result
  end
end