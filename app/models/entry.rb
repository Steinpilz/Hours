# == Schema Information
#
# Table name: entries
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  category_id :integer          not null
#  user_id     :integer          not null
#  hours       :decimal(, )      not null
#  date        :date             not null
#  created_at  :datetime
#  updated_at  :datetime
#  description :string
#  billed      :boolean          default("false")
#

class Entry < ActiveRecord::Base
  include Twitter::Extractor

  audited allow_mass_assignment: true

  belongs_to :project, touch: true
  belongs_to :category
  has_one :client, through: :project
  belongs_to :user, touch: true
  has_many :taggings, inverse_of: :entry
  has_many :tags, through: :taggings

  validates :user, :project, :category, :date, presence: true
  validates :hours, presence: true,
                    numericality: { greater_than: 0 }

  accepts_nested_attributes_for :taggings

  scope :by_last_created_at, -> { order("created_at DESC") }
  scope :by_date, -> { order("date DESC") }
  scope :billable, -> { where("billable").joins(:project) }
  scope :with_clients, -> { where.not("projects.client_id" => nil).joins(:project) }

  before_save :set_tags_from_description

  def tag_list
    tags.map(&:name).join(", ")
  end

  private

  def set_tags_from_description
    tagnames = extract_hashtags(description)
    self.tags = tagnames.map do |tagname|
      Tag.where("name ILIKE ?", tagname.strip).first_or_initialize.tap do |tag|
        tag.name = tagname.strip
        tag.save!
      end
    end
  end
end
