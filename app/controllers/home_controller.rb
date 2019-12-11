class HomeController < ApplicationController
  def index; end
  around_action :set_time_zone, if: :user

  def new_period_accuracy
    if params[:period_accuracy]
      @user_s = params[:period_accuracy][:name]
      @from_s = params[:period_accuracy][:from]
      @to_s   = params[:period_accuracy][:to]
    else
      @user_s = 'User 1'
      @from_s = Date.today.beginning_of_week.prev_week.to_s(:db)
      @to_s   = Date.today.beginning_of_week.to_s(:db)
    end
  end

  def show_period_accuracy
    @user = User.find_by_name(params[:period_accuracy][:name])
    @from = params[:period_accuracy][:from].to_time(:local)
    @to = params[:period_accuracy][:to].to_time(:local)
  end

  def new_weekly_rankings
    if params[:weekly_rankings]
      @from_s = params[:weekly_rankings][:from]
    else
      @from_s = Date.today.beginning_of_week.prev_week.to_s(:db)
    end
  end

  def show_weekly_rankings
    @from = params[:weekly_rankings][:from].to_time(:utc)
  end

  private
    def set_time_zone(&block)
      Time.use_zone(@user.timezone, &block)
    end

    def user
      @user
    end
end
