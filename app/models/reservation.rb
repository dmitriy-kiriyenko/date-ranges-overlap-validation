class Reservation < ActiveRecord::Base
  belongs_to :table

  validate :table_id, presence: true
  validate :range_overlap

  scope :overlaps, ->(interval) {
    where.not(id: interval.id)
      .where("date_part('epoch', (start_time - ?)) * date_part('epoch', (? - end_time)) >= 0",
             interval.end_time, interval.start_time)
  }

  def range_overlap
    errors.add(:base) if self.class.where(table_id: table_id).overlaps(self).any?
  end
end
