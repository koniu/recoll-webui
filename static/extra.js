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

function addOpenSearch()
{
  if (window.external && ("AddSearchProvider" in window.external)) {
      /* Build the url of the form http://host/osd.xml */
      var url = document.URL;
      var prefix = RegExp("^https\?://[^/]*/").exec(url);
      window.external.AddSearchProvider(prefix + "osd.xml");
  } else {
    alert("Your browser does not support OpenSearch search plugins.");
  }
}
