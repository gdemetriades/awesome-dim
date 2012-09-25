--display master volume
 
master_volume = widget({ type = "textbox" })
 
update_volume = function()
   master_volume.text ="[ "..awful.util.pread("amixer -c 0 get Master | sed -n \"$ p\" | awk '{print $6}' | sed \"s/[^0-9,a-Z,.,-]//g\"").." ] "
end

update_volume()

module("dim.widget.volume")
