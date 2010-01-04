What it is
========
A simple plugin to provide honeypots and the necessary validations.
It add fields to your forms, empty and filled, then checks if there values are unchanged.

Install
=======
script/plugin install git://github.com/grosser/honeypot.git

Usage
=====
Controller: 

    before_filter :check_honeypots, :only => [:create]
    
    OR - if the default render new + flash[:error] is not what you want
  
    def create
      render :action=>'error' and return unless honeypot_untouched?
      ...
    end

    
Inside form:
 
    =honeypot 

Other solutions
===============
If you want more sophisticated protection, (on cost of maintainability and usability)
try the [negative_captcha plugin](http://github.com/subwindow/negative-captcha/tree/master)