class GamesController < ApplicationController
  before_filter :requires_authentication

  # GET /games
  # GET /games.xml
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find_by_key(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find_by_key(params[:id])
  end

  def join
    @game = Game.find_by_key(params[:id])

    if @game.player_id == current_player.id || @game.opponent_id == current_player.id
      redirect_to( play_game_path(@game.key) )
    elsif @game.opponent.blank?
      Game.transaction do
        @game.opponent = current_user.player
        @game.save!
        GameQueue.delete_all(:game_id => @game.id)
      end
      
      redirect_to( play_game_path(@game.key) )
    else
      flash.now[:notice] = 'Game already has two players!'
    end
  end

  def play
    @game = Game.find_by_key(params[:id])
    @previous_round = @game.previous_round
    @current_round = @game.current_round

    respond_to do |format|
      format.html { render }
      format.json { render :json => { :has_opponent => !@game.opponent_id.blank?, :has_opponent_choice => @game.finished? || @current_round.have_both_weapons? } }
    end
  end

  def deliver
    @game = Game.find_by_key(params[:id])
    @previous_round = @game.previous_round
    @current_round = @game.current_round
    @game.deliver(current_user.player, params[:weapon])

    redirect_to( play_game_path(@game.key) )
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])
    @game.player = current_user.player

    respond_to do |format|
      if @game.save
        if params[:private].blank?
          GameQueue.create!(:game => @game, :mode => @game.mode)
        end

        format.html { redirect_to( play_game_path(@game.key) ) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find_by_key(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find_by_key(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
end
