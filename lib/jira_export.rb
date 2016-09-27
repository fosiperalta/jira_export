require "jira_export/version"
require 'httparty'
require 'rest-client'
require 'pry'

module JiraExport
  class JiraSprint

  MAX_RESULT = 1000
  JIRA_BROWSE_URL = "https://zigroup.atlassian.net/browse/"
  ZIGL_TEAM_FIELD = "customfield_10101"
  SPRINT_INFO_FIELD = "customfield_10016"

  def self.cleaned_result(sprints)
    sprints.each do |sprint|
      sprint_result = full_result(sprint)
      puts ""
      puts "### #{parse_sprint_name_field(sprint_result.first['fields'][SPRINT_INFO_FIELD])} (id=#{sprint})"
      sprint_result.each do |issue|
        puts ('* ' + [
          issue['fields']['issuetype']['name'],
          "[#{issue['key']}] (#{JIRA_BROWSE_URL + issue['key']})",
          issue['fields']['summary']
        ].join(', '))
      end
    end
  end

  def self.full_result(sprint)
    all_issues = []
    while (issues = JSON(jira_response(sprint, all_issues.size))['issues']).any?
      all_issues += issues
    end
    all_issues
  end

  def self.jira_response(sprint, start_at)
    RestClient::Request.execute(
      method: :get,
      url: "https://zigroup.atlassian.net/rest/api/2/search?jql=#{jql_args(sprint)}&startAt=#{(start_at)}&maxResults=#{MAX_RESULT}",
      user: 'alfonso',
      password: ''
    )
  end

  def self.jql_args(sprint)
    "issuetype in (Bug, Story) AND status = Done AND Sprint = #{sprint} order by type".gsub(" ", "%20")
  end

  def self.parse_sprint_name_field(field)
    field.first.split(',').find { |e| e.include?('name') }.split('=')[1]
  end

  JiraSprint.cleaned_result(ARGV)
end
end
