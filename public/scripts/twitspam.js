    var SPAMMER_THRESHOLD = 60;
    $(document).ready(function() {
        $("#username").focus();

        $("#submit").click(lookup);
        $("#form").submit(lookup);
    });

    function lookup()
    {
        hideMessage();
        var username = $("#username").val();
        if(username == "")
        {
            showMessage("Please enter a username", "info");
            return false;
        }

                $.get("/check", { username: username },
                function(result)
                {
                    percent_spam = parseFloat(result);

                    var message_class = "normal";
                    if(percent_spam < 0)
					{
					  message_class = "error";
					  message = "No data for that user.  Some users don't show up in Twitter search results.";
					}
					else if(percent_spam > SPAMMER_THRESHOLD)
					{
					  message_class = "spam";
					  message = percent_spam + "% of " + username + "'s recent posts look like spam to me.  Probably a spammer.";
					}
				  	else
					{
					  message_class = "normal";
					  message = "Only " + percent_spam + "% of " + username + "'s recent posts look like spam to me.  Probably not a spammer.";
					}
                    showMessage(message,message_class);
                });
        return false;

    }
    function hideMessage()
    {
        $("#message").fadeOut();
    }

    function showMessage(message, message_class)
    {
        $("#message").text(message);
        $("#message").removeClass();
        $("#message").addClass(message_class);
        $("#message").fadeIn();
    }