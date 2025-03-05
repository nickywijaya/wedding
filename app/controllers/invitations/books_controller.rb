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
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Tidak ditemukan woy!", status: 422 }
  end
end



