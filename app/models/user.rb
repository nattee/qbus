class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  has_many :datafiles, :dependent => :destroy
  has_many :applications, :dependent => :destroy
  has_many :appointed_applications, foreign_key: "appointment_user_id", class_name: "Application", :dependent => :nullify

  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { minimum: 6, maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
    format: {with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_secure_password

  store :roles, accessors: [ :admin, :verifier, :surveyor, :committee, :licensee, :evaluator], coder: JSON

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def can_view_all_provinces?
    return self.is_admin? || self.all_provinces?
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #roles
  def is_admin?
    return roles[:admin].to_s == '1'
  end

  def has_role(role)
    return true if is_admin?
    return false unless roles[role]
    return roles[role].to_s == '1'
  end

  def has_roles(roles = [])
    roles.each do |r|
      return true if has_role(r)
    end
    return false
  end

  def is_official?
    return has_role(:committee) || has_role(:surveyor) || has_role(:evaluator) || has_role(:verifier)
  end

  def role_array
    roles.to_hash.select{ |k,v| v.to_s == '1'}.keys.map { |k| I18n.t(k, scope: 'activerecord.attributes.user') }
  end

  def role_summary
    st = []
    st << 'ผู้ดูแลระบบ' if is_admin?
    st << 'เจ้าหน้าที่' if is_official?
    st << 'ผู้ประกอบการ' if has_role(:licensee)
    return st.join ', '
  end


  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

  public

  PROVINCE_ABBR = [
    { short: 'กบ', full: 'กระบี่'},
    { short: 'กท', full: 'กรุงเทพมหานคร'},
    { short: 'กจ', full: 'กาญจนบุรี'},
    { short: 'กส', full: 'กาฬสินธุ์'},
    { short: 'กพ', full: 'กำแพงเพชร'},
    { short: 'ขก', full: 'ขอนแก่น'},
    { short: 'จบ', full: 'จันทบุรี'},
    { short: 'ฉช', full: 'ฉะเชิงเทรา'},
    { short: 'ชบ', full: 'ชลบุรี'},
    { short: 'ชน', full: 'ชัยนาท'},
    { short: 'ชย', full: 'ชัยภูมิ'},
    { short: 'ชพ', full: 'ชุมพร'},
    { short: 'ชร', full: 'เชียงราย'},
    { short: 'ชม', full: 'เชียงใหม่'},
    { short: 'ตง', full: 'ตรัง'},
    { short: 'ตร', full: 'ตราด'},
    { short: 'ตก', full: 'ตาก'},
    { short: 'นย', full: 'นครนายก'},
    { short: 'นฐ', full: 'นครปฐม'},
    { short: 'นพ', full: 'นครพนม'},
    { short: 'นม', full: 'นครราชสีมา'},
    { short: 'นศ', full: 'นครศรีธรรมราช'},
    { short: 'นว', full: 'นครสวรรค์'},
    { short: 'นบ', full: 'นนทบุรี'},
    { short: 'นธ', full: 'นราธิวาส'},
    { short: 'นน', full: 'น่าน'},
    { short: 'บก', full: 'บึงกาฬ'},
    { short: 'บร', full: 'บุรีรัมย์'},
    { short: 'ปท', full: 'ปทุมธานี'},
    { short: 'ปข', full: 'ประจวบคีรีขันธ์'},
    { short: 'ปจ', full: 'ปราจีนบุรี'},
    { short: 'ปน', full: 'ปัตตานี'},
    { short: 'พย', full: 'พะเยา'},
    { short: 'อย', full: 'พระนครศรีอยุธยา'},
    { short: 'พง', full: 'พังงา'},
    { short: 'พท', full: 'พัทลุง'},
    { short: 'พจ', full: 'พิจิตร'},
    { short: 'พล', full: 'พิษณุโลก'},
    { short: 'พบ', full: 'เพชรบุรี'},
    { short: 'พช', full: 'เพชรบูรณ์'},
    { short: 'พร', full: 'แพร่'},
    { short: 'ภก', full: 'ภูเก็ต'},
    { short: 'มค', full: 'มหาสารคาม'},
    { short: 'มห', full: 'มุกดาหาร'},
    { short: 'มส', full: 'แม่ฮ่องสอน'},
    { short: 'ยส', full: 'ยโสธร'},
    { short: 'ยล', full: 'ยะลา'},
    { short: 'รอ', full: 'ร้อยเอ็ด'},
    { short: 'รน', full: 'ระนอง'},
    { short: 'รย', full: 'ระยอง'},
    { short: 'รบ', full: 'ราชบุรี'},
    { short: 'ลบ', full: 'ลพบุรี'},
    { short: 'ลป', full: 'ลำปาง'},
    { short: 'ลพ', full: 'ลำพูน'},
    { short: 'ลย', full: 'เลย'},
    { short: 'ศก', full: 'ศรีสะเกษ'},
    { short: 'สน', full: 'สกลนคร'},
    { short: 'สข', full: 'สงขลา'},
    { short: 'สต', full: 'สตูล'},
    { short: 'สป', full: 'สมุทรปราการ'},
    { short: 'สส', full: 'สมุทรสงคราม'},
    { short: 'สค', full: 'สมุทรสาคร'},
    { short: 'สก', full: 'สระแก้ว'},
    { short: 'สบ', full: 'สระบุรี'},
    { short: 'สห', full: 'สิงห์บุรี'},
    { short: 'สท', full: 'สุโขทัย'},
    { short: 'สพ', full: 'สุพรรณบุรี'},
    { short: 'สฎ', full: 'สุราษฎร์ธานี'},
    { short: 'สร', full: 'สุรินทร์'},
    { short: 'นค', full: 'หนองคาย'},
    { short: 'นภ', full: 'หนองบัวลำภู'},
    { short: 'อท', full: 'อ่างทอง'},
    { short: 'อจ', full: 'อำนาจเจริญ'},
    { short: 'อด', full: 'อุดรธานี'},
    { short: 'อต', full: 'อุตรดิตถ์'},
    { short: 'อน', full: 'อุทัยธานี'},
    { short: 'อบ', full: 'อุบลราชธานี'},
  ]

  def self.province_options_for_select
    PROVINCE_ABBR.map { |x| [x[:full],x[:short]]}
  end

  def self.province_code_hash
    h = {}
    PROVINCE_ABBR.each { |x| h[x[:short]] = x[:full]}
    return h
  end
end
