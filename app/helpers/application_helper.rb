module ApplicationHelper
  def deduplicate_user(user)
    # Find users with duplicate fullnames.
    # If there is a duplicate, then the label should have <name> (<email>)
    # to help differentiate the users.
    is_duplicate?(user.person) ? "#{user.person.fullname} (#{user.email})" : user.person.fullname
  end

  def deduplicate_person(person)
    # Find people with duplicate fullnames.
    # If there is a duplicate, then the label should have <name> (<address line 1>)
    # to help differentiate the people.
    is_duplicate?(person) ? "#{person.fullname} (#{person.household.address.line1})" : person.fullname
  end

  private
  def is_duplicate?(person)
    Person.select { |p| p.id != person.id && p.fullname == person.fullname }.any?
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:;", :onclick => "remove_fields(this)")
  end

  # Creates a link/button that has an onclick attribute to call the add_fields javascript found in application.js
  # The javascript gets passed the link/button which it will use to find it's relative location on the page.  It will also
  # pass the name of the assocation, which will be used to find and rename the html input fields, and it will be passed HTML which
  # will be the HTML that gets inserted when the link/button is clicked.  The javascript inserts at $(this).parent().parent(), but
  # this behavior can be overriden by passing a jQuery selector in as parent_selector.
  #
  #
  # @param name [String] the name of the button/link that will appear on the screen
  # @param f [FormBuilder] the rails FormBuilder for the form this association will go into
  # @param association [Symbol] the name of the association you want to generate HTML for
  # @param parent_selector [String] an option string that will be used by the javascript to find an element to insert the generated HTML
  #
  def link_to_add_fields(name, f, association, parent_selector=nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    onclick = "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\""
    if parent_selector
      onclick += ", \"#{parent_selector}\""
    end
    onclick += ")"

    link_to name,
            "javascript:;",
            :class => 'button medium',
            :onclick => onclick
  end

end