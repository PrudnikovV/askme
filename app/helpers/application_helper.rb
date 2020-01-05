module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def inclination(quantity, word, word2, word3)
    quantity = quantity % 100
    rest = quantity % 10
      if rest == 0 || rest >= 5 || (10..20).include?(quantity)
        return word3
      elsif rest >= 2
        return word2
      end
    return word
  end
end
