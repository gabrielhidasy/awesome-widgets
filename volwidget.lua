-- Paste this file in your rc.lua and customize the commands inside io.popen and
--os.execute for your setup.
-- This widget requires a companion shell script "getaudio.sh"

volwidget = wibox.widget.textbox()
volwidget:set_text("SP X | ")
-- SP and HP mean Speaker and Headphones
volwidgettimer = timer({timeout=50})
function updateVolume ()

	fh=assert(io.popen("<path-to-getaudio.sh>","r"))
	volwidget:set_markup(fh:read("*l").." | ")
	fh:close()
	end
function raiseVolume ()
   os.execute("pulseaudio-ctl up&")
   os.execute("sleep 0.1")
   updateVolume()
end
function lowVolume ()
   os.execute("pulseaudio-ctl down&")
   os.execute("sleep 0.1")
   updateVolume()
end
function toggleVolume ()
   os.execute("pulseaudio-ctl mute&")
   os.execute("sleep 0.1")
   updateVolume()
end

volwidgettimer:connect_signal("timeout",updateVolume)
volwidget:buttons(
   awful.util.table.join(
      awful.button({ }, 1, toggleVolume),
      awful.button({ }, 4, raiseVolume),
      awful.button({ }, 5, lowVolume)
	))


volwidgettimer:start()
