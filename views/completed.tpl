{% if jobs then %}
  <div class="page-header">
    <h1>No Completed Jobs<small>(yet)</small></h1>
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
{% else %}
  <div class="page-header">
    <h1>Completed Jobs <small>You must be doing something right!</small></h1>
  </div>
{% end %}


