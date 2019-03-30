class PublicComment < ApplicationRecord
  belongs_to :route, optional: true
  belongs_to :car, optional: true
  belongs_to :licensee, optional: true

  validates :comment, presence: true
  validates :commenter_name, presence: true
  validates :commenter_contact, presence: true
  validates :commenter_address, presence: true

  before_validation :update_references

  def to_label
    "[#{self.updated_at}] #{self.commenter_name}"
  end

  # update reference based on user input. reference should be <nil> if not found
  def update_references
    self.route = Route.where(route_no: self.route_no).first()
    self.car = Car.where(plate: self.car_plate).first()
    self.licensee = Licensee.where(name: self.licensee_name).first()
  end
end
