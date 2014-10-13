<div class="subnav subnav-fixed">
  <ul class="nav nav-pills">
    <li><a href="#Running">Running</a></li>
    <li><a href="#Stalled">Stalled</a></li>
  </ul>
</div>

<div id="alerts" style="margin-top: 40px"></div>

{% if #worker['jobs'] > 0 then %}
  <div class="page-header">
    <h1>{* worker['name'] *} <small>Running Jobs</small></h1>
  </div>

  {% for _, job in ipairs(worker['jobs']) do %}
    {%
      local new_context = {job = job }
      for k,v in pairs(context) do
        new_context[k] = v
      end
    %}
    {* job_tpl(new_context) *}
  {% end %}
{% end %}

{% if #worker['stalled'] > 0 then %}
  <div class="page-header">
    <h1>{* worker['name'] *} <small>Stalled Jobs</small></h1>
  </div>

  {% for _, job in ipairs(worker['stalled']) do %}
    {%
      local new_context = {job = job }
      for k,v in pairs(context) do
        new_context[k] = v
      end
    %}
    {* job_tpl(new_context) *}
  {% end %}
{% end %}

{% if #worker['stalled'] + #worker['jobs'] == 0 then %}
  <div class="page-header">
    <h1>{* worker['name'] *} <small>Isn't Doing Anything</small></h1>
  </div>
{% end %}
