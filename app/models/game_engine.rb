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
    if a.blank? || b.blank? || !a.instance_of?(Player) || !b.instance_of?(Player)
      raise ArgumentError, "process must receive two players"
    elsif a.id == b.id
      raise ArgumentError, "players must be unique"
    elsif a.weapon.blank? || b.weapon.blank?
      raise ArgumentError, "both players must have weapons"
    end

    @rules_engine.process(a, b)
  end
end