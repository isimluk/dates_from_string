# frozen_string_literal: true

require 'dates_from_string/version'

class DatetimeFormatter
  def initialize(structure)
    @structure = structure
  end

  def start
    return unless @structure

    if (@structure.select { |father| father[:type] == :time }).any?
      get_year_month_day_time
    else
      get_year_month_day
    end
  end

  def get_year_month_day_time
    set_year_month_day_time

    @structure&.filter_map do |item|
      @year = item[:value] if item[:type] == :year

      @month = item[:value] if item[:type] == :month

      @day = item[:value] if item[:type] == :day

      @time = item[:value] if item[:type] == :time

      [[@year, @month, @day].join('-'), @time].join(' ') if @year && @month && @day && @time
    end
  end

  def get_year_month_day
    set_year_month_day_time

    @structure&.filter_map do |item|
      @year = item[:value] if item[:type] == :year

      @month = item[:value] if item[:type] == :month

      @day = item[:value] if item[:type] == :day

      [@year, @month, @day].join('-') if @year && @month && @day
    end
  end

  def set_year_month_day_time
    @year = nil
    @month = nil
    @day = nil
    @time = nil
  end
end
