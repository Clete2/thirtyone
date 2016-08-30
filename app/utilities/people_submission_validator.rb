class PeopleSubmissionValidator
  attr_reader :params, :errors
  def initialize(params)
    @params = params
    @errors = {}
  end

  def process(person)
    household = check_for_household
    household ||= create_new_household
    check_create_new_user(person)
    add_person_attributes(person, household)
    is_invalid?(person)
    if errors.empty?
      persist_entry(household, person)
    else
      compute_errors(person)
    end
  end

  def persist_entry(household, person)
    begin
      Person.transaction do
        save(household)
        person.household = household
        save(person)
        household.update!(person: person) unless household.person
        return true
      end
      true
    rescue ActiveRecord::RecordInvalid => exception
        @errors['validation'] = exception.message
        false
    end
  end

  def save(obj)
    obj.save!
  end

  def is_invalid?(obj)
    obj.valid? ? nil : @errors[obj.class.to_s] = obj.errors.full_messages.join(", ")
  end

  def add_person_attributes(person, household)
    person.assign_attributes person_params

    notes_attributes = note_params
    notes = notes_attributes[:notes_attributes]
    index = notes.keys.sort_by(&:to_i).last.to_s

    if notes[index][:note].empty?
      notes.delete(index)
    end
    person.assign_attributes notes_attributes

    person.household = household
  end

  def check_for_household
    household_id = person_params[:household_id]
    Household.find_by(id: household_id)
  end

  def create_new_household
    state = State.find_by(id: address_params[:state_id])
    address = Address.new(address_params)
    return if (is_invalid?(address) || state.nil?)

    household = Household.new
    household.address = address
    household
  end

  def check_create_new_user(person)
    unless params[:create_user] == 'yes'
      person.user.destroy if person.user
      return
    end

    user = person.user || User.new

    user_email = user.new_record? ? person_params[:email] : user.email

    # Only validate email being required when the user is new
    if user_email.blank? and user.new_record?
      @errors[:email] = "is required when the person is also allowed to login"
    elsif user_email !~ Devise.email_regexp
      @errors[:email] = "is not valid"
    else
      person.user = setup_user(user, user_email)
    end
  end

  def setup_user(user, user_email)
    user.email = user_email
    user.password = Devise.friendly_token.first(8)
    user.confirm_email_change
    user.roles = [Role.default_role]
    is_invalid?(user) ? nil : user
  end

  def compute_errors(person)
    errors.each{ |key, val| person.errors.add(key.downcase, val) }
    false
  end

  def address_params
    return Hash.new unless params[:address]
    params.require(:address).permit(:line1, :line2, :city, :state, :zip, :state_id)
  end

  def person_params
    params.require(:person).permit(:firstname, :lastname, :phone, :phone_ext, :household_id, :email)
  end

  def note_params
    params.require(:person).permit(notes_attributes:[:note_type_id, :note, :id, :_destroy])
  end

end
