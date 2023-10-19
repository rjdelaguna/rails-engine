class Api::V1::SearchController < ApplicationController
  def merchants_find
    if params.include?(:name) && params[:name] != ""
      if Merchant.find_by_name(params[:name]) != nil
        render json: MerchantSerializer.new(Merchant.find_by_name(params[:name]))
      else
        render json: MerchantSerializer.new(MerchantPoro.new)
      end
    else
      render json: ErrorSerializer.new, status: 400
    end
  end

  def items_find
    if params.include?(:name) && params[:name] != "" && !params.include?(:max_price) && !params.include?(:min_price)
      render json: ItemFacade.nil_check(Item.find_by_name(params[:name]))
    elsif (params.include?(:max_price) && params[:max_price] != "" && params.include?(:min_price) && params[:min_price] != "") && (params[:max_price].to_i >= 0 && params[:min_price].to_i >= 0) && params[:min_price].to_i <= params[:max_price].to_i && !params.include?(:name)
      render json: ItemFacade.nil_check(Item.find_by_max_min(params[:max_price], params[:min_price]))
    elsif (params.include?(:max_price) && params[:max_price] != "") && params[:max_price].to_i >= 0 && !params.include?(:min_price) && !params.include?(:name)
      render json: ItemFacade.nil_check(Item.find_by_max(params[:max_price]))
    elsif (params.include?(:min_price) && params[:min_price] != "") && params[:min_price].to_i >= 0 && !params.include?(:max_price) && !params.include?(:name)
      render json: ItemFacade.nil_check(Item.find_by_min(params[:min_price]))
    else
      render json: ErrorSerializer.new, status: 400
    end
  end

  def merchants_find_all
    if params.include?(:name) && params[:name] != ""
      render json: MerchantSerializer.new(Merchant.find_all_by_name(params[:name]))
    else
      render json: ErrorSerializer.new, status: 400
    end
  end

  def items_find_all
    if params.include?(:name) && params[:name] != "" && !params.include?(:max_price) && !params.include?(:min_price)
      render json: ItemFacade.nil_check(Item.find_all_by_name(params[:name]))
    elsif (params.include?(:max_price) && params[:max_price] != "" && params.include?(:min_price) && params[:min_price] != "") && (params[:max_price].to_i >= 0 && params[:min_price].to_i >= 0) && params[:min_price].to_i <= params[:max_price].to_i && !params.include?(:name)
      render json: ItemFacade.nil_check(Item.find_all_by_max_min(params[:max_price], params[:min_price]))
    elsif (params.include?(:max_price) && params[:max_price] != "") && params[:max_price].to_i >= 0 && !params.include?(:min_price) && !params.include?(:name)
      render json: ItemFacade.nil_check(Item.find_all_by_max(params[:max_price]))
    elsif (params.include?(:min_price) && params[:min_price] != "") && params[:min_price].to_i >= 0 && !params.include?(:max_price) && !params.include?(:name)
      render json: ItemFacade.nil_check(Item.find_all_by_min(params[:min_price]))
    else
      render json: ErrorSerializer.new, status: 400
    end
  end
end