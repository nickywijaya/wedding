FactoryBot.define do
  factory :wedding, class: 'Weddings' do
    groom   { 'groom' }
    bride   { 'bride' }
    story   { 'test-story' }
    hashtag { 'test-hastag' }
  end
end
