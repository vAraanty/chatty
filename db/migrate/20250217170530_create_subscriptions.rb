class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_subscription_id
      t.integer :status
      t.string :plan_name
      t.datetime :current_period_start
      t.datetime :current_period_end

      t.timestamps
    end
  end
end
