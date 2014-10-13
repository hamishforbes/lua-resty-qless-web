<div class="subnav subnav-fixed">
  <ul class="nav nav-pills">
    {% for _,f in ipairs(failed) do %}
    <li><a href="#{{ f['type'] }}" data-toggle="tab">{{ f['type'] }} ({{ f['total'] }})</a></li>
    {% end %}
  </ul>
</div>

<div id="alerts" style="margin-top: 40px"></div>

{% if not failed then %}
  <div class="page-header">
    <h1>No Failed Jobs <small>You Have Done Well!</small></h1>
  </div>
{% else %}
  <div class="page-header">
    <h1>Failed Jobs <small>Failure is a Part of Success!</small></h1>
  </div>
{% end %}

<div class="tab-content">
   {% for _,f in ipairs(failed) do %}
  <div class="tab-pane active" id="{{ f['type'] }}">
    <div class="page-header">
      <div class="row">
        <div class="span8">
          <h2>
            <a href="{* uri_prefix *}/failed/{* f['type'] *}">{{ f['type'] }}</a> | {* f['total'] *} <small>Jobs</small
          </h2>
        </div>
        <div class="span4">
          <div class="btn-group" style="float:right; margin-top: 5px">
            <button class="btn btn-danger" title="cancel" onclick="confirmation(this, 'Cancel?', function() { cancelall('{* f['type'] *}', fade) })"><i class="icon-remove"></i></button>
            <button class="btn btn-success" title="retry all" onclick="retryall('{* f['type'] *}', fade)"><i class="icon-repeat"></i></button>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="span12">
      {% for _, job in ipairs(f.jobs) do %}
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
  </div>
  {% end %}
</div>
