require 'test_helper'

class IssueMailerTest < ActionMailer::TestCase
  test "assigned" do
    mail = IssueMailer.assigned
    assert_equal "Assigned", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "changed" do
    mail = IssueMailer.changed
    assert_equal "Changed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
