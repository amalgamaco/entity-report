class ReportsController < ApplicationController
	include EntityReport::Controllers::ReportsController
	include Renderer
	rescue_from ::StandardError, with: :render_standard_error
	rescue_from EntityReport::Errors::Error, with: :render_error
	rescue_from ::ActiveRecord::RecordNotFound, with: :render_record_not_found
	rescue_from ::ActiveRecord::RecordInvalid, with: :render_invalid_record_attribute

	def report_klass
		Report
	end

	def report_mailer
		ReportMailer
	end

	def render_report(report)
		render_successful_response report, ReportSerializer
	end
end