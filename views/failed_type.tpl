<div id="alerts"></div>

<div class="page-header">
  <div class="row">
    <div class="span8">
      <h2>Type '{* type *}' Failed Jobs <small>These jobs are all failed :-/</small></h2>
    </div>
    <div class="span4">
      <div class="btn-group" style="float:right; margin-top: 5px">
        <button class="btn btn-danger" title="cancel" onclick="confirmation(this, 'Cancel?', function() { cancelall('{* type *}', fade) })"><i class="icon-remove"></i></button>
        <button class="btn btn-success" title="retry all" onclick="retryall('{* type *}', fade)"><i class="icon-repeat"></i></button>
      </div>
    </div>
  </div>
</div>
    {% for _, job in ipairs(jobs) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}

{# erb :_job_list, :locals => { :jobs => failed.fetch('jobs'), :queues => queues } #}

