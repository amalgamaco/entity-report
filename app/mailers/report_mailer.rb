# [HIGH] - Todo lo que está en esta carpeta app/ no debería estar en realidad, no?
# Porque son los archivos que se generan automáticamente a partir de los
# templates, no?
class ReportMailer < ActionMailer::Base
	default from: email_address_with_name("example@example.com", "moderation")
	layout 'mailer'

	def report_email
		@report = params[:report]

		mail(to: "example_email@example.com", subject: 'Report')
	end
end