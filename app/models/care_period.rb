class CarePeriod < ApplicationRecord
  # 検索日時が start_date < 今日 < end_date に該当するデータを取得
  def self.for_plant_ids_in_date_range(plant_ids, search_date)
    month_day = search_date.strftime("%m-%d")
    puts("search_date (month-day): #{month_day}")

    where(plant_id: plant_ids).where(
      "(to_char(start_date, 'MM-DD') <= ? AND to_char(end_date, 'MM-DD') >= ?) OR " \
      "(to_char(start_date, 'MM-DD') > to_char(end_date, 'MM-DD') AND " \
      "(to_char(start_date, 'MM-DD') <= ? OR to_char(end_date, 'MM-DD') >= ?))",
      month_day, month_day, month_day, month_day
    )
  end
end