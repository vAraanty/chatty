module MenuHelper
  def open_menu?
    cookies[:menu_is_open] == "true"
  end
end
