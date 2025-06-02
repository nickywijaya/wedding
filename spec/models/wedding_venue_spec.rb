# spec/models/wedding_venue_spec.rb
require 'rails_helper'

RSpec.describe WeddingVenue, type: :model do

  describe 'relation' do
    context 'belongs_to Weddings' do
      it { should respond_to(:wedding) }
    end

    context 'belongs_to Venue' do
      it { should respond_to(:venue) }
    end
  end
end