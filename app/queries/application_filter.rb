class ApplicationFilter
  def initialize(params:, cookies:)
    @params = params
    @cookies = cookies
    set_permanent_cookie
  end

  #
  # Protected
  #

  protected

  attr_reader :params, :cookies

  def filter_params
    @filter_params ||=  begin
      args = {}
      (params[:filter] || {}).each do |key, value|
        args[key.to_sym] = value.is_a?(Array) ? value.select(&:present?) : value
      end
      args.select { |key, value| value.present? }
    end
  end

  def set_permanent_cookie
    if !cookies[:per_page] || filter_params[:per_page]
      cookies.permanent[:per_page] = filter_params[:per_page] || Kaminari.config.default_per_page
    end
  end

  def beginning_date
    @scope = @scope.where("#{date_type} >= ?", filter_params[:beginning_date])
  end

  def end_date
    @scope = @scope.where("#{date_type} <= ?", filter_params[:end_date])
  end

  def date_type
    case filter_params[:date_type]
    when "updated_at"
      :updated_at
    when "deleted_at"
      :deleted_at
    else
      :created_at
    end
  end

  def user
    ids = [filter_params[:user]].flatten
    ids = ids.map { |hashid| User.hashid_decode(hashid) }
    @scope = @scope.where(user_id: ids)
  end

  def sort_by
    return unless @scope.model.sort_by.include?(filter_params[:sort_by])
    return unless %w(asc desc).include?(filter_params[:sort_direction])
    @scope = @scope.reorder("#{filter_params[:sort_by]} #{filter_params[:sort_direction]}")
  end

  def paginated
    @scope = @scope.page(params[:page]).per(cookies[:per_page])
  end
end
