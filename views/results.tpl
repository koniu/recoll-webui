%include header title=": " + query['query']+" ("+str(nres)+")"
%include search query=query, dirs=dirs, sorts=sorts
<div id="status">
    <div id="found">
        Found <b>{{nres}}</b> matching: <b><i>{{qs}}</i></b>
        <small class="gray">({{time.seconds}}.{{time.microseconds/10000}}s)</small>
    </div>
    %if len(res) > 0:
        <div id="downloads">
            <a href="./json?{{query_string}}">JSON</a>
            <a href="./csv?{{query_string}}">CSV</a>
        </div>
    %end
    <br style="clear: both">
</div>
%include pages query=query, config=config, nres=nres
<div id="results">
%for i in range(0, len(res)):
    %include result d=res[i], i=i, query=query, config=config,
%end
</div>
%include pages query=query, config=config, nres=nres
%include footer
<!-- vim: fdm=marker:tw=80:ts=4:sw=4:sts=4:et:ai
-->
