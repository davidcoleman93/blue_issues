class IssueMailer < ActionMailer::Base
  #default from: "from@example.com"
  default from: "blueissues@gmail.com"
  #default from: 'Sam Ruby <depot@example.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.issue_mailer.assigned.subject
  #
  def assigned(issue)
    @greeting = "Hi"
	@issue = issue
	
	mail to: issue.assignee.email, subject: 'New Issue Assigned to You'
    #mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.issue_mailer.changed.subject
  #
  def changed(issue, user)
    @greeting = "Hi"
	@issue = issue
	@user = user
	
    #mail to: issue.creator.email, subject: 'Changes To Created Issue'
	#@watchers = @issue.watchers.where(issue_id: @issue.id)
	#@watchers = @issue.watchers
	#for w in @watchers
	#for w in @issue.watchers
			#mail to: w.user.email, subject: 'Changes To Created Issue'
	mail to: user.email, subject: 'Changes To Created Issue'
	#end
	
  end
end
