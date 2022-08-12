# frozen_string_literal: true

class Food < ApplicationRecord
  self.per_page = 100

  validates :name, presence: true
  validates :expiration, presence: true

  belongs_to :user

  scope :eaten,          -> { where.not(eaten_on: nil) }
  scope :trashed,        -> { where.not(trashed_on: nil) }
  scope :expiring,       -> { not_trashed.not_eaten }
  scope :expired,        -> { expiring_by(Time.current) }
  scope :expiring_by,    ->(date) { where('expiration < ?', date) }
  scope :expiring_after, ->(date) { where('expiration >= ?', date) }
  scope :not_eaten,      -> { where(eaten_on: nil) }
  scope :not_trashed,    -> { where(trashed_on: nil) }
  scope :ordered,        -> { order(expiration: :asc).order(Food.arel_table['name'].lower) }

  def trashed?
    trashed_on.present?
  end

  def eaten?
    eaten_on.present?
  end

  def throw_out!
    update!(trashed_on: Time.zone.today)
  end

  def finish_eating!
    update!(eaten_on: Time.zone.today)
  end

  def expiration_length
    (expiration - created_at.to_date).days
  end
end
