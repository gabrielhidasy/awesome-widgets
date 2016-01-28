-- Paste this file in your rc.lua and customize the commands inside io.popen for
-- your setup

mailwidget = wibox.widget.textbox()
mailwidget:set_text("Mail | ")
mailwidgettimer = timer({timeout=50})

function updateMail ()
   mailbox1 = assert(io.popen("ls ~/Mail/gmail/INBOX/new/ | wc -l","r")):read()
   mailbox2 = assert(io.popen("ls ~/Mail/private/INBOX/new/ | wc -l","r")):read()
   response = ""

   if mailbox1 == "0" and mailbox2 == "0" then
      response = response.." No new mail"
   end
   if not(mailbox1=="0") then
      response = response.."G: "..mailbox1
      if not(mailbox2 == "0") then
         response = response.." - "
      end
   end
   if not(mailbox2 == "0") then
      response = response.."P: "..mailbox2
   end
      mailwidget:set_markup(response.." | ")
end

mailwidgettimer:connect_signal("timeout",updateMail)
mailwidgettimer:start()
