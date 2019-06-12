class ChangeWeightInCriterium < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        change_column :criteria, :weight, :float
      end
      dir.down do
        change_column :criteria, :weight, :int
      end
    end
  end
end
