class CreateBaseCategories < ActiveRecord::Migration[5.0]
  def up
    change_column :categories, :description, :string, :default => ""

    c1 = Category.find_by :name => Category.BASE_CATEGORIES[0]
    c2 = Category.find_by :name => Category.BASE_CATEGORIES[1]
    c3 = Category.find_by :name => Category.BASE_CATEGORIES[2]

    Category.transaction do
      if c1 == nil
        Category.create! name: Category.BASE_CATEGORIES[0]
      end

      if c2 == nil
        Category.create! name: Category.BASE_CATEGORIES[1]
      end

      if c3 == nil
         Category.create! name: Category.BASE_CATEGORIES[2]
      end
    end
  end

  def down
    c1 = Category.find_by :name => Category.BASE_CATEGORIES[0]
    c2 = Category.find_by :name => Category.BASE_CATEGORIES[1]
    c3 = Category.find_by :name => Category.BASE_CATEGORIES[2]

    Category.transaction do
      if c1
        c1.destroy
      end

      if c2
        c2.destroy
      end

      if c3
        c3.destroy
      end
    end
  end
end
