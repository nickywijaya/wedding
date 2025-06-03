FactoryBot.define do
  factory :guest, class: 'Guest' do
    name           { 'test-name' }
    gender         { 0 }
    contact        { '085939976117' }
    contact_source { 0 }
    from_groom     { true }
  end
end
