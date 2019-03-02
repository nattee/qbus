class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.enum_to_st(enum_name,enum_value)
    a = "activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}";
    I18n.t(a);
  end
end
