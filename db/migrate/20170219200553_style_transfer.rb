class StyleTransfer < ActiveRecord::Migration
  def change
  	  Beer.all.each do |beer|
      if Style.where(name: beer.old_style).empty?
        s = Style.new
        s.name = beer.old_style
        s.description = "Great very nice 5 outta 5"
        s.save
      end
      beer.style_id = Style.where(name: beer.old_style).first.id
      beer.save!
    end

    remove_column :beers, :old_style
  end
end
