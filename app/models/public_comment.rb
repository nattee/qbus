class PublicComment < ApplicationRecord
  belongs_to :route, optional: true
  belongs_to :car, optional: true
  belongs_to :licensee, optional: true

  validates :comment, presence: true
  validates :commenter_name, presence: true
  validates :commenter_contact, presence: true
  validates :commenter_address, presence: true

  before_validation :update_references

  def self.by_application(application_id)
    comments = PublicComment.none

    curApp = Application.find(application_id)
    if (curApp == nil)
      return comments
    end

    rid = curApp.route_id
    lid = curApp.licensee_id
    cids = curApp.cars&.pluck(:id)

    if (rid != nil)
      comments = comments.or(PublicComment.where(route_id: rid))
    end

    if (lid != nil)
      comments = comments.or(PublicComment.where(licensee_id: lid))
    end

    if (!cids.empty?)
      comments = comments.or(PublicComment.where(car_id: cids))
    end

    return comments
  end

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
