# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  chat_room_id :integer
#  sender_id    :integer
#  receiver_id  :integer
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  read         :boolean          default(FALSE)
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
