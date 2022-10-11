require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe ' controller test cases ' do
    fixtures :comments
    let(:comment1) { comments(:one) }
    let(:comment2) { comments(:two) }


    describe '#create' do
      it 'redirects to @comment' do
        new_comment = Comment.create(id: 8, content: 'Mac', user_id: 1, product_id: 1)
        new_product_comment_path :create, params: {
          comment: {
            id: new_comment.id,
            user_id: new_comment.user_id,
            content: new_comment.content,
            product_id: new_comment.product_id
          }
        }

        expect(response.status).to eq(200)
      end
    end



    describe '#edit ' do
      it 'render :edit' do

        edit_product_comment_url :edit, params: {
            id: comment1.id
        }

        expect(response).to render_template(:edit)
      end
    end


    describe '#update' do
      it 'updates the product and redirects product_path' do
        product_comments_path :update, params: { comment: { content: 'Woww', user_id: 5, product_id: 5}, id: comment1.id }
        expect(response.status).to eq(200)
      end

    end

  end
end
