$(document).ready(function(){
	$("form").submit(function() {
		$("input").blur()
		$("#fade").height($("#searchbox").height()+1)
		$("#fade").fadeIn("slow")
	})
	if ($("#results").length) { $("input").blur() }
	$('input[name="after"]').jdPicker({});
	$('input[name="before"]').jdPicker();
})
