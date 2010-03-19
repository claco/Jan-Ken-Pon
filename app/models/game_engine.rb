class GameEngine
  attr_reader :rules_engine, :weapons

  def initialize(params={})
    @rules_engine = params[:rules_engine] || RulesEngine.new
    @weapons = params[:weapons] || []

    if !@weapons.kind_of? Array
      raise ArgumentError, ":weapons must be an array of weapons"
    end

    rules = params[:rules]
    if rules
      if rules.kind_of? Array
        @rules_engine.add(*params[:rules])
      else
        raise ArgumentError, ":rules must be an array of rules"
      end
    end
  end

  def deliver(a, b)
    if a.blank? || b.blank? || !a.instance_of?(Weapon) || !b.instance_of?(Weapon)
      raise ArgumentError, "process must receive two weapons"
    end

    @rules_engine.process(a, b)
  end
end