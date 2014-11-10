{% if job then %}
	<div class="row" id="job-{{ job.jid }}">
	  <div class="span12">
	    <div class="row">
	      <div class="span6">
	        <h2 style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden">
	          <a href="{* uri_prefix .. "/jobs/" ..job.jid *}">{{ string.sub(job.jid, 0, 8) }}...</a> | {{ job.klass }}
	        </h2>
	      </div>
	      <div class="span3">
	        <h2 style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden">
	          <strong>
	            | {{ job.state }} / <a href="{* uri_prefix .. "/queues/" .. job.queue_name *}">{{ job.queue_name }}</a>{{ job.worker_name  or  "" }}
	          </strong>
	        </h2>
	      </div>
	      <div class="span3">
	        <div style="float:right; margin-top: 4px">
	          <div class="btn-group">
	            {% if job.state ~= "complete" then %}
	            <button title="delete" class="btn btn-danger" onclick="confirmation(this, 'Delete?', function() { cancel('{{ job.jid }}', fade) })"><i class="icon-remove"></i></button>
	            {% end %}
	            {% if job.state == "running" then %}
	            <button title="Time out job" class="btn btn-danger" onclick="confirmation(this, 'Time out job?', function() { timeout('{{ job.jid }}') })"><i class="icon-time"></i></button>
	            {% end %}
	            <button title="track" class="btn{* (job.tracked) and " active" or "" *}" data-toggle="button" onclick="$(this).hasClass('active') ? untrack('{{ job.jid }}', fade) : track('{{ job.jid }}', [], fade)"><i class="icon-flag"></i></button>
	            {% if job.state == 'failed' then %}
	            <button title="requeue" class="btn btn-success" onclick="retry('{{ job.jid }}', fade)"><i class="icon-repeat"></i></button>
	            {% end %}
	            <button title="move" class="btn dropdown-toggle btn-success" data-toggle="dropdown">
	              <i class="caret"></i>
	            </button>
	            <ul class="dropdown-menu">
	              {% for _, queue in ipairs(job.raw_queue_history) do %}
	              <a href="#" onclick="move('{{ job.jid }}', '{{ queue['name'] }}', fade)">{{ queue['name'] }}</a>
	              {% end %}
	            </ul>
	          </div>
	        </div>
	        <div style="float:right; margin-right: 12px; margin-top: 4px">
	          <div class="btn-group">
	            <input class="span1 priority" type="text" placeholder="Pri {{ job.priority }}" onchange="priority('{{ job.jid }}', $(this).val())"></input>
					    <button class="btn dropdown-toggle" data-toggle="dropdown">
						    <i class="caret"></i>
	            </button>
	            <ul class="dropdown-menu">
				    	  <a href="#" onclick="priority('{{ job.jid }}',  25)">high</a>
	              <a href="#" onclick="priority('{{ job.jid }}',  0 )">normal</a>
	              <a href="#" onclick="priority('{{ job.jid }}', -25)">low</a>
	            </ul>
	          </div>
	        </div>
	      </div>
	    </div>

	    {% if job.dependencies then %}
	    <div class="row">
	      <div class="span12" style="margin-bottom: 10px">
	        <div style="float:left; margin-right: 10px"><h3>Dependencies:</h3></div>
	        {% for _, jid in ipairs(job.dependencies) do %}
	        <div class="btn-group" style="float:left; margin-right: 10px" id="{{job.jid}}-dependson-{{jid}}"">
	          <button class="btn" onclick="window.open('{* uri_prefix .. "/jobs/" .. jid *}', '_blank')">{{ string.sub(job.jid, 0, 8) }}...</button>
	          <button class="btn dropdown-toggle" onclick="confirmation(this, 'Undepend?', function() { undepend('{{ job.jid }}', '{* jid *}', function() { $('#{* job.jid *}-dependson-{{jid}}').remove()} ); })">
	            <i class="icon-remove"></i>
	          </button>
	        </div>
	        {% end %}
	      </div>
	    </div>
	    {% end %}

	    {% if job.dependents then %}
	    <div class="row">
	      <div class="span12" style="margin-bottom: 10px">
	        <div style="float:left; margin-right: 10px"><h3>Dependents:</h3></div>
	        {% for _, jid in ipairs(job.dependents) do %}
	        <div class="btn-group" style="float:left; margin-right: 10px" id="#{*job.jid*}-dependents-{*jid*}">
	          <button class="btn" onclick="window.open('{* uri_prefix .. "/jobs/" .. jid *}', '_blank')">{{ string.sub(job.jid, 0, 8) }}...</button>
	          <button class="btn dropdown-toggle" onclick="confirmation(this, 'Undepend?', function() { undepend('{* jid *}', '{{ job.jid }}', function() { $('#{* job.jid *}-dependents-{{jid}}") }}').remove()} ); })">
	            <i class="icon-remove"></i>
	          </button>
	        </div>
	        {% end %}
	      </div>
	    </div>
	    {% end %}

	    {% if job.tags then %}
	    <div class="row">
	      <div class="span12 tags" style="margin-bottom: 3px;">
	        {% for _, tag in ipairs(job.tags) do %}
	        <div class="btn-group" style="float:left">
	          <span class="tag">{{ tag }}</span>
				    <button class="btn" onclick="untag('{{ job.jid }}', '{{ tag }}')">
	            <i class="icon-remove"></i>
	          </button>
	        </div>
	        {% end %}

	        <!-- One for adding new tags -->
	        <div class="btn-group" style="float:left">
	          <input class="span1 add-tag" type="text" placeholder="Add Tag" onchange="tag('{{ job.jid }}', $(this).val())"></input>
				    <button class="btn" onclick="tag('{{ job.jid }}', $(this).parent().siblings().val())">
	            <i class="icon-plus"></i>
	          </button>
	        </div>
	      </div>
	    </div>
	    {% end %}

	    {% if not brief then %}
	    <div class="row">
	      <div class="span6">
	        <h3><small>Data</small></h3>
	        <pre style="overflow-y:scroll; height: 200px">{{ json_encode(job.data) }}</pre>
	      </div>
	      <div class="span6">
	        <h3><small>History</small></h3>
	        <div style="overflow-y:scroll; height: 200px">
	          {% for _,h in ipairs(job.raw_queue_history) do %}
	          {% if h['what'] == 'put' then %}
	          	<pre><strong>{{ h['what'] }}</strong> at {{ os.date("%c",h['when']) }}
    in queue <strong>{{ h['q'] }}</strong></pre>
	          {% elseif h['what'] == 'popped' then %}
	          	<pre><strong>{{ h['what'] }}</strong> at {{ os.date("%c",h['when']) }}
    by <strong>{{ h['worker'] }}</strong></pre>
	          {% elseif h['what'] == 'done' then %}
	          	<pre><strong>completed</strong> at {{ os.date("%c",h['when']) }}</pre>
	          {% elseif h['what'] == 'failed' then %}
	          	{% if h['worker'] then %}
	          	  <pre><strong>{{ h['what'] }}</strong> at {{ os.date("%c",h['when']) }}
    by <strong>{{ h['worker'] }}</strong>
    in group <strong>{{ h['group'] }}</strong></pre>
	          	{% else %}
	          	  <pre><strong>{{ h['what'] }}</strong> at {{ os.date("%c",h['when']) }}
    in group <strong>{{ h['group'] }}</strong></pre>
	          	{% end %}
	          {% else %}
	          	<pre><strong>{{ h['what'] }}</strong> at {{ os.date("%c",h['when']) }}</pre>
	          {% end %}
	          {% end %}
	        </div>
	      </div>
	    </div>
	    {% end %}

	    {% if job.failure and job.failure.when then %}
	    <div class="row">
	      <div class="span12">
	        <div class="alert alert-error">
	          <p>In <strong>{{ job.queue_name }}</strong> on <strong>{{ job.failure['worker'] }}</strong>
	            about {{ job.failure['when'] }}</p>
	          <pre>{{ job.failure['message'] }}</pre>
	        </div>
	      </div>
	    </div>
	    {% end %}
	    <hr/>
	  </div>
	</div>
{% else %} {# Recurring job #}
	<div class="row" id="job-{{ job.jid }}">
	  <div class="span12">
	    <div class="row">
	      <div class="span6">
	        <h2 style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden">
	          <a href="{* uri_prefix .. "/jobs/" .. job.jid *}">{{ string.sub(job.jid, 0, 8) }}...</a> | {{ job.klass }}
	        </h2>
	      </div>
	      <div class="span3">
	        <h2 style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden">
	          <strong>
	            | recurring / <a href="{* uri_prefix .. "/queues/" .. job.queue_name *}">{{ job.queue_name }}</a>
	          </strong>
	        </h2>
	      </div>
	      <div class="span3">
	        <div style="float:right; margin-top: 4px">
	          <div class="btn-group">
	            <button title="delete" class="btn btn-danger" onclick="confirmation(this, 'Delete?', function() { cancel('{{ job.jid }}', fade) })"><i class="icon-remove"></i></button>
	            <button title="move" class="btn dropdown-toggle btn-success" data-toggle="dropdown">
	              <i class="caret"></i>
	            </button>
	            <ul class="dropdown-menu">
	              {% for _,queue in ipairs(queues) do %}
	              <a href="#" onclick="move('{{ job.jid }}', '{{ queue['name'] }}', fade)">{{ queue['name'] }}</a>
	              {% end %}
	            </ul>
	          </div>
	        </div>
	        <div style="float:right; margin-right: 12px; margin-top: 4px">
	          <div class="btn-group">
	            <input class="span1 priority" type="text" placeholder="Pri {{ job.priority }}" onchange="priority('{{ job.jid }}', $(this).val())"></input>
      				<button class="btn dropdown-toggle" data-toggle="dropdown">
                <i class="caret"></i>
              </button>
	            <ul class="dropdown-menu">
				    	  <a href="#" onclick="priority('{{ job.jid }}',  25)">high</a>
	              <a href="#" onclick="priority('{{ job.jid }}',  0 )">normal</a>
	              <a href="#" onclick="priority('{{ job.jid }}', -25)">low</a>
	            </ul>
	          </div>
	        </div>
	      </div>
	    </div>

	    <div class="row">
	      <div class="span12 tags" style="margin-bottom: 3px;">
	        {% for _, tag in ipairs(job.tags) do %}
	        <div class="btn-group" style="float:left">
	          <span class="tag">{{ tag }}</span>
				    <button class="btn" onclick="untag('{{ job.jid }}', '{{ tag }}')">
	            <i class="icon-remove"></i>
	          </button>
	        </div>
	        {% end %}

	        <!-- One for adding new tags -->
	        <div class="btn-group" style="float:left">
	          <input class="span1 add-tag" type="text" placeholder="Add Tag" onchange="tag('{{ job.jid }}', $(this).val())"></input>
				    <button class="btn" onclick="tag('{{ job.jid }}', $(this).parent().siblings().val())">
	            <i class="icon-plus"></i>
	          </button>
	        </div>
	      </div>
	    </div>

	    {% if brief then %}
	    <div class="row">
	      <div class="span12">
	        <h3><small>Data</small></h3>
	        <pre style="overflow-y:scroll; height: 200px">{{ json_encode(job.data) }}</pre>
	      </div>
	    </div>
	    {% end %}
	    <hr/>
	  </div>
	</div>
{% end %}
