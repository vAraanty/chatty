module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice, :success
      "bg-green-500"
    when :error, :alert
      "bg-red-500"
    else
      "bg-blue-500"
    end
  end
end
