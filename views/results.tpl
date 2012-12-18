%import shlex, unicodedata
%def strip_accents(s): return ''.join((c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn'))
%include header title=" - " + query['keywords']+" ("+str(len(res))+")"
%include search query=query, dirs=dirs, sorts=sorts
<div id="status">
    <div id="found">
        Found <b>{{len(res)}}</b> matching: <b><i>{{qs}}</i></b>
        <small class="gray">({{time.seconds}}.{{time.microseconds/10000}}s)</small>
    </div>
    %if len(res) > 0:
        <div id="downloads">
            <a href="../json?{{query_string}}">JSON</a>
            <a href="../csv?{{query_string}}">CSV</a>
        </div>
    %end
</div>
<div id="results">
%for i in range(0, len(res)):
%d = res[i]
<div class="search-result">
    <div class="search-result-number"><a href="#r{{d['sha']}}">#{{i+1}}</a></div>
    <div class="search-result-title" id="r{{d['sha']}}" title="{{d['abstract']}}"><a href="{{d['url']}}">{{d['label']}}</a></div>
    %if len(d['ipath']) > 0:
        <div class="search-result-ipath">[{{d['ipath']}}]</div>
    %end
    %if  len(d['author']) > 0:
        <div class="search-result-author">{{d['author']}}</div>
    %end
    <div class="search-result-url">
        <a href="{{d['url'].replace('/'+d['filename'],'')}}">
            %urllabel = d['url'].replace('/'+d['filename'],'').replace('file://','')
            %for r in roots:
                %urllabel = urllabel.replace(r.rsplit('/',1)[0] + '/' , '')
            %end
            {{urllabel}}
        </a>
    </div>
    <div class="search-result-date">{{d['time']}}</div>
    %for q in shlex.split(query['keywords'].replace("'","\\'")):
        %if not q == "OR":
            % w = strip_accents(q.decode('utf-8').lower()).encode('utf-8')
            % d['snippet'] = d['snippet'].replace(w,'<span class="search-result-highlight">'+w+'</span>')
        %end
    %end
    <div class="search-result-snippet">{{!d['snippet']}}</div>
</div>
%end
</div>
%include footer
<!-- vim: fdm=marker:tw=80:ts=4:sw=4:sts=4:et:ai
-->
