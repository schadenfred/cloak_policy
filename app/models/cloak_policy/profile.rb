class Profile < Category

  has_many :use_cases, foreign_key: :parent_id, dependent: :destroy

  accepts_nested_attributes_for :use_cases

  # module Profile
  def self.profile_types
     {
      executive: "You are a person with senior managerial responsibility in a business organization.",
      public_figure: "A person, such as a politician, celebrity, social media personality, or business leader, who has a certain social position within a certain scope and a significant influence so is often widely concerned by the public, can benefit enormously from society, and is closely related to public interests in society.",
      individual: "A person who uses online services, social networking and other services."
    }
  end

end
