module LogsHelper
  def is_own_log?(log)
    log.cyber_user == current_user
  end
end