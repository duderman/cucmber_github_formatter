# frozen_string_literal: true

# Main formatter class
class CucumberGithubFormatter
  VERSION = '0.1.0'

  def initialize(config)
    config.on_event :test_case_finished, &method(:print_github_message)
  end

  def print_github_message(event) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    if event.result.failed?
      status = 'error'
      message = 'failed: ' + event.result.exception.message.to_s
      file, line = event.result.exception.backtrace.last.split(':')
    elsif event.result.pending?
      status = 'warning'
      message = 'pending'
      file = event.test_case.location.file
      line = event.test_case.location.lines.to_s
    else
      return
    end

    name = event.test_case.name
    puts "::#{status} file=#{file},line=#{line}::#{name} #{message}"
  end
end
