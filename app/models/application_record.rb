# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors.add attribute, (options[:message] || 'is not a valid email')
      end
    end
  end

  class CreditCardModel
    attr_accessor :number

    include ActiveModel::Validations
    validates :number, presence: true, credit_card_number: true
  end
end
