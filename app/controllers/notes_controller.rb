class NotesController < ApplicationController
  
  def new
    
  end
  
  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    @note.update(note_params)
    redirect_to '/'    
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def show
  end

  def index
    @user = current_user
    @notes = Note.none
    if @user
      @notes = current_user.readable
    end
  end

  def about
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
