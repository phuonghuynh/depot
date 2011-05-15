class Product < ActiveRecord::Base
   has_many :line_items
   before_destroy :ensure_not_referenced_by_any_line_item

   cattr_reader :per_page
   @@per_page = 2

   def ensure_not_referenced_by_any_line_item
      any_line_item_present = line_items.count.zero?
      if !any_line_item_present
         errors[:base] << 'Line Items present'
      end

      any_line_item_present
   end

   default_scope :order => 'title'
   validates :title, :description, :presence => true
   validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
   validates :title, :uniqueness => true
   validates :image_url, :format => {
      :with => %r{\.(gif|jpg|png)$}i,
      :message => 'must be a URL for GIF, JPG or PNG image.'
   }
end
