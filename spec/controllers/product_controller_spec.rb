# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe ' controller test cases ' do

    fixtures :products
    let(:product1) { products(:one) }
    let(:product2) { products(:two) }


    describe '#show' do
      it 'should return the product with given id' do
        get :show, params: { id: product1.id }
        expect(assigns(:product)).to eql(product1)
      end
    end

    describe '#index' do
      it 'render a template' do
        get :index
        expect(response).to render_template('index')
      end
      it 'assigns products' do
        get :index
        expect(assigns(:products).first) == product1
      end
    end

    describe '#create' do
      it 'redirects to @product' do
        new_product = Product.create(id: 8, name: 'Mac', quantity: 50, user_id: 1, serial_number: "Mac-8", slug: "mac-8")
        post :create, params: {
          product: {
            id: new_product.id,
            name: new_product.name,
            quantity: new_product.quantity,
            user_id: new_product.user_id,
            serial_number: new_product.serial_number,
            slug: new_product.slug
          }
        }

        expect(response.status).to eq(200)
      end
    end

    describe '#new ' do
      it 'render :new' do
        new_product = Product.new(id: 8, name: 'Mac', quantity: 50, user_id: 1, serial_number: "Mac-8", slug: "mac-8")
        get :new, params: {
          product: {
            id: new_product.id,
            name: 'Machine',
            quantity: new_product.quantity,
            user_id: new_product.user_id,
            serial_number: new_product.serial_number,
            slug: new_product.slug
          }
        }
        expect(response).to render_template(:new)
      end
    end


    describe '#edit ' do
      it 'render :edit' do

        get :edit, params: {
            id: product1.id
        }
        expect(response).to render_template(:edit)
      end
    end


    describe '#update' do
      it 'updates the product and redirects product_path' do
        patch :update, params: { product: { name: 'T-Shirt', quantity: 30, user_id: 5, serial_number: "T-Shirt-8"}, id: product1.slug }
        expect(response.status).to eq(200)
      end

    end

  end
end
