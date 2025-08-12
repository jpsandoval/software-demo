# app/controllers/tickets_controller.rb
class TicketsController < ApplicationController


  # 1) Create ticket and generate code
  def create
    name = params[:full_name]
    rut  = params[:rut]
    code = generate_code(name, rut)

    ticket = Ticket.create(full_name: name, rut: rut, code: code, paid: false, checked_in: false)

    render json: { code: ticket.code, full_name: ticket.full_name, rut: ticket.rut, paid: ticket.paid }
  end

  # 2) Pay ticket
  def pay
    ticket = Ticket.find_by(code: params[:code])
    if ticket
      ticket.update(paid: true)
      render json: { code: ticket.code, paid: ticket.paid }
    else
      render json: { error: "Ticket not found" }, status: :not_found
    end
  end

  # 3) Check-in
  def checkin
    ticket = Ticket.find_by(code: params[:code], rut: params[:rut])
    if ticket && ticket.paid && !ticket.checked_in
      ticket.update(checked_in: true)
      render json: { status: "ok", name: ticket.full_name }
    else
      render json: { status: "access denied" }
    end
  end
  
  # GET /tickets/:code/status
  def status
    ticket = Ticket.find_by(code: params[:code])
    if ticket
      render json: {
        code: ticket.code,
        full_name: ticket.full_name,
        paid: ticket.paid,
        checked_in: ticket.checked_in
      }
    else
      render json: { error: "Ticket not found" }, status: :not_found
    end
  end

  # 4) Remove unpaid tickets older than 2 days
  def purge_unpaid
    cutoff = 2.days.ago
    deleted = Ticket.where(paid: false).where("created_at < ?", cutoff).delete_all
    render json: { deleted: deleted }
  end

  private

  def generate_code(name, rut)
    seed = ENV.fetch("SECRET_SEED", "dev-seed")
    Digest::SHA256.hexdigest("#{name}|#{rut}|#{seed}")[0, 10]
  end
end