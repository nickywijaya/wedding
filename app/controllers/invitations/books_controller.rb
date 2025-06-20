class Invitations::BooksController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:show, :create]

  MAX_DISPLAYED_COMMENTS = 25

  def index
    # pass required variables for erb templating
    @wedding = Weddings.first # hardcoded to display some information to the wedding
    @invtitaion_comments = Invitation.fetch_filled_comments(MAX_DISPLAYED_COMMENTS).shuffle
    @calendar_url = generate_calendar_url
  rescue StandardError => e
    log_error(e, action_name)
    redirect_to error_path
  end

  def show
    # pass required variables for erb templating
    @guests = generate_guests
    @wedding = @invitation.wedding
    @invtitaion_comments = Invitation.fetch_filled_comments(MAX_DISPLAYED_COMMENTS).shuffle
    @calendar_url = generate_calendar_url
  rescue StandardError => e
    log_error(e, action_name, params[:id])
    redirect_to error_path
  end

  def create
    BookService.book(@invitation, create_attributes)

    redirect_to invitations_show_path(@invitation)
  rescue StandardError => e
    Rails.logger.error(
      tags: ['controller', self.class.name, action_name],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        params: params,
      }
    )
    redirect_to error_path
  end

  private

  def load_resource
    @invitation = Invitation.find params[:id]
  rescue StandardError, ActiveRecord::RecordNotFound => e
    log_error(e, action_name, params[:id])
    redirect_to error_path
  end

  def create_attributes
    attribute = params.permit(:comments,
                              :attending).to_h

    # transform attributes
    attribute[:comments] = attribute[:comments].to_s.strip
    attribute[:attending] = (attribute[:attending].to_s == "yes") ? true : false

    attribute
  end

  def generate_guests
    guest = ""

    if @invitation.with_partner?
      guest = @invitation.guests.first.name + " & Partner"
    elsif @invitation.with_family?
      guest= @invitation.guests.first.name + " & Family"
    else
      guest = @invitation.guests.pluck(:name).join(" & ")
    end

    return guest
  end

  def generate_calendar_url
    calendar_hash = {
      text: "The Wedding Of Jhon Doe & Melissa",
      dates: "20270707T000000Z/20270707T030000Z",
      details: "You are invited to attend the holy matrimony of Jhon Doe & Melissa Wedding",
      location: "Big Valley Grace Community Church (https://maps.app.goo.gl/TaE5mthP91Df9gXF7)"
    }
    query_string = calendar_hash.to_query

    base_url = "https://calendar.google.com/calendar/r/eventedit?"
    return base_url + query_string
  end

  def log_error(e, action, track_id=0)
    Rails.logger.error(
      tags: ['controller', self.class.name, action],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        track_id: track_id
      }
    )
  end
end
