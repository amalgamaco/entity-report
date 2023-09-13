# EntityReport

## Installation

Add this line to your project's Gemfile:

```ruby
gem 'entity_report', github: 'amalgamaco/entity-report'
```

And then execute:

```shell
bundle install
```

## Usage

After installing the gem run the following command:

```shell
rails g entity_report:install
```

This command will generate:
- Report model (app/models/report.rb)
- Report Migration (db/migrate/xxxxxxxxxxxxxx_create_reports.rb)
- Report Mailer (app/mailers/report_mailer.rb)
- Report Mail (app/views/report_mailer/report_email.html.erb)
- Report Mail Text (app/views/report_mailer/report_email.text.erb)

You can customize the given files to match your necessities.

The gem provides two modules that you should include to make things work:

```ruby
EntityReport::Modules::Reportable
```

This module should be included in classes that could be reported (also, those classes must be listed in the Report's REPORTABLE_TYPES). The Reportable module requires the method `reportable_by_user?(user_id:)` implemented in the including class.

For example: 

```ruby
class User < ApplicationRecord

	include EntityReport::Modules::Reportable

	def reportable_by_user?(user_id:)
		user_id != self.id
	end
end
```

The other important module is:

```ruby
EntityReport::Controllers::ReportsController
```

This module should be included in a controller that implements `render_report(report)`, `report_mailer` and `report_klass`

For example:

```ruby
class ReportsController < ApplicationController
	include EntityReport::Controllers::ReportsController

	#Adapt rescues to your proyect!
	rescue_from EntityReport::Errors::Error, with: :render_error

	def report_klass
		Report
	end

	def report_mailer
		ReportMailer
	end

	def render_report(report)
		#Adapt this method to your code
		render_successful_response report, ReportSerializer
	end
end
```

Once included, this module provides the `create` method that requires the following params:

```ruby
:reportable_type, :reportable_id, :reason, :description
```

With that setup made, the only thing left is to add the route:

```ruby
resources :reports, only: [:create]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`.