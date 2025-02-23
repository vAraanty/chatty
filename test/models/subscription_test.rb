# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  current_period_end     :datetime
#  current_period_start   :datetime
#  plan_name              :string
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_subscription_id :string
#  user_id                :integer          not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
