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
    @calendar_url = generate_calendar_url
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

  def generate_calendar_url
    calendar_hash = {
      text: "The Wedding Of Nicky & Nova",
      dates: "20250607T040000Z/20250607T060000Z",
      details: "You are invited to attend the holy matrimony of Nicky & Nova Wedding",
      location: "GBI Basilea Christ Cathedral (https://g.co/kgs/iTL9qDT)"
    }
    query_string = calendar_hash.to_query

    base_url = "https://calendar.google.com/calendar/r/eventedit?"
    return base_url + query_string
  end
end
