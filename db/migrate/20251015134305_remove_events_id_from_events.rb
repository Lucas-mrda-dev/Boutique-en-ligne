class RemoveEventsIdFromEvents < ActiveRecord::Migration[8.0]
  def change
    remove_column :events, :events_id, :integer
  end
end
