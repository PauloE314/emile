# frozen_string_literal: true

module Api
  class RecipesController < ApplicationController
    before_action :set_recipe, only: %i[show update destroy]
    before_action :authenticate, only: %i[create update destroy]

    def index
      @recipes = Recipe.all
      @recipes = @recipes.filter_by_category params[:category] if params[:category]
      @recipes = @recipes.filter_by_name params[:name] if params[:name]

      render json: @recipes
    end

    def show
      render json: @recipe, include: %i[creator ingredients steps]
    end

    def create
      @recipe = Recipe.new(recipe_params.merge({ creator: @current_user }))

      if @recipe.save
        render json: @recipe, status: :created
      else
        render json: @recipe.errors, status: :bad_request
      end
    end

    def update
      if @recipe.update recipe_params
        render json: @recipe, include: %i[creator steps ingredients]
      else
        render json: @recipe.errors, status: :bad_request
      end
    end

    def destroy
      @recipe.destroy
    end

    private

    def set_recipe
      @recipe = Recipe.find params[:id]
    end

    def recipe_params
      data = params.require(:recipe).permit(*recipe_params_list)
      data[:ingredients_attributes] = data.delete :ingredients if data[:ingredients]
      data[:steps_attributes] = data.delete :steps if data[:steps]
      data
    end

    def recipe_params_list
      [
        :name,
        :servings,
        :time,
        :category,
        { steps: %i[id description position _destroy],
          ingredients: %i[id name amount unit _destroy] }
      ]
    end
  end
end
