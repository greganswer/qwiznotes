class NotesFilter  < ApplicationFilter
  def call
    return Note.page(params[:page]).per(cookies[:per_page]) if Note.count.zero?
    set_input
    methods = %i(sort_by beginning_date end_date user tag)
    methods.each { |method| send(method) if filter_params[method] }
    Note.search(params[:q].presence || '*', @input)
  end

  #
  # Protected
  #

  protected

  def set_input
    @input = {
      suggest: Rails.env.test? ? false : true,
      includes: :user,
      page: params[:page],
      order: { Note::DEFAULT_SORT_BY => { order: Note::DEFAULT_SORT_DIRECTION } },
      per_page: cookies[:per_page],
    }
  end

  def beginning_date
    (@input[:where][date_type] ||= {})[:gte] = Time.zone.parse(filter_params[:beginning_date])
  end

  def end_date
    (@input[:where][date_type] ||= {})[:lte] = Time.zone.parse(filter_params[:end_date])
  end

  def sort_by
    return unless Note.sort_by.include?(filter_params[:sort_by])
    return unless %w(asc desc).include?(filter_params[:sort_direction])
    @input[:order] = { filter_params[:sort_by] => { order: filter_params[:sort_direction] } }
  end

  def user
    ids = [filter_params[:user]].flatten
    ids = ids.map { |hashid| User.hashid_decode(hashid) }
    (@input[:where]||= {})[:user_id] = ids
  end

  def tag
    # (@input[:where]||= {})["taggings.tag.name"] = filter_params[:tag]
  end
end
