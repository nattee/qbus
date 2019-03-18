class CriteriumEvidence < ApplicationRecord
  self.table_name = "criteria_evidences"
  belongs_to :criterium
  belongs_to :evidence
end
