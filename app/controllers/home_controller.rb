class HomeController < ApplicationController
  def index; end
  around_action :set_time_zone, if: :user

  def new_period_accuracy
  end

  def show_period_accuracy
    @user = User.find_by_name(params[:period_accuracy][:name])
    @from = params[:period_accuracy][:from].to_time(:local)
    @to = params[:period_accuracy][:to].to_time(:local)
  end

  def new_weekly_rankings
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
