class Invitations::BooksController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:show, :create]

  MAX_DISPLAYED_COMMENTS = 25

  def index
  end

  def show
    # pass required variables for erb templating
    @guests = @invitation.guests.pluck(:name).join(" & ")
    @wedding = @invitation.wedding
    @invtitaion_comments = Invitation.fetch_filled_comments(MAX_DISPLAYED_COMMENTS).shuffle
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Tidak ditemukan woy!", status: 422 }
  end

  def create
    BookService.book(@invitation, create_attributes)

    redirect_to invitations_show_path(@invitation), notice: 'Sukses RSVP, Thanks!'
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Tidak ditemukan woy!", status: 422 }
  end

  private

  def load_resource
    @invitation = Invitation.find params[:id]
  end

  def create_attributes
    attribute = params.permit(:comments).to_h

    # transform attributes
    attribute[:comments] = attribute[:comments].to_s.strip
    attribute[:attending] = true # TO-DO: use a radio button to confirm attending or not

    attribute
  end
end



