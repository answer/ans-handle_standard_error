# -*- coding: utf-8 -*-

require "ans-handle_standard_error/version"

module Ans
  module HandleStandardError
    def self.included(m)
      m.send :rescue_from, StandardError, with: :rescue_from_standard_error if rescue_from_standard_error?
    end

    private

    def self.rescue_from_standard_error?
      Rails.env.production?
    end

    def rescue_from_standard_error(e)
      id = rescue_from_standard_error_id

      logger.fatal id
      logger.fatal "#{e.class} : #{e.message}"
      e.backtrace.each{|m| logger.fatal m}
      logger.fatal id

      Logger.new(rescue_from_standard_error_log).fatal id

      rescue_from_standard_error_render e
    end
    def rescue_from_standard_error_id
      "==#{SecureRandom.hex(20)}== #{Time.now}"
    end
    def rescue_from_standard_error_log
      Rails.root.join("log/error.log")
    end
    def rescue_from_standard_error_render(e)
      raise e
    end
  end
end
