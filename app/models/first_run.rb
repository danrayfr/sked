class FirstRun
  def self.create!(user_params, organization_name)
    user = User.create!(user_params.merge(role: :administrator))

    Organization.create!(name: organization_name, user: user)

    user
  end
end
