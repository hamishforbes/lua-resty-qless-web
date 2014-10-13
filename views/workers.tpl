<div class="page-header">
  <h1>Current Workers <small>And their job counts</small></h1>
</div>

{% for _, worker in ipairs(workers) do %}
<div class="row">
  <div class="span4">
    <h3><a href="{* uri_prefix *}/workers/{* worker['name'] *}">{{ worker['name'] }}</a></h3>
  </div>
  <div class="span8">
    <h3>| {* worker['jobs'] *} / {* worker['stalled'] *} <small>Running / Stalled</small></h3>
  </div>
</div>
{% end %}
