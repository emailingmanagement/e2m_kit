function select_all_contacts() {
	checked = $('select_all').checked;
	$$('.contact_selected').each(function(cbx) { cbx.checked = checked });
}

function unckeck_select_all(cbx) {
	if(!cbx.checked) {
		$('select_all').checked = false
	}
}