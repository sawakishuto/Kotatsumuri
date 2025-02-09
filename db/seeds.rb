# Plant モデルのモックデータ
plant = Plant.create!(
  name: 'バラ',
  description: 'A beautiful flowering plant.',
  search_key: 'バ'
)

plants = [
  { name: 'チューリップ', description: 'A vibrant spring flower.', search_key: 'チ' },
  { name: 'ヒマワリ', description: 'A tall flower that follows the sun.', search_key: 'ヒ' },
  { name: 'スズラン', description: 'A delicate white flower with a sweet fragrance.', search_key: 'ス' },
  { name: 'ラベンダー', description: 'A fragrant herb with purple flowers.', search_key: 'ラ' },
  { name: 'コスモス', description: 'A colorful autumn flower.', search_key: 'コ' },
  { name: 'アジサイ', description: 'A flower that changes color based on soil acidity.', search_key: 'ア' },
  { name: 'モミジ', description: 'A Japanese maple tree known for its red leaves.', search_key: 'モ' },
  { name: 'ボタン', description: 'A large and showy flower.', search_key: 'ボ' },
  { name: 'サクラ', description: 'A Japanese cherry blossom.', search_key: 'サ' },
  { name: 'バラ', description: 'A classic symbol of love and beauty.', search_key: 'バ' },
  { name: 'キク', description: 'A traditional flower in Japan.', search_key: 'キ' },
  { name: 'スイセン', description: 'A trumpet-shaped flower that blooms in spring.', search_key: 'ス' },
  { name: 'ハス', description: 'A sacred flower that grows in ponds.', search_key: 'ハ' },
  { name: 'ツバキ', description: 'An evergreen shrub with glossy leaves and flowers.', search_key: 'ツ' },
  { name: 'フジ', description: 'A cascading flower that grows on vines.', search_key: 'フ' },
  { name: 'カエデ', description: 'A type of maple tree with vibrant autumn colors.', search_key: 'カ' },
  { name: 'ナデシコ', description: 'A small and charming flower.', search_key: 'ナ' },
  { name: 'ミモザ', description: 'A bright yellow flower with a fluffy appearance.', search_key: 'ミ' },
  { name: 'リンドウ', description: 'A deep blue flower that blooms in late summer.', search_key: 'リ' },
  { name: 'アイリス', description: 'A regal flower with intricate patterns.', search_key: 'ア' }
]

plants.each do |plant|
  Plant.create!(plant)
end

# GrowthCondition モデルのモックデータ
GrowthCondition.create!(
  plant: plant,
  light: 'Full Sun',
  soil: 'Well-drained',
  hardiness_zone: '3-9'
)

# # CarePeriod モデルのモックデータ
CarePeriod.create!(
  plant: plant,
  period_type: 'fertilizing_period',
  start_date: DateTime.parse('2024-01-01 10:00:00'),
  end_date: DateTime.parse('2024-03-01 10:00:00')
)

CarePeriod.create!(
  plant: plant,
  period_type: 'pruning_period',
  start_date: DateTime.parse('2024-04-01 10:00:00'),
  end_date: DateTime.parse('2024-06-01 10:00:00')
)

# # PropagationMethod モデルのモックデータ
PropagationMethod.create!(
  plant: plant,
  description: 'Cutting'
)

# User モデルのモックデータ
User.create!(
  firebase_uid: '111',
  name: '山田 太郎',
  email: 'yamadataro123@gmail.com',
  profile_image_url: 'https://qiita-user-profile-images.imgix.net/https%3A%2F%2Favatars.githubusercontent.com%2Fu%2F131576261%3Fv%3D4?ixlib=rb-4.0.0&auto=compress%2Cformat&lossless=0&w=128&s=ecf0979eb5508ccd0104d17d74e75ddd'
)


User.create!(
  firebase_uid: '222',
  name: '立命 花子',
  email: 'Hana@gmail.com',
  profile_image_url: 'https://qiita-user-profile-images.imgix.net/https%3A%2F%2Favatars.githubusercontent.com%2Fu%2F131576261%3Fv%3D4?ixlib=rb-4.0.0&auto=compress%2Cformat&lossless=0&w=128&s=ecf0979eb5508ccd0104d17d74e75ddd'
)

User.create!(
  firebase_uid: 'I0AFEbP6GbdY4joUuCsVn5heacx1',
  name: '太田 啓夢',
  email: 'Hi@gmail.com',
  profile_image_url: 'https://qiita-user-profile-images.imgix.net/https%3A%2F%2Favatars.githubusercontent.com%2Fu%2F131576261%3Fv%3D4?ixlib=rb-4.0.0&auto=compress%2Cformat&lossless=0&w=128&s=ecf0979eb5508ccd0104d17d74e75ddd'
)

# UsersPlant モデルのモックデータ
# 全ての Plant レコードを取得
plantss = Plant.all

plantss.each do |plant|
  CarePeriod.create!(
    plant: plant,
    period_type: 'fertilizing_period',
    start_date: DateTime.parse('2024-01-01 10:00:00'),
    end_date: DateTime.parse('2024-03-01 10:00:00')
  )

  CarePeriod.create!(
    plant: plant,
    period_type: 'pruning_period',
    start_date: DateTime.parse('2024-04-01 10:00:00'),
    end_date: DateTime.parse('2024-06-01 10:00:00')
  )
end

puts(plantss.ids)

# 各 Plant の id を使って UsersPlant を作成
plantss.each do |plant|
  puts (plant.id)
  UsersPlant.create!(
    firebase_uid: 'I0AFEbP6GbdY4joUuCsVn5heacx1',
    plant_id: plant.id,
  )
end
