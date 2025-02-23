# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string
#  name                 :string
#  onboarding_completed :boolean          default(FALSE), not null
#  onboarding_step      :integer          default("profile"), not null
#  tag                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  provider_id          :string
#  stripe_customer_id   :string
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
