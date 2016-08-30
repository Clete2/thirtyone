module PhoneMethod
  def strip_phone(phone)
    unless phone.nil?
      phone = phone.gsub(/\D/, '')
    end
    return phone
  end
  def strip_phone_ext(phone_ext)
    unless phone_ext.nil?
      phone_ext = phone_ext.gsub(/\D/, '')
    end
    return phone_ext
  end
end