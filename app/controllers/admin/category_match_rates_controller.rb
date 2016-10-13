class Admin::CategoryMatchRatesController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_category_rates, only: [:edit, :show, :update]

  def index
    @categories = CategoryMatchRate.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @load_category_rates = CategoryMatchRate.new
  end

  def create
    @load_category_rates = CategoryMatchRate.new category_params
    if @load_category_rates.save
      flash[:success] = t "category_rates.create_success"
      redirect_to root_path
    else
      flash[:warning] = t "category_rates.create_fail"
      errors_count
      render :new
    end
  end

  def edit
  end

  def update
    if @load_category_rates.update_attributes category_params
      flash[:success] = t "category_rates.edit_success"
      redirect_to @load_category_rates
    else
      flash[:warning] = t "category_rates.edit_fail"
      errors_count
      render :edit
    end
  end

  private
  def category_params
    params.require(:category_match_rate).permit :category_rates
  end

  def load_category_rates
    @load_category_rates = CategoryMatchRate.find_by id: params[:id]
    unless @load_category_rates
      flash[:warning] = t "category_rates.not_found"
      redirect_to root_path
    end
  end

  def errors_count
    @errors_count = @load_category_rates.errors.size
  end
end
