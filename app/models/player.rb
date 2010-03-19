class Player
  attr_accessor :id, :weapon

  def initialize(params={})
    self.id = params[:id] || 0
    self.weapon = params[:weapon]

    if self.id.to_i <= 0
      raise ArgumentError, "id is required"
    end
  end
end