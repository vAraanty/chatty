class AddOnboardingToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :onboarding_completed, :boolean, default: false, null: false
    add_column :users, :onboarding_step, :integer, default: 0, null: false
  end
end
