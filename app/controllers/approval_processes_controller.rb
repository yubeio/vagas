class ApprovalProcessesController < ApplicationController
  before_action :set_approval_process, only: [:show, :update, :destroy]

  def index
    @approval_processes = ApprovalProcess.all

    render json: @approval_processes
  end

  def show
    render json: @approval_process
  end

  def create
    @approval_process = ApprovalProcess.new(approval_process_params)

    if @approval_process.save
      render json: @approval_process, status: :created, location: @approval_process
    else
      render json: @approval_process.errors, status: :unprocessable_entity
    end
  end

  def update
    if @approval_process.update(approval_process_params)
      render json: @approval_process
    else
      render json: @approval_process.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @approval_process.destroy
  end

  private

  def set_approval_process
    @approval_process = ApprovalProcess.find(params[:id])
  end

  def approval_process_params
    params.require(:approval_process).permit(:name, :description, :status)
  end
end
