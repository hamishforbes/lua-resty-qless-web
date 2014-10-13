<script>
var fade = function(jid, type) {
  if (type == 'cancel' || type == 'untrack') {
    $('#job-' + jid).slideUp();
  }
}
</script>

<div class="subnav subnav-fixed">
  <ul class="nav nav-pills">
    <li class="active"><a href="#all" data-toggle="tab">All ({* #jobs['all'] *})</a></li>
    <li><a href="#running"   data-toggle="tab">Running ({*   #jobs['running'] *})</a></li>
    <li><a href="#waiting"   data-toggle="tab">Waiting ({* #jobs['waiting'] *})</a></li>
    <li><a href="#scheduled" data-toggle="tab">Scheduled ({* #jobs['scheduled'] *})</a></li>
    <li><a href="#stalled"   data-toggle="tab">Stalled ({* #jobs['stalled'] *})</a></li>
    <li><a href="#completed" data-toggle="tab">Completed ({* #jobs['complete'] *})</a></li>
    <li><a href="#failed"    data-toggle="tab">Failed ({* #jobs['failed'] *})</a></li>
	<li><a href="#depends"   data-toggle="tab">Depends ({* #jobs['depends'] *})</a></li>
  </ul>
</div>

<div id="alerts" style="margin-top: 40px"></div>

<div class="page-header">
  <h1>Tracked Jobs <small>These are all the jobs you're tracking</h1>
</div>

<div class="tab-content">
  <div class="tab-pane active" id="all">
    {% for _,job in ipairs(jobs['all']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="running">
    {% for _,job in ipairs(jobs['running']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="waiting">
    {% for _,job in ipairs(jobs['waiting']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="scheduled">
    {% for _,job in ipairs(jobs['scheduled']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="stalled">
    {% for _,job in ipairs(jobs['stalled']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="completed">
    {% for _,job in ipairs(jobs['complete']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="failed">
    {% for _,job in ipairs(jobs['failed']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
  <div class="tab-pane" id="depends">
    {% for _,job in ipairs(jobs['depends']) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
  </div>
</div>
