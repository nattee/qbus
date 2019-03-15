class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.enum_to_st(enum_name,enum_value)
    if enum_value == nil
      return nil
    end
    a = "activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}"
    return I18n.t(a)
  end
end
