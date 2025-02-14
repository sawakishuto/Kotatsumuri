class Plant < ApplicationRecord
  has_one_attached :image
  has_one :growth_condition
  has_many :care_periods
  has_many :propagation_methods
  has_many :users, through: :users_plants
  has_many :users_plants

  def self.search_wikipedia_image_url(search_key)
    require 'net/http'
    require 'uri'
    require 'json'

    base_url = 'https://ja.wikipedia.org/w/api.php'

    query_params = {
      action: 'query',
      titles: search_key,
      prop: 'pageimages',
      pithumbsize: 300,
      format: 'json'
    }

    uri = URI(base_url)
    uri.query = URI.encode_www_form(query_params)

    response = Net::HTTP.get(uri)

    parsed = JSON.parse(response)

    pages_data = parsed.dig('query', 'pages')
    return nil if pages_data.nil?

    page = pages_data.values.first
    return nil if page.nil?

    thumbnail_info = page['thumbnail']
    return nil if thumbnail_info.nil?

    thumbnail_info['source']
  end
end
