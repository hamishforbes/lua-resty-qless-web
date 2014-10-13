<div class="page-header">
  <h2>Jobs tagged '{* tag *}'</h2>
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

