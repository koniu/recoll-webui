%import shlex, unicodedata, os
<div class="search-result">
    %number = (query['page'] - 1)*config['perpage'] + i + 1
    <div class="search-result-number"><a href="#r{{d['sha']}}">#{{number}}</a></div>
    %url = d['url'].replace('file://', '')
    %for dr, prefix in config['mounts'].items():
        %url = url.replace(dr, prefix)
    %end
    <div class="search-result-title" id="r{{d['sha']}}" title="{{d['abstract']}}">
    %if config.has_key('title_link') and config['title_link'] != 'download':
        %if config['title_link'] == 'open':
            <a href="{{url}}">{{d['label']}}</a>
        %elif config['title_link'] == 'preview':
            <a href="preview/{{number-1}}?{{query_string}}">{{d['label']}}</a>
        %end
    %else:
        <a href="download/{{number-1}}?{{query_string}}">{{d['label']}}</a>
    %end
    </div>
    %if len(d['ipath']) > 0:
        <div class="search-result-ipath">[{{d['ipath']}}]</div>
    %end
    %if d.has_key('author') and len(d['author']) > 0:
        <div class="search-result-author">{{d['author']}}</div>
    %end
    <div class="search-result-url">
        %urllabel = os.path.dirname(d['url'].replace('file://', ''))
        %for r in config['dirs']:
            %urllabel = urllabel.replace(r.rsplit('/',1)[0] + '/' , '')
        %end
        <a href="{{os.path.dirname(url)}}">{{urllabel}}</a>
    </div>
    <div class="search-result-links">
        <a href="{{url}}">Open</a>
        <a href="download/{{number-1}}?{{query_string}}">Download</a>
    %if hasrclextract:
        <a href="preview/{{number-1}}?{{query_string}}" target="_blank">Preview</a>
    %end
    </div>
    <div class="search-result-date">{{d['time']}}</div>
    <div class="search-result-snippet">{{!d['snippet']}}</div>
</div>
<!-- vim: fdm=marker:tw=80:ts=4:sw=4:sts=4:et:ai
-->
