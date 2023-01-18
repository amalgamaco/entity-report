class ReportMailer < ActionMailer::Base
	default from: email_address_with_name("example@example.com", "moderation")
	layout 'mailer'

	def report_email
		@report = params[:report]

		mail(to: "example_email@example.com", subject: 'Report')
	end
end