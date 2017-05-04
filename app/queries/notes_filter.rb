class NotesFilter < ApplicationFilter
  def call
    @scope = Note.includes(:user).recently_created
    methods = %i(user sort_by beginning_date end_date)
    methods.each { |method| send(method) if filter_params[method] }
    paginated
  end
end
