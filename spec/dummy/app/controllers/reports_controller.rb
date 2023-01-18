class ReportsController < ApplicationController
	include EntityReport::Controllers::ReportsController

	def report_klass
		Report
	end

	def report_mailer
		ReportMailer
	end
end