class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  $vapid_private =  "KIYVQ1X-WbI9ICPuNudM4L5vPX16wd1UrL6a7WHOnus="  
  $vapid_public = "BACfNWl1UqWyyRHIw7wRbm0ZHyVYing85sBOVMzmy5rDIsp-OipzJ7iHG3TtU8-_n9bS2k2WezFmt9vAtC0x9Bo="

end
