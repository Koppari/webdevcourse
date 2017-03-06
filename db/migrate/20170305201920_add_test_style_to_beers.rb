class AddTestStyleToBeers < ActiveRecord::Migration
  def change
  	Beer.update_all(style_id: 1)
  end
end
