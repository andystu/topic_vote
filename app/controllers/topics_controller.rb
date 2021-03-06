class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    #@topic = Topic.new
    @topic = current_user.topics.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    #@topic = Topic.new(topic_params)
    @topic = current_user.topics.new(topic_params)
    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    if current_user.votes.find_by(topic_id: @topic.id).nil?
#    if current_user.votes.find_by_topic_id(@topic.id).nil?
#    if current_user.votes.where(topic_id: @topic.id).size < 1
#      @vote = @topic.votes.new(user_id:  current_user.id)
#      @vote.save!
      @topic.votes.create!(user_id:  current_user.id)
      redirect_to topics_path, notice: "Vote successfully!"
    else
      redirect_to topics_path, notice: "Vote already!"
    end
  end

  def myvotes
#    @votes = current_user.votes.select(:topic_id).ids
    @my_voted_topic = current_user.votes.pluck(:topic_id)
    @topics = Topic.find(@my_voted_topic)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description)
    end
end
