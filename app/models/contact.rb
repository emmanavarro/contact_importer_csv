class Contact < ApplicationRecord

  belongs_to :user

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_elements = row.to_h
      contact = find_or_create_by!(name: contact_elements['name'], birthday: contact_elements['birthday'],
                                   phone: contact_elements['phone'], address: contact_elements['address'],
                                   credit_card: contact_elements['credit_card'],
                                   franchise: contact_elements['franchise'], email: contact_elements['email'],
                                   user_id: user.id)
      contact.update(contact_elements)
    end
  end
end
