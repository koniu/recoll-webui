%q = dict(query)
%def page_href(page):
	%q['page'] = page
	%return './results?%s' % urllib.urlencode(q)
%end
%if nres > 0:
	%import math, urllib
	%npages = int(math.ceil(nres/float(config['perpage'])))
	%if npages > 1:
		<div id="pages">
		<a title="First" class="page" href="{{page_href(1)}}">&#171;</a>
		<a title="Previous" class="page" href="{{page_href(max(1,query['page']-1))}}">&#8249;</a> &nbsp;
		%offset = ((query['page'])/10)*10
		%for p in range(max(1,offset), min(offset+10,npages+1)):
			%if p == query['page']:
				%cls = "page current"
			%else:
				%cls = "page"
			%end
			<a href="{{page_href(p)}}" class="{{cls}}">{{p}}</a>
		%end
		&nbsp; <a title="Next" class="page" href="{{page_href(min(npages, query['page']+1))}}">&#8250;</a>
		<a title="Last" class="page" href="{{page_href(npages)}}">&#187;</a>
		</div>
	%end
%end
