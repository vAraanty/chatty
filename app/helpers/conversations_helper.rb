module ConversationsHelper
  def conversation_link(conversation, current_user)
    base_class = "border-3 border-gray-700 rounded-full mt-3 w-15 h-15 flex items-center justify-center"
    bg_color    = CHAT_BACKGROUND_COLORS[conversation.id % CHAT_BACKGROUND_COLORS.size]

    if conversation.direct_conversation?
      other_user = conversation.users.where.not(id: current_user.id).first

      if other_user.avatar.attached?
        link_to conversation_path(conversation), title: other_user.name, class: base_class do
          image_tag(other_user.avatar, alt: other_user.name, class: "object-cover h-full w-full rounded-full")
        end
      else
        link_to conversation_path(conversation), title: other_user.name, class: "text-2xl #{base_class} #{bg_color}" do
          other_user.name.first.capitalize
        end
      end
    else
      link_to conversation_path(conversation), title: conversation.name, class: "text-2xl #{base_class} #{bg_color}" do
        conversation.name.first.capitalize
      end
    end
  end
end
