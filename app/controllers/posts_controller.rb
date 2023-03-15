class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])

    post.update!(post_params)

    render json: post
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end
  def render_unprocessable_entity_response(invalid)
    errors = invalid.record.errors.messages.map do |attribute, error_messages|
      [attribute, error_messages.join(", ")]
    end.to_h
    
    render json: { errors: errors }, status: :unprocessable_entity

  end

end
