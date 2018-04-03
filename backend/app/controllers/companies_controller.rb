# frozen_string_literal: true

class CompaniesController < ApplicationController
  def index
    render json: { companies: Company.all, status: :ok }
  end

  def index_with_deleted
    render json: { companies: Company.all_with_deleted.order(:status, :id), status: :ok }
  end

  def show
    render json: { company: Company.where(id: params[:id]), status: :ok }
  end

  def create
    company = Company.new(company_params)

    if company.save
      render json: { message: I18n.t('company.success.created'), status: :ok }
    else
      render json: { message: I18n.t('company.failure.created'),
                     details: company.errors.full_messages, status: :bad_request }
    end
  end

  def update
    begin
      company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render(json: { message: I18n.t('company.errors.not_found'), status: :not_found }) && (return)
    end

    if company.update_attributes(company_params)
      render json: { message: I18n.t('company.success.updated'), status: :ok }
    else
      render json: { message: I18n.t('company.failure.updated'),
                     details: company.errors.full_messages, status: :bad_request }
    end
  end

  def destroy
    begin
      company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render(json: { message: I18n.t('company.errors.not_found'), status: :not_found }) && (return)
    end

    company.deleted!

    render json: { message: I18n.t('company.success.deleted'), status: :ok }
  end

  private

  def company_params
    params.permit(:name, :employees_quantity, :cnpj)
  end
end
