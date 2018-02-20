# Terminal Post-It Notes
# 1.0
# Shows Post-It Notes In Terminal Windows Using Dialog.
# Buscedv @ Github.com

# Variables:
savedpostitnotes=$(cat saved_notes.txt)

clear
dialog --help
var=$(echo "$?")

if [ "$var" = "127" ]; then
	echo "Dialog Is Not Installed But Required Install Now:"
	sudo apt-get install dialog
	echo "Dialog is now installed!"
	sh postit.sh

elif [ "$var" = "0" ]; then

	dialog --stdout --backtitle "Terminal Post-It Notes " --title "Open Post-It Note" --treeview "Choose a Post-It Note to Open:" 20 70 15 $savedpostitnotes > temp_note_selection.txt

	selection=$(cat temp_note_selection.txt)

	dialog --extra-button --extra-label "Edit" --title "$selection" --textbox "$selection" 20 70

	edit_ok=$?
	echo "$edit_ok"

	if [ "$edit_ok" = "0" ]
		then

		echo "OK"
		sh postit.sh

	elif [ "$edit_ok" = "3" ]
		then

		echo "Edit"

		dialog --stdout --title "Editing, $selection" --editbox "$selection" 20 70 > temp_note_save.txt

		note_save=$(cat temp_note_save.txt)
		echo "$note_save"
		rm $selection
		touch $selection
		echo "$note_save" >> $selection
		cat $selection
		sh postit.sh

	fi

	#Comment
	


fi

