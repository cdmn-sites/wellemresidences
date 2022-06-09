class CategoriesController < ApplicationController
  def index
    render inertia: 'categories/index'
  end
end