class Weapon
  attr_accessor :id, :name

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]

    if @id <= 0
      raise ArgumentError, 'id is invalid'
    end
  end

  def to_i
    self.id
  end
end