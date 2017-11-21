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
    @filter_params ||= begin
      args = {}
      (params[:filter] || {}).each do |key, value|
        args[key.to_sym] = value.is_a?(Array) ? value.select(&:present?) : value
      end
      args.select { |_key, value| value.present? }
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
    return @scope.model_name.plural + ".created_at" unless filter_params[:date_type]
    model = @scope.model_name.singular.classify.constantize
    return filter_params[:date_type] if model.class.sort_by.include?(filter_params[:date_type])
  end

  def user
    ids = [filter_params[:user]].flatten.map { |id| User.hashid_decode(id) }
    @scope = @scope.where(user_id: ids).reorder("users.name ASC")
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
