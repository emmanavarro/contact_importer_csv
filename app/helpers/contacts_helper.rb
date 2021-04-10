module ContactsHelper
  def format_date(birthday)
    Date.parse(birthday).strftime('%Y %B %d')
  end
end
