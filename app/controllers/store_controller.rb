class StoreController < ApplicationController
   def index
#      @products = Product.all
      @products = Product.paginate :page => params[:page], :order => 'created_at DESC'
      @cart = current_cart
      respond_to do |format|
         format.html
         format.js
         format.xml
      end
   end
end
