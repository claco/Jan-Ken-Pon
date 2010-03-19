class RulesEngine
  attr_accessor :rules

  def initialize(params = {})
    self.rules = params[:rules] || []
  end

  def add(*rules)
    self.rules.push(*rules)
  end

  def process(a, b)
    if a.blank? || b.blank? || !a.instance_of?(Player) || !b.instance_of?(Player)
      raise ArgumentError, "process must receive two players"
    elsif a.id == b.id
      raise ArgumentError, "players must be unique"
    elsif a.weapon.blank? || b.weapon.blank?
      raise ArgumentError, "both players must have weapons"
    end

    rules.each do |rule|
      result = rule.call(a, b)

      return result if result
    end

    return
  end
end