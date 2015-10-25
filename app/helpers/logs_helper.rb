module LogsHelper
  def is_own_log?(log)
    log.user == current_user
  end
end