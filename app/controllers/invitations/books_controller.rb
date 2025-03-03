class Invitations::BooksController < ActionController::Base
  respond_to? :html

  MAX_DISPLAYED_COMMENTS = 25

  def index
  end

  def show
    invitation = Invitation.find params[:id]

    # pass required variables for erb templating
    @invitation = invitation
    @guests = invitation.guests.pluck(:name).join(" & ")
    @wedding = invitation.wedding
    @invtitaion_comments = Invitation.fetch_filled_comments(MAX_DISPLAYED_COMMENTS).shuffle

    # TO-DO: should be inside the database instead of hardcoded
    @couple_story = "We met in college and immediately connected over our shared love for adventure. After years of traveling together, we decided it was time to get married!"
    @background_image_url = "https://s1.bukalapak.com/img/65345007103/original/data.png.webp" # Replace with your actual image URL
    @story_background_image = "https://s2.bukalapak.com/img/27632630203/original/data.png.webp" # Replace with another background image URL
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Tidak ditemukan woy!", status: 422 }
  end
end



