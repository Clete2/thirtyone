class LocalResourceSearch

  def self.search(params)
    query = LocalResourceCategory.joins(:local_resources)
    puts(params)
    if params[:search]
      category_ids = params[:search][:local_resource_categories].reject {|c| c.empty? }.map {|item| item.to_i }
      local_resources = LocalResource.includes(:local_resource_categories)
                            .where("LOWER(local_resources.business_name) LIKE ?", params[:search][:term].downcase + '%')
                            .where(local_resource_categories_resources: {local_resource_category_id: category_ids}).all
    else
      local_resources = query.all
    end
    local_resource_categories = local_resources.includes(:local_resource_categories).map(&:local_resource_categories).flatten.uniq
    return local_resources, local_resource_categories
  end

end
