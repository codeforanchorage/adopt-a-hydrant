class ThingMailer < ActionMailer::Base
  default from: "AdoptAHydrant@ci.anchorage.ak.us"

  def reminder(thing)
    @thing = thing
    @user = thing.user
    mail(
      {
        from: 'AdoptAHydrant@ci.anchorage.ak.us',
        to: thing.user.email,
        subject: ["Remember to shovel", thing.name].compact.join(' '),
      }
    )
  end
end
