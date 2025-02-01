# Plant モデルのモックデータ
plant = Plant.create!(
  name: 'バラ',
  description: 'A beautiful flowering plant.',
  search_key: 'バ'
)

# GrowthCondition モデルのモックデータ
GrowthCondition.create!(
  plant: plant,
  light: 'Full Sun',
  soil: 'Well-drained',
  hardiness_zone: '3-9'
)

# CarePeriod モデルのモックデータ
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

# PropagationMethod モデルのモックデータ
PropagationMethod.create!(
  plant: plant,
  description: 'Cutting'
)

# User モデルのモックデータ
User.create!(
  line_user_id: '111',
  name: '山田 太郎',
  email: 'yamadataro123@gmail.com',
  encrypted_password: 'password',
  password: 'password',
  profile_image_url: 'https://qiita-user-profile-images.imgix.net/https%3A%2F%2Favatars.githubusercontent.com%2Fu%2F131576261%3Fv%3D4?ixlib=rb-4.0.0&auto=compress%2Cformat&lossless=0&w=128&s=ecf0979eb5508ccd0104d17d74e75ddd'
)

# UsersPlant モデルのモックデータ
UsersPlant.create!(
  uid: '111',
  plantid: plant.id,
)
