class ErrorPoro
  attr_reader :message, :status

  def initialize(message, status)
    @message = message
    @status = status
  end
end