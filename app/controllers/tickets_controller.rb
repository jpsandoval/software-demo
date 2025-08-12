class TicketsController < ApplicationController
  def create
    name = params[:full_name]
    rut  = params[:rut]
    code = generate_code(name, rut)

    ticket = Ticket.create(full_name: name, rut: rut,                            code: code, paid: false, checked_in: false)

    render json: ticket
  end

  def generate_code(name, rut)
    seed = ENV.fetch("SECRET_SEED", “cadena secreta”)
    Digest::SHA256.hexdigest("#{name}|#{rut}|#{seed}")[0, 10]
  end

  def status
    ticket = Ticket.find_by(code: params[:code])
    if ticket
      render json: ticket
    else
      render json: { error: "Ticket not found" }, status: :not_found
    end
  end


  def pay
    ticket = Ticket.find_by(code: params[:code])
    if ticket
      ticket.update(paid: true)
      render json: ticket
    else
      render json: { error: "Ticket not found" }, status: :not_found
    end
  end

  def purge_unpaid
    deleted = Ticket.where(paid: false).delete_all
    render json: { deleted: deleted }
  end

end
