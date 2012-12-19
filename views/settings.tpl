%include header title=" / settings"
<div id="settings-box">
<form action="set" method="get">
	<b>Find similar</b> <small class="gray">(1 or 0, show "squats" and "squatter")</small>
	<input name="stem" value={{stem}}><br><br>
	<hr>
	<b>Context words</b> <small class="gray">(number of words shown in search results)</small>
	<input name="context" value={{context}}><br><br>
	<b>Context characters</b> <small class="gray">(max characters in a snippet)</small>
	<input name="maxchars" value={{maxchars}}><br><br>
	<b>Time</b> <small class="gray">(time format string)</small>
	<input name="timefmt" value={{timefmt}}><br><br>
	<b>Folder depth</b> <small class="gray">(number of levels of the folder dropdown)</small>
	<input name="dirdepth" value={{dirdepth}}><br><br>
	<hr>
	<b>Locations</b><br>
	%for d in dirs:
		<small>{{d}}</small><input name="mount_{{d}}" value={{mounts[d]}}>
	%end
	<br><br><hr>
	<input type="submit" value="Save">
	<a href=".."><input type="button" value="Cancel"></a>
</form>
</div>
%include footer
