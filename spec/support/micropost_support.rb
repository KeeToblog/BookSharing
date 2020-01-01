module MicropostSupport

  def fill_in_micropost_form(user, option = { invalid: false })
    if option[:invalid]
      fill_in "いまの気持ちは？", with: ""
    else
      fill_in "いまの気持ちは？", with: "This micropost really ties the room together"
      attach_file "#{Rails.root}/spec/files/book-bg-yellow.jpg"
    end
  end

end
