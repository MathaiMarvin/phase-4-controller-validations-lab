class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def render_unprocessable_entity_response(invalid)
    errors = invalid.record.errors.messages.map do |attribute, error_messages|
      [attribute, error_messages.join(", ")]
    end.to_h
    
    render json: { errors: errors }, status: :unprocessable_entity
  end
  
end
