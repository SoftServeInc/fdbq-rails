class CreateFdbqFeedback < ActiveRecord::Migration[4.2]
  def change
    create_table :fdbq_feedback do |t|
      t.text :fields

      t.timestamps
    end
  end
end
