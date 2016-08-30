class PeopleSearch
  attr_reader :query, :query_head

  def initialize(query_head)
    @query_head = query_head
    @query = "firstname LIKE ?"
  end

  def add_conditional(param)
    @query += param.length > 1 ? " AND " : " OR "
    @query += "lastname LIKE ? "
  end

  def finalize_query(names)
    @query = query_head.where(query, "#{names.first}%", "#{names.last}%")
  end

  def add_user_restriction(arg)
    @query += " AND users.id IS NOT NULL " if arg == 'true'
  end

  def prepare_query(params)
    search = JSON.parse(params[:search])
    add_conditional(search)
    add_user_restriction(params[:users_only])
    finalize_query(search)
    limit = params[:rowlimit] || 10
    query.references(:users).first(limit)
  end

  def self.search(params)
    query = Person.includes(:user)
    if params[:search]
      new(query).prepare_query(params)
    else
      sub_query(query, params[:users_only])
    end
  end

  def self.sub_query(query, only_users)
    only_users ? query.where.not(users: {id: nil}) : query.all
  end
end
