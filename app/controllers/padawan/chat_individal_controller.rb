module Padawan
  class ChatIndividualController < Padawan::PadawanController

    def show
      @chat = model.find_by(user_1_id: current_user.id, user_2_id: params[:id])
      @chat = model.find_by(user_1_id: params[:id], user_2_id: current_user.id) if @chat.nil?
      @chat = model.create_by(user_1_id: current_user.id, user_2_id: params[:id]) if @chat.nil?
      @message = Message.new
    end

    def model
      Chat::Individual
    end

  end
end