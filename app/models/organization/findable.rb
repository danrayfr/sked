module Organization::Findable
  extend ActiveSupport::Concern

  included do
    before_create { self.uid = generate_uid }
  end

  private
    def generate_uid
      self.uid = loop do
        randomizer = SecureRandom.hex(4).to_i(16) & 10000000
        break randomizer unless self.class.exists?(uid: randomizer)
      end
    end
end
